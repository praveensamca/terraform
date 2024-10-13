package main

import (
	"html/template"
	"io/ioutil"
	"os"
	"strings"
)

type Sam struct {
	Aws_access_key_id string
	Aws_secret_access_key string
}

func main() {
    key := Sam{}
   
	dat, err := ioutil.ReadFile("/home/praveen.sambath/.aws/credentials")
	 if err == nil {
		content:=strings.Split(string(dat), "\n")
		for i:=0;i<len(content);i++{

			if strings.Contains(content[i],"=") {
				if strings.Contains(content[i],"aws_access_key_id") {
					key.Aws_access_key_id=strings.TrimSpace(strings.Split(content[i], "=")[1])
				} else if strings.Contains(content[i],"aws_secret_access_key") {
					key.Aws_secret_access_key=strings.TrimSpace(strings.Split(content[i], "=")[1])
				}

			}
		}
		
	}
	var tmplFile = "sampy.tmpl"
	tmpl, err := template.ParseFiles(tmplFile)
	if err != nil {
		panic(err)
	}
	err = tmpl.Execute(os.Stdout,key )
	if err != nil {
		panic(err)
	}
}
