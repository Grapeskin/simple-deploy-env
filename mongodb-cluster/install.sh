#!/bin/bash
#构建容器
docker stack deploy mongodb-cluster --compose-file=docker-stack.yml
sleep 30s
#初始化cs集群
docker exec -it $(docker ps | grep "cs1" | awk '{ print $1 }') bash -c "echo 'rs.initiate({_id: \"cs\",configsvr: true, members: [{ _id : 0, host : \"cs1\" },{ _id : 1, host : \"cs2\" }, { _id : 2, host : \"cs3\" }]})' | mongo"

echo "initializing cs...done"
#初始化shard0
docker exec -it $(docker ps | grep "shard01" | awk '{ print $1 }') bash -c "echo 'rs.initiate({_id : \"shard0\", members: [{ _id : 0, host : \"shard01\" },{ _id : 1, host : \"shard02\" },{ _id : 2, host : \"shard03\", arbiterOnly: true }]})' | mongo"

echo "initializing shard0...done"
#初始化shard1
docker exec -it $(docker ps | grep "shard11" | awk '{ print $1 }') bash -c "echo 'rs.initiate({_id : \"shard1\", members: [{ _id : 0, host : \"shard11\" },{ _id : 1, host : \"shard12\" },{ _id : 2, host : \"shard13\", arbiterOnly: true }]})' | mongo"

echo "initializing shard1...done"
#初始化shard2
docker exec -it $(docker ps | grep "shard21" | awk '{ print $1 }') bash -c "echo 'rs.initiate({_id : \"shard2\", members: [{ _id : 0, host : \"shard21\" },{ _id : 1, host : \"shard22\" },{ _id : 2, host : \"shard23\", arbiterOnly: true }]})' | mongo"

echo "initializing shard2...done"
#数据集群加入mongos
sleep 30s
docker exec -it $(docker ps | grep "mongos" | awk '{ print $1 }') bash -c "mongo << EOF 
user admin
sh.addShard(\"shard0/shard01:27017,shard02:27017,shard03:27017\")
sh.addShard(\"shard1/shard11:27017,shard12:27017,shard13:27017\")
sh.addShard(\"shard2/shard21:27017,shard22:27017,shard23:27017\")
EOF
"
echo "initializing mongos...done"
