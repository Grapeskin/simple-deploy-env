#!/bin/bash
docker stack deploy hbase-cluster -c docker-stack.yml
docker stack deploy hbase-cluster -c haproxy-compose.yml