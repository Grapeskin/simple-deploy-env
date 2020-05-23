#!/bin/bash
docker service scale elasticsearch-cluster_nginx=0
docker service scale elasticsearch-cluster_kibana=0
docker service scale elasticsearch-cluster_logstash=0
docker service scale elasticsearch-cluster_es01=0
docker service scale elasticsearch-cluster_es02=0
docker service scale elasticsearch-cluster_es03=0
