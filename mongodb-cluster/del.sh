docker stack rm mongodb-cluster
local-ip=$(hostname -I)
for i in {1..3};do
	file-ip=$(cat ../conf/ips.conf | awk -F '=' 'print $2' | awk 'NR==$i')
    if [ $(echo $local-ip | grep $file-ip | wc -l) -gt 0 ]
    then
        runCount=$(docker ps | grep mongodb-cluster | wc -l)
        while [ $runCount -gt 0 ]
        do
            sleep 3s;
        done;
		docker volume rm mongodb-cluster_mongo-cs-data mongodb-cluster_mongo-shard0-data mongodb-cluster_mongo-shard1-data mongodb-cluster_mongo-shard2-data mongodb-cluster_mongos-data
	else
		ssh root@$(file-ip)   < < eof  
		runCount=$(docker ps | grep mongodb-cluster | wc -l)
        while [ $runCount -gt 0 ]
        do
            sleep 3s;
        done;
		docker volume rm mongodb-cluster_mongo-cs-data mongodb-cluster_mongo-shard0-data mongodb-cluster_mongo-shard1-data mongodb-cluster_mongo-shard2-data mongodb-cluster_mongos-data
		exit  
		eof  
	fi
done
