#/bin/bash
#sh ./init-cluster-env.sh
while [ 1 -eq 1 ]
do
read -t 60 -p "'1')Redis-Cluster '2')Mongodb-Cluster '3')Mariadb-Cluster '4')Zookeeper-Cluster '5')Kafka-Cluster 'q')Quit.Please choose: " choose
case $choose in
        '1')
                if [ ! $(docker ps -a | grep redis-cluster | wc -l) -eq 0 ]; then 
				echo "Redis-Cluster has been installed. Please uninstall it first!"
				continue
				fi
				echo "Creating Redis-Cluster..."
				cd ./redis-cluster
				sh install.sh
				cd ..
				;;
        '2')
				if [ ! $(docker ps -a | grep mongodb-cluster | wc -l) -eq 0 ]; then 
				echo "Mongodb-Cluster has been installed. Please uninstall it first!"
				continue
				fi
				echo "Creating Mongodb-Cluster..."
				cd ./mongodb-cluster
				sh install.sh
				cd ..
				;;
        '3')
                if [ ! $(docker ps -a | grep mariadb-cluster | wc -l) -eq 0 ]; then 
				echo "Mariadb-Cluster has been installed. Please uninstall it first!"
				continue
				fi
				echo "Creating Mariadb-Cluster..."
				cd ./mariadb-cluster
				sh install.sh
				cd ..
				;;
        '4')
                if [ ! $(docker ps -a | grep zookeeper-cluster | wc -l) -eq 0 ]; then 
				echo "Zookeeper-Cluster has been installed. Please uninstall it first!"
				continue
				fi
				echo "Creating Zookeeper-Cluster..."
				cd ./zookeeper-cluster
				sh install.sh
				cd ..
				;;
        '5')
                if [ ! $(docker ps -a | grep kafka-cluster | wc -l) -eq 0 ]; then 
				echo "Kafka-Cluster has been installed. Please uninstall it first!"
				continue
				fi
				if [ $(docker ps -a | grep zookeeper-cluster | wc -l) -eq 0 ]; then 
				echo "Kafka depend on Zookeeper! Please install Zookeeper first."
				continue
				fi
				
				echo "Creating Kafka-Cluster..."
				cd ./kafka-cluster
				sh install.sh
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
