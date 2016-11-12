#!/bin/bash

ARRAY=( "time:spring-cloud-stream-app-starters/time.git")

for repo in "${ARRAY[@]}" ; do
 KEY="${repo%%:*}"
 VALUE="${repo##*:}" 

 git clone git@github.com:$VALUE

 cd $KEY
 touch README.adoc
 git add README.adoc
 git commit "-amREADME.adoc"
 git push origin master
 cd ..
 rm -rf $KEY
 printf "%s repo removed locally" "$KEY"
 sleep 3
done
