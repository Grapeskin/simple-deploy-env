#!/bin/bash
docker exec -it $(docker ps | grep "mongos" | awk '{ print $1 }') bash -c "mongo << EOF
user admin
sh.addShard(\"shard0/shard01:27017,shard02:27017,shard03:27017\")
sh.addShard(\"shard1/shard11:27017,shard12:27017,shard13:27017\")
sh.addShard(\"shard2/shard21:27017,shard22:27017,shard23:27017\")
EOF
"

