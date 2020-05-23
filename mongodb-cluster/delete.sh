#!/bin/bash

docker stack rm mongodb-cluster
manager=$(cat ../conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==1")
worker1=$(cat ../conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==2")
worker2=$(cat ../conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==3")
sleep 10s
docker volume rm mongodb-cluster_mongo-cs-data mongodb-cluster_mongo-shard0-data mongodb-cluster_mongo-shard1-data mongodb-cluster_mongo-shard2-data mongodb-cluster_mongos-data
ssh -T $worker1 << EOF
	docker volume rm mongodb-cluster_mongo-cs-data mongodb-cluster_mongo-shard0-data mongodb-cluster_mongo-shard1-data mongodb-cluster_mongo-shard2-data mongodb-cluster_mongos-data
EOF
ssh -T $worker2 << EOF
	docker volume rm mongodb-cluster_mongo-cs-data mongodb-cluster_mongo-shard0-data mongodb-cluster_mongo-shard1-data mongodb-cluster_mongo-shard2-data mongodb-cluster_mongos-data
EOF