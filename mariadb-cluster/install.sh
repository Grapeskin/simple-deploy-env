#!/bin/bash
docker stack deploy mariadb-cluster -c docker-stack.yml
#docker stack deploy mariadb-cluster -c docker-stack-mariadb1.yml
#sleep 3s
#docker stack deploy mariadb-cluster -c docker-stack-mariadb2.yml
#sleep 3s
#docker stack deploy mariadb-cluster -c docker-stack-mariadb3.yml
sleep 20s
sed -i 's/safe_to_bootstrap: 0/safe_to_bootstrap: 1/g' /var/lib/docker/volumes/mariadb-cluster_mariadb-data/_data/grastate.dat

docker stack deploy mariadb-cluster -c haproxy-compose.yml
