#/bin/bash
ips=$(cat ./conf/ips.conf | awk -F '=' '{print $2}')
while [ 1 -eq 1 ]
do
read -t 60 -p "'1')Redis-Cluster '2')Mongodb-Cluster '3')Mariadb-Cluster '4')Zookeeper-Cluster '5')Kafka-Cluster 'q')Quit. Please choose: " choose
case $choose in
        '1')
                if [ $(docker ps -a | grep redis-cluster | wc -l) -eq 0 ]; then 
				echo "Redis-Cluster was not installed. Please install it first!"
				continue
				fi
				echo "Beginning uninstall Redis-Cluster..."
				cd ./redis-cluster
				sh stop.sh
				sleep 3s
				for ip in $ips; do
					ssh -t $ip bash -c "'
					docker volume rm redis-cluster_data-1 redis-cluster_data-2 redis-cluster_log-1 redis-cluster_log-2
					echo "Redis is already deleted from $ip !"
					'"
				done
				cd ..
				;;
        '2')
				if [ $(docker ps -a | grep mongodb-cluster | wc -l) -eq 0 ]; then 
				echo "Mongodb-Cluster was not installed. Please install it first!"
				continue
				fi
				echo "Beginning uninstall Mongodb-Cluster..."
				cd ./mongodb-cluster
				sh stop.sh
				sleep 3s
				for ip in $ips; do
					ssh -t $ip bash -c "'
					docker volume rm mongodb-cluster_mongo-cs-data mongodb-cluster_mongo-shard0-data mongodb-cluster_mongo-shard1-data mongodb-cluster_mongo-shard2-data mongodb-cluster_mongos-data
					echo "Mongodb is already deleted from $ip !"
					'"
				done
				cd ..
				;;
        '3')
                if [ $(docker ps -a | grep mariadb-cluster | wc -l) -eq 0 ]; then 
				echo "Mariadb-Cluster was not installed. Please install it first!"
				continue
				fi
				echo "Beginning uninstall Mariadb-Cluster..."
				cd ./mariadb-cluster
				sh stop.sh
				sleep 3s
				for ip in $ips; do
					ssh -t $ip bash -c "'
					docker volume rm mariadb-cluster_mariadb-data
					echo "Mariadb is already deleted from $ip !"
					'"
				done
				cd ..
				;;
        '4')
                if [ $(docker ps -a | grep zookeeper-cluster | wc -l) -eq 0 ]; then 
				echo "Zookeeper-Cluster was not installed. Please install it first!"
				continue
				fi
				if [ ! $(docker ps -a | grep kafka-cluster | wc -l) -eq 0 ]; then 
				echo "Kafka-Cluster depend on Zookeeper. Please uninstall kafka first!"
				continue
				fi
				echo "Beginning uninstall Zookeeper-Cluster..."
				cd ./zookeeper-cluster
				sh stop.sh
				sleep 3s
				for ip in $ips; do
					ssh -t $ip bash -c "'
					docker volume rm zookeeper-cluster_zookeeper-data zookeeper-cluster_zookeeper-datalog zookeeper-cluster_zookeeper-log zookeeper-cluster_zookeeper-conf
					echo "Zookeeper is already deleted from $ip !"
					'"
				done
				cd ..
				;;
        '5')
                if [ $(docker ps -a | grep kafka-cluster | wc -l) -eq 0 ]; then 
				echo "Kafka-Cluster was not installed. Please install it first!"
				continue
				fi
				
				echo "Beginning uninstall Kafka-Cluster..."
				cd ./kafka-cluster
				sh stop.sh
				sleep 3s
				for ip in $ips; do
					ssh -t $ip bash -c "'
					docker volume rm kafka-cluster_kafka-data
					echo "Kafka is already deleted from $ip !"
					'"
				done
				cd ..
				;;
        'q')
                echo "Good Bye."
                break
				;;
        *)
                echo "Error, Please Enter correct charactor."
				;;
esac
done
