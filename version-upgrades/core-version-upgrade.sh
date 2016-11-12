#!/bin/bash


git clone git@github.com:spring-cloud-stream-app-starters/core.git
cd core
./mvnw versions:set -DnewVersion=1.1.0.RC1 -DgenerateBackupPoms=false
./mvnw versions:set -DnewVersion=1.1.0.RC1 -DgenerateBackupPoms=false -pl :app-starters-core-dependencies
lines=$(find . -type f -name pom.xml | xargs grep SNAPSHOT | wc -l)
if [ $lines -eq 0 ]; then
	git commit -am"Upgarding to release version 1.1.0.RC1"
	git push origin master
	git tag -a v1.1.0.RC1 -m"1.1.0.RC1 tag"
        git push origin v1.1.0.RC1
        ./mvnw versions:set -DnewVersion=1.1.0.BUILD-SNAPSHOT -DgenerateBackupPoms=false
	./mvnw versions:set -DnewVersion=1.1.0.BUILD-SNAPSHOT -DgenerateBackupPoms=false -pl :app-starters-core-dependencies
	git commit -am"Next update version"
 	git push origin master
else
	echo "Snapshots found. Aborting the release build."
fi

cd ..
rm -rf core

