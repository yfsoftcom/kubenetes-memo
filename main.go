package main

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/go-redis/redis/v8"
)

var ctx = context.Background()

func main() {
	hostname, err := os.Hostname()
	if err != nil {
		hostname = "Unknown"
	}
	f, err := os.OpenFile("./logs/"+hostname+".log", os.O_RDWR|os.O_CREATE|os.O_APPEND, 0666)
	if err != nil {
		log.Fatalf("error opening file: %v", err)
	}
	defer f.Close()

	log.SetOutput(f)
	log.Println("This is a test log entry")

	v := os.Getenv("version")
	log.Printf("hi there, i am from %s", hostname)

	rdb := redis.NewClient(&redis.Options{
		Addr:     os.Getenv("redis_addr"),
		Password: os.Getenv("redis_pass"), // no password set
		DB:       0,                       // use default DB
	})

	http.HandleFunc("/foo", func(w http.ResponseWriter, r *http.Request) {
		err := rdb.Incr(ctx, "foo:counter").Err()
		if err != nil {
			log.Println(err)
		}
		fmt.Fprintf(w, "Hello, my host is %s, new version: %s", hostname, v)
	})

	http.HandleFunc("/reset", func(w http.ResponseWriter, r *http.Request) {
		err := rdb.Del(ctx, "foo:counter").Err()
		if err != nil {
			log.Println(err)
		}
		fmt.Fprintf(w, "Ok")
	})

	log.Fatal(http.ListenAndServe(":8080", nil))
}
