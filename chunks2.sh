#!/bin/bash

ARRAY=(	"syslog:spring-cloud-stream-app-starter/syslog.git" 
	"file:spring-cloud-stream-app-starters/file.git" 
	"hdfs:spring-cloud-stream-app-starters/hdfs.git" 
	"http:spring-cloud-stream-app-starters/http.git" 
	"httpclient:spring-cloud-stream-app-starters/httpclient.git" 
	"app-starters-release:spring-cloud-stream-app-starters/app-starters-release.git")

for repo in "${ARRAY[@]}" ; do
 KEY="${repo%%:*}"
 VALUE="${repo##*:}" 

 git clone git@github.com:$VALUE

 cd $KEY
 rm README.md
 git rm README.md
 git commit "-amRemove Readme.adoc"
 git push origin master
 cd ..
 rm -rf $KEY
 printf "%s repo removed locally" "$KEY"
 sleep 3
done
