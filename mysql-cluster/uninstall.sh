#!/bin/bash
docker stack rm mysql-cluster
manager=$(cat ../conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==1")
worker1=$(cat ../conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==2")
worker2=$(cat ../conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==3")
sleep 10s
docker volume rm mysql-cluster_data mysql-cluster_conf
ssh -T $worker1 << EOF
	docker volume rm mysql-cluster_data
EOF
ssh -T $worker2 << EOF
	docker volume rm mysql-cluster_data 
EOF

