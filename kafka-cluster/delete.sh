#!/bin/bash
docker stack rm kafka-cluster
manager=$(cat ../conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==1")
worker1=$(cat ../conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==2")
worker2=$(cat ../conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==3")
sleep 10s
docker volume rm kafka-cluster_kafka-data 
ssh -T $worker1 << EOF
	docker volume rm kafka-cluster_kafka-data 
EOF
ssh -T $worker2 << EOF
	docker volume rm kafka-cluster_kafka-data 
EOF


