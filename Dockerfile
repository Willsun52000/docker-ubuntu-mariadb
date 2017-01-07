FROM zercle/docker-ubuntu
MAINTAINER bouroo <bouroo@gmail.com>

# Update OS
RUN	apt update && apt -y full-upgrade

# Install mariaDB
RUN	echo "deb [arch=amd64,i386] http://mirrors.digitalocean.com/mariadb/repo/10.1/ubuntu/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/mariadb.list && \
	apt-key adv --recv-keys --keyserver keyserver.ubuntu.com F1656F24C74CD1D8 && \
	apt update && apt -y install mariadb-server && \
	systemctl enable mariadb.service

# Clean file
RUN	apt-get autoclean

# Listen remote client
RUN	sed -i "s|127.0.0.1|0.0.0.0|" /etc/mysql/my.cnf && \
	sed -i 's|.*skip-external-locking.*|event_scheduler = ON\n&|' /etc/mysql/my.cnf
#	sed -i 's|.*skip-external-locking.*|default-time-zone = "+07:00"\n&|' /etc/mysql/my.cnf

COPY	./files /
RUN	chmod +x /root/entrypoint.sh

# Config mariaDB and php-fpm
RUN	chmod 0664 /etc/mysql/conf.d/mariadb.cnf

EXPOSE	22 3306

VOLUME	["/var/lib/mysql", "/var/log/mysql"]

ENTRYPOINT	["/root/entrypoint.sh"]
