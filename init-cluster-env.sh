#!/bin/bash
manager=$(cat ./conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==1")
worker1=$(cat ./conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==2")
worker2=$(cat ./conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==3")
param=""
echo "Initializing Node Cluster environment..."
if [ $(hostname -I | grep $manager | wc -l) -eq 0 ];then
	echo "You have must execute on first IP Machine...View the configuration file [./conf/ips.conf]"
	echo -e "\n"
	echo $(cat ./conf/ips.conf | awk -F '=' '{print $2}'| awk "NR==1")
	exit
fi
echo "firewall-cmd --permanent --add-port=2377/tcp --add-port=7946/tcp --add-port=4789/udp --add-port=7946/udp" >> ./temp-join-node.sh
echo "firewall-cmd --reload" >> ./temp-join-node.sh
echo "Initializing $manager..."
firewall-cmd --permanent --add-port=2377/tcp --add-port=7946/tcp --add-port=4789/udp --add-port=7946/udp
firewall-cmd --reload
result=`docker swarm init --advertise-addr 192.168.133.151 | grep "docker swarm join --token"`
echo $result >> ./temp-join-node.sh
scp ./temp-join-node.sh root@$worker1:/opt/
scp ./temp-join-node.sh root@$worker2:/opt/
rm -f ./temp-join-node.sh
echo "Initializing $worker1..."
ssh -t $worker1 bash -c "'
	sh /opt/temp-join-node.sh
	rm -f /opt/temp-join-node.sh
	exit
'"
echo "Initializing $worker2..."
ssh -t $worker2 bash -c "'
	sh /opt/temp-join-node.sh
	rm -f /opt/temp-join-node.sh
	exit
'"
if [ $(docker node ls | wc -l) -eq 4 ];then
	echo "Initialized Node Cluster environment success";
else
	echo "Initialized Node Cluster environment failed";
fi
