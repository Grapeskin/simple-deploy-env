#!/bin/bash
manager=$(cat ./conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==1")
worker1=$(cat ./conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==2")
worker2=$(cat ./conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==3")
ssh -t $worker1 "docker swarm leave"
ssh -t $worker2 "docker swarm leave"
sleep 20s
docker swarm leave --force
echo "Delete Node Cluster environment success"
