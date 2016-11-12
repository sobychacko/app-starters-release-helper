#!/bin/bash

ARRAY=( "core:spring-cloud-stream-app-starters/core.git")

for repo in "${ARRAY[@]}" ; do
 KEY="${repo%%:*}"
 VALUE="${repo##*:}" 

 git clone git@github.com:$VALUE

 cd $KEY
 rm README.md
 git rm README.md 
 git commit "-amRemove README.md"
 git push origin master
 cd ..
 rm -rf $KEY
 printf "%s repo removed locally" "$KEY"
 sleep 3
done
