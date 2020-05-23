#!/bin/bash
docker stack deploy hdfs-cluster -c docker-stack.yml
sleep 3s
docker exec -it $(docker ps | grep hadoop-master | awk '{print $1}') bash "/root/start-hadoop.sh"
docker stack deploy hdfs-cluster -c haproxy-compose.yml