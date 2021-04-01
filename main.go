package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

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

	http.HandleFunc("/foo", func(w http.ResponseWriter, r *http.Request) {
		log.Println("another request")
		fmt.Fprintf(w, "Hello, my host is %s, new version: %s", hostname, v)
	})

	log.Fatal(http.ListenAndServe(":8080", nil))
}
