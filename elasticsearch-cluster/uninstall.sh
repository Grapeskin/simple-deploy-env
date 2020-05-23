#!/bin/bash
docker stack rm elasticsearch-cluster
manager=$(cat ../conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==1")
worker1=$(cat ../conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==2")
worker2=$(cat ../conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==3")
sleep 10s

docker volume rm elasticsearch-cluster_log elasticsearch-cluster_data elasticsearch-cluster_config elasticsearch-cluster_logstash-share elasticsearch-cluster_external-log-dir

ssh -t $worker1 bash -c "'
docker volume rm elasticsearch-cluster_log elasticsearch-cluster_data elasticsearch-cluster_config
'"

ssh -t $worker2 bash -c "'
docker volume rm elasticsearch-cluster_log elasticsearch-cluster_data elasticsearch-cluster_config  elasticsearch-cluster_nginx-log
'"
