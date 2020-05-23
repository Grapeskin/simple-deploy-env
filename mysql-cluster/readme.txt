mycat分库分表、数据库主从复制
mysql1(master)
mysql2(slave1)
mysql3(slave2)
1.初始化mysql主从复制集群
【master】
docker exec -it $(docker ps | grep mysql:5| awk '{print $1}') bash
mysql -uroot -p123456
show master status;
查看输出的log文件和position
【slave1、slave2】
docker exec -it $(docker ps | grep mysql:5| awk '{print $1}') bash
mysql -uroot -p123456
此处的日志文件和position填入上面的master的
change master to master_host='mysql1', master_user='root', master_password='123456', master_log_file='mysql-bin.000003',master_log_pos=154;
start slave;
show slave status;
当看到Slave has read all relay log这句话时说明已经连上了master开始同步了

2.初始化数据库、表
【master】
create database dbtablesplite;
create database readwritesplite;
查看slave中有无同步readwritesplite表，若无，则说明未连接上master，需重复上面操作看是否失误
CREATE TABLE `readwritesplite`.`teset`( `id` INT NOT NULL, `desc` VARCHAR(64), PRIMARY KEY (`id`) ) ENGINE=INNODB CHARSET=utf8;
CREATE TABLE `dbtablesplite`.`test`( `id` INT NOT NULL, `name` VARCHAR(64), PRIMARY KEY (`id`) ) ENGINE=INNODB CHARSET=utf8;
【slave1、slave2】
create database dbtablesplite;
CREATE TABLE `dbtablesplite`.`test`( `id` INT NOT NULL, `name` VARCHAR(64), PRIMARY KEY (`id`) ) ENGINE=INNODB CHARSET=utf8;

3.验证分库分表、读写分离
往表里添加数据，查看mycat服务的日志输出
