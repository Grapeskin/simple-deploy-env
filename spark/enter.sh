docker exec -it $(docker ps | grep spark | awk '{print $1}') bash