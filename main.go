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
	v := os.Getenv("version")
	fmt.Printf("hi there, i am from %s", hostname)

	http.HandleFunc("/foo", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Hello, my host is %s, version: %s", hostname, v)
	})

	log.Fatal(http.ListenAndServe(":8080", nil))
}