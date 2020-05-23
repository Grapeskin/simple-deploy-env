#!/bin/bash
docker stack deploy redis-cluster --compose-file=docker-stack.yml
sleep 20s
#初始化集群
ips=()
for i in {1..6};do
ips[i]=$(docker inspect $(docker stack ps redis-cluster | grep redis-${i} | awk '{print $1}') -f "{{(index (index .NetworksAttachments 0).Addresses 0)}}" | awk -F '/' '{print $1}'):6379
done
command="echo yes | redis-cli --cluster create ${ips[@]} --cluster-replicas 1"
echo $command
docker exec -it $(docker ps | grep "redis-1" | awk '{ print $1 }') sh -c "${command}"
