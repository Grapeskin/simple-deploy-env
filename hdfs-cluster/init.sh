service ssh start
if [ `hostname` = "hadoop-master" ];then
    touch /usr/local/hadoop/logs/hadoop-root-namenode-hadoop-master.log
    tail -f /usr/local/hadoop/logs/hadoop-root-namenode-hadoop-master.log
fi
if [ `hostname` = "hadoop-slave1" ];then
    touch /usr/local/hadoop/logs/hadoop-root-datanode-hadoop-slave1.log
    tail -f /usr/local/hadoop/logs/hadoop-root-datanode-hadoop-slave1.log
fi
if [ `hostname` = "hadoop-slave2" ];then
    touch /usr/local/hadoop/logs/hadoop-root-datanode-hadoop-slave2.log
    tail -f /usr/local/hadoop/logs/hadoop-root-datanode-hadoop-slave2.log
fi

