#!/bin/bash
docker stack rm zookeeper-cluster
manager=$(cat ../conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==1")
worker1=$(cat ../conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==2")
worker2=$(cat ../conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==3")
sleep 10s
docker volume rm zookeeper-cluster_zookeeper-data zookeeper-cluster_zookeeper-datalog zookeeper-cluster_zookeeper-log zookeeper-cluster_zookeeper-conf
ssh -T $worker1 << EOF
	docker volume rm zookeeper-cluster_zookeeper-data zookeeper-cluster_zookeeper-datalog zookeeper-cluster_zookeeper-log zookeeper-cluster_zookeeper-conf
EOF
ssh -T $worker2 << EOF
	docker volume rm zookeeper-cluster_zookeeper-data zookeeper-cluster_zookeeper-datalog zookeeper-cluster_zookeeper-log zookeeper-cluster_zookeeper-conf
EOF
