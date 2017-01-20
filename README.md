# docker-ubuntu-mariadb
Ubuntu + mariaDB

## Run
Ports: mysqld 3306/tcp, cluster 4444/tcp 4567/tcp 4568/tcp 4567/udp

	docker run -d \
	--restart=always \
	-v /var/lib/mysql:/var/lib/mysql \
	-v /var/log/mysql:/var/log/mysql \
	-p 3306:3306 \
	-p 4444:4444 \
	-p 4567:4567 \
	-p 4568:4568 \
	-p 4567:4567/udp \
	-h mariadb \
	--name mariadb \
	zercle/docker-ubuntu-mariadb
