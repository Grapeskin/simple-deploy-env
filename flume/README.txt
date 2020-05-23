kafka-topics.sh --delete --bootstrap-server localhost:9092 --topic mytopic
kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic mytopic
kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic mytopic

insert into test(name, age) values("test1", 10);
insert into test(name, age) values("test2", 11);
insert into test(name, age) values("test3", 23);

insert into test(name, age) values("test4", 10);
insert into test(name, age) values("test5", 11);
insert into test(name, age) values("test6", 23);

insert into test(name, age) values("test7", 11);
insert into test(name, age) values("test8", 56);
insert into test(name, age) values("test9", 56);
