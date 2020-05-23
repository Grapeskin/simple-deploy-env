#!/bin/bash
\cp -f scala-src-1.0-SNAPSHOT.jar /var/lib/docker/volumes/spark_mydata/_data/
docker exec -it $(docker ps | grep spark | awk '{print $1}') spark-submit --class org.example.WordCount --master local /opt/data/scala-src-1.0-SNAPSHOT.jar