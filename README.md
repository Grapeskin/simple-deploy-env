# 安装必读

## 安装docker环境

`yum install -y yum-utils device-mapper-persistent-data lvm2`

`yum-config-manager -y --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo`

`yum makecache fast && yum -y install docker-ce-18.06.1.ce`

- vim /etc/docker/daemon.json

`{
  "registry-mirrors": ["https://uoqip3nv.mirror.aliyuncs.com"]
}`



## 部署步骤（每台机器上需要有docker环境）：

1. 退出原有集群（如果已经加入集群了需要操作，没有则略过）

   - 所有worker节点执行docker swarm leave 
   - master节点执行docker swarm leave --force

2. 配置hostname，主机分别配置为**node1,、node2、node3**

   - master节点执行hostnamectl set-hostname node1
   - worker1节点执行hostnamectl set-hostname node2
   - worker2节点执行hostnamectl set-hostname node3
   - 退出当前终端重新登录到Linux

3. 配置node1到其他节点的免密登陆

   - master节点执行ssh-keygen
   - master节点执行ssh-copy-id root@xxx.xxx.x.xx，这里填写worker1节点具体地址，输入worker1节点密码
   - master节点执行ssh-copy-id root@xxx.xxx.x.xx，这里填写worker2节点具体地址，输入worker2节点密码

4. 初始化swarm集群环境

   - 关闭防火墙或（**每台机器**执行systemctl stop firewalld）或开放docker swarm通信端口（**每台机器**执行firewall-cmd --permanent --add-port=2377/tcp --add-port=7946/tcp --add-port=4789/udp --add-port=7946/udp）
   - master节点执行docker swarm init，然后将输出的docker swarm join...在每个worker节点执行，组建集群
   - master节点执行docker node ls，查看集群是否组建成功

   ------

   **以上并未做自动化配置、需要自己配置环境**

5. 修改配置文件conf/ips.conf（里面填入每台机器的ip）

6. 切换到具体要安装的组件文件夹中运行install.sh脚本文件安装

7. 运行uninstall.sh或delete.sh脚本文件删除所有环境，如果删除数据卷过程提示正在使用删除失败，则需要再次精准删除进入到具体项目里面执行delete.sh或uninstall.sh，也可以再执行一次uninstall.sh，这里的删除会连同所有数据一起删除，如果只想删除容器而不删除数据则不执行安装脚本，手动执行docker stack rm xxx，这里的xxx是具体stack的名字，如docker stack rm redis-cluster，手动启动则切换到要启动的组件目录中手动执行docker stack deploy xxx -c docker-stack.yml，如docker stack deploy redis-cluster -c docker-stack.yml。

8. **建议不要执行此目录下的脚本安装或卸载，该脚本还要整理，没有兼容后面加入的一些配置，所以建议切换到具体目录中去执行install.sh安装。**

   

## 简要说明

install.sh：一键部署安装

uninstall.sh：一键卸载，连同数据全部删除

delete.sh：删除容器，数据还在

start.sh：启动容器，自动载入之前的数据

stop.sh：关闭容器，会删除容器不会删除数据
