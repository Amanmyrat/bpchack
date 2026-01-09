package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"path/filepath"
)

func main() {
	port := "8080"
	if len(os.Args) > 1 {
		port = os.Args[1]
	}

	// Get the directory where the executable is located
	execDir, err := filepath.Abs(filepath.Dir(os.Args[0]))
	if err != nil {
		log.Fatal(err)
	}

	// Try to find the api directory
	apiDir := filepath.Join(execDir, "api")
	if _, err := os.Stat(apiDir); os.IsNotExist(err) {
		// Try current working directory
		if cwd, err := os.Getwd(); err == nil {
			apiDir = filepath.Join(cwd, "api")
		}
	}

	fmt.Printf("🚀 BPC Hack API Documentation Server\n")
	fmt.Printf("📁 Serving from: %s\n", apiDir)
	fmt.Printf("🌐 Open: http://localhost:%s/docs.html\n", port)
	fmt.Printf("📄 Raw YAML: http://localhost:%s/api/open_api.yaml\n", port)
	fmt.Printf("🔄 Press Ctrl+C to stop\n\n")

	// Serve static files
	fs := http.FileServer(http.Dir(execDir))
	http.Handle("/", fs)

	log.Printf("Server starting on :%s", port)
	log.Fatal(http.ListenAndServe(":"+port, nil))
}