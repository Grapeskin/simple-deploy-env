#!/bin/bash
docker stack rm redis-cluster
manager=$(cat ../conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==1")
worker1=$(cat ../conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==2")
worker2=$(cat ../conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==3")
sleep 10s
docker volume rm redis-cluster_data-1 redis-cluster_data-2 redis-cluster_log-1 redis-cluster_log-2
ssh -T $worker1 << EOF
	docker volume rm redis-cluster_data-1 redis-cluster_data-2 redis-cluster_log-1 redis-cluster_log-2
EOF
ssh -T $worker2 << EOF
	docker volume rm redis-cluster_data-1 redis-cluster_data-2 redis-cluster_log-1 redis-cluster_log-2
EOF
