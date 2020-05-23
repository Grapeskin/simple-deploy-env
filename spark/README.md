val textFile = sc.textFile("hdfs://hadoop-master:9000/test.txt")



val wordCount = textFile.flatMap(line => line.split(" ")).map(word => (word, 1)).reduceByKey((a, b) => a + b)
wordCount.collect()



cp scala-src-1.0-SNAPSHOT.jar /var/lib/docker/volumes/spark_mydata/_data/



spark-submit --class org.example.WordCount --master local /opt/data/scala-src-1.0-SNAPSHOT.jar



