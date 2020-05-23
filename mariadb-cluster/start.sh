#!/bin/bash
 #filepath= echo $(docker inspect $(docker volume ls | grep mariadb-cluster | awk '{print $2}') -f "{{json .Mountpoint}}"/grastate.dat) | sed 's/\"//g'
 #if [ -f $filepath ]; then
 #	sed -i 's/safe_to_bootstrap: 0/safe_to_bootstrap: 1/g' /var/lib/docker/volumes/mariadb-cluster_mariadb-data/_data/grastate.dat
 #fi
 docker stack deploy mariadb-cluster -c docker-stack.yml
 sleep 10s

 sed -i 's/safe_to_bootstrap: 0/safe_to_bootstrap: 1/g' /var/lib/docker/volumes/mariadb-cluster_mariadb-data/_data/grastate.dat
