package main

import (
	"fmt"
	"net/http"
)

func reactApp(w http.ResponseWriter, r *http.Request) {
	http.ServeFile(w, r, "./client/build/"+r.URL.Path)
}

func main() {
	fmt.Printf("Running ManyPoint server\n")
	http.HandleFunc("/", reactApp)
	http.ListenAndServe(":4444", nil)
}
