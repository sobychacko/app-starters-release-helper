#!/bin/bash

ARRAY=( 
	"router:spring-cloud-stream-app-starters/router.git" 
	"scriptable-transform:spring-cloud-stream-app-starters/scriptable-transform.git" 
	"splitter:spring-cloud-stream-app-starters/splitter.git" 
	"aggregate-counter:spring-cloud-stream-app-starters/aggregate-counter.git" 
	"counter:spring-cloud-stream-app-starters/counter.git" 
	"tcp:spring-cloud-stream-app-starters/tcp.git" 
	"throughput:spring-cloud-stream-app-starters/throughput.git" 
	"field-value-counter:spring-cloud-stream-app-starters/field-value-counter.git" 
	"syslog:spring-cloud-stream-app-starters/syslog.git" 
	"file:spring-cloud-stream-app-starters/file.git" 
	"hdfs:spring-cloud-stream-app-starters/hdfs.git" 
	"http:spring-cloud-stream-app-starters/http.git" 
	"httpclient:spring-cloud-stream-app-starters/httpclient.git" 
	"jdbc:spring-cloud-stream-app-starters/jdbc.git" 
	"aws-s3:spring-cloud-stream-app-starters/aws-s3.git" 
	"bridge:spring-cloud-stream-app-starters/bridge.git" 
	"cassandra:spring-cloud-stream-app-starters/cassandra.git" 
	"jms:spring-cloud-stream-app-starters/jms.git" 
	"load-generator:spring-cloud-stream-app-starters/load-generator.git" 
	"log:spring-cloud-stream-app-starters/log.git" 
	"loggregator:spring-cloud-stream-app-starters/loggregator.git" 
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
	"time:spring-cloud-stream-app-starters/time.git" 
	"websocket:spring-cloud-stream-app-starters/websocket.git") 

for repo in "${ARRAY[@]}" ; do
  KEY="${repo%%:*}"
  VALUE="${repo##*:}" 

  git clone git@github.com:$VALUE

  cd $KEY

  ./mvnw versions:set -DnewVersion=1.1.0.RC1 -DgenerateBackupPoms=false
  ./mvnw versions:set -DnewVersion=1.1.0.RC1 -DgenerateBackupPoms=false -pl :$KEY-app-dependencies 
  ./mvnw versions:update-parent -DparentVersion=1.1.0.RC1 -Pspring -DgenerateBackupPoms=false

  lines=$(find . -type f -name pom.xml | xargs grep SNAPSHOT | wc -l)
  if [ $lines -eq 0 ]; then
        git commit -am"Upgarding to release version 1.1.0.RC1"
        git push origin master
        git tag -a v1.1.0.RC1 -m"1.1.0.RC1 tag"
        git push origin v1.1.0.RC1
        ./mvnw versions:set -DnewVersion=1.1.0.BUILD-SNAPSHOT -DgenerateBackupPoms=false
        ./mvnw versions:set -DnewVersion=1.1.0.BUILD-SNAPSHOT -DgenerateBackupPoms=false -pl :$KEY-app-dependencies
        git commit -am"Next update version"
        git push origin master
  else
        echo "Snapshots found. Aborting the release build."
  fi

  cd ..

  rm -rf $KEY
  printf "%s repo removed locally" "$KEY"
  sleep 3
done
