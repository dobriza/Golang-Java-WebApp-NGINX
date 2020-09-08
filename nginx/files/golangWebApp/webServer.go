package main

import (
	"fmt"
	"net/http"
)

func serveIndex(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, "Hello server!")
}

func main() {
	http.HandleFunc("/", serveIndex)
	http.ListenAndServe(":8010", nil)
}
