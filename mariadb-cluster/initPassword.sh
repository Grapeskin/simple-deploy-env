#!/bin/bash
docker exec -it $(docker ps | grep mariadb1 | awk '{print $1}') bash
mysql -uroot
GRANT ALL PRIVILEGES ON *.* TO 'root' @'%' IDENTIFIED BY 'mariadb';
FLUSH PRIVILEGES;
exit
exit
echo -e '\n'
