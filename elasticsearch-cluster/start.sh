#!/bin/bash
docker service scale elasticsearch-cluster_es01=1
docker service scale elasticsearch-cluster_es02=1
docker service scale elasticsearch-cluster_es03=1
docker service scale elasticsearch-cluster_logstash=1
docker service scale elasticsearch-cluster_kibana=1
docker service scale elasticsearch-cluster_nginx=1
