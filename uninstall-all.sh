#!/bin/bash
cd ./redis-cluster
sh delete.sh
cd ../mongodb-cluster
sh delete.sh
cd ../mariadb-cluster
sh delete.sh
cd ../kafka-cluster
sh delete.sh
cd ../zookeeper-cluster
sh delete.sh
cd ../hdfs-cluster
sh uninstall.sh
cd ../elasticsearch-cluster
sh uninstall.sh
cd ../hbase-cluster
sh uninstall.sh
cd ../app-deploy
sh uninstall.sh

#sh ./del-cluster-env.sh
