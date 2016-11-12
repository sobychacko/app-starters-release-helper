#!/bin/bash

ARRAY=( 
	"mail:spring-cloud-stream-app-starters/mail.git" 
	"mongodb:spring-cloud-stream-app-starters/mongodb.git" 
	"pmml:spring-cloud-stream-app-starters/pmml.git" 
	"redis-pubsub:spring-cloud-stream-app-starters/redis-pubsub.git" 
	"rabbit:spring-cloud-stream-app-starters/rabbit.git" 
	"filter:spring-cloud-stream-app-starters/filter.git" 
	"ftp:spring-cloud-stream-app-starters/ftp.git" 
	"sftp:spring-cloud-stream-app-starters/sftp.git" 
	"gemfire:spring-cloud-stream-app-starters/gemfire.git" 
	"gpfdist:spring-cloud-stream-app-starters/gpfdist.git" 
	"groovy-filter:spring-cloud-stream-app-starters/groovy-filter.git" 
	"groovy-transform:spring-cloud-stream-app-starters/groovy-transform.git" 
	"transform:spring-cloud-stream-app-starters/transform.git" 
	"tasklauncher-cloudfoundry:spring-cloud-stream-app-starters/tasklauncher-cloudfoundry.git" 
	"tasklauncher-yarn:spring-cloud-stream-app-starters/tasklauncher-yarn.git" 
	"tasklauncher-local:spring-cloud-stream-app-starters/tasklauncher-local.git" 
	"tasklaunchrequest-transform:spring-cloud-stream-app-starters/tasklaunchrequest-transform.git" 
	"trigger:spring-cloud-stream-app-starters/trigger.git" 
	"triggertask:spring-cloud-stream-app-starters/triggertask.git" 
	"twitter:spring-cloud-stream-app-starters/twitter.git" 
	"time:spring-cloud-stream-app-starters/time.git")

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
