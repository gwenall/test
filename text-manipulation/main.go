package main

// Author: Gwenall Pansier
// Purpose: To extract the content of a release note and only thanks contributors of bugs or features
// Comment: it's a silly topic, but it is to show how to manipulate some text

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"regexp"
	"sync"
)

type ReleaseNotes struct {
	FileName         string
	FileContent      []string
	ExtractedContent []string
	mu               sync.Mutex
}

// read a file line by line and populates a string array
func (r *ReleaseNotes) readFile() {
	file, err := os.Open(r.FileName)
	if err != nil {
		log.Fatal(err)
	}
	defer file.Close()

	//I googled for reading the file content with bufio as I didn't recall the syntax. That allows me to then use the Scan method to read the file line by line.
	bs := bufio.NewScanner(file)
	for bs.Scan() {
		r.FileContent = append(r.FileContent, bs.Text())
	}

	if err := bs.Err(); err != nil {
		log.Fatal(err)
	}
}

// substitution function to thanks contributors
func (r *ReleaseNotes) subsituteContent(line string, c chan string) {
	// using a mutext to keep the content ordered
	r.mu.Lock()
	defer r.mu.Unlock()
	var linePtr *string = &line
	// list of regex substitutions to be performed
	regList := [5][2]string{
		{`-help-`, ``},
		{`Don't`, `not`},
		{`^[^ ]* `, ``},
		{`<[^>]*>`, ``},
		{`([A-Za-z]*) (.*)\(([A-Za-z0-9]*)\)`, `Thanks to $3 for $1ing $2`},
	}
	// using a for loop to iterate over the array of regular expressions and replace the content
	for _, element := range regList {
		regexp := regexp.MustCompile(element[0])
		substitute := regexp.ReplaceAllString(*linePtr, element[1])
		linePtr = &substitute
	}

	c <- *linePtr
}

func main() {
	// I saw no point to use flags here, as this program is highly specific to the text.
	r := ReleaseNotes{"release-notes-litecoin.md", nil, nil, sync.Mutex{}}
	r.readFile()

	ch := make(chan string)
	chan_size := 0
	// Using goroutines for demo purposes
	for _, line := range r.FileContent {
		func(line string) {
			matched, _ := regexp.MatchString(`<li>#.*(feature|bug)`, line)
			if matched {
				go r.subsituteContent(line, ch)
				// I could have printed the content in the main function, but I wanted to show the use of channels.
				chan_size++
			}
		}(line)
	}

	// storing the results in a slice from the ExrtractedContent structure (for future reuse)
	for i := 0; i < chan_size; i++ {
		r.ExtractedContent = append(r.ExtractedContent, <-ch)
	}

	// printing the results
	for _, line := range r.ExtractedContent {
		fmt.Println(line)
	}
}
