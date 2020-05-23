docker stack rm hdfs-cluster
sleep 20s
manager=$(cat ../conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==1")
worker1=$(cat ../conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==2")
worker2=$(cat ../conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==3")
docker volume rm hdfs-cluster_config hdfs-cluster_datanode hdfs-cluster_logs hdfs-cluster_namenode
ssh -t $worker1 "docker volume rm hdfs-cluster_config hdfs-cluster_datanode hdfs-cluster_logs hdfs-cluster_namenode"
ssh -t $worker2 "docker volume rm hdfs-cluster_config hdfs-cluster_datanode hdfs-cluster_logs hdfs-cluster_namenode"
