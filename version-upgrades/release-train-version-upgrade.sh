#!/bin/bash


git clone git@github.com:spring-cloud-stream-app-starters/app-starters-release.git
cd app-starters-release
./mvnw versions:set -DnewVersion=Avogadro.RC1 -DgenerateBackupPoms=false
./mvnw versions:update-parent -DparentVersion=1.1.0.RC1 -Pspring -DgenerateBackupPoms=false

lines=$(find . -type f -name pom.xml | xargs grep SNAPSHOT | grep -v ".contains(" | grep -v regex | wc -l)
if [ $lines -eq 0 ]; then
	git commit -am"Upgarding to release version Avogadro.RC1"
	git push origin master
	git tag -a vAvogadro.RC1 -m"Avogadro.RC1 tag"
        git push origin vAvogadro.RC1
        ./mvnw versions:set -DnewVersion=Avogadro.BUILD-SNAPSHOT -DgenerateBackupPoms=false
	git commit -am"Next update version"
 	git push origin master
else
	echo "Snapshots found. Aborting the release build."
fi

cd ..
rm -rf app-starters-release 

