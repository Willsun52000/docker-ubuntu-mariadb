FROM zercle/docker-ubuntu
MAINTAINER bouroo <bouroo@gmail.com>

# Add locale
RUN locale-gen en_US.UTF-8 && locale-gen th_TH.UTF-8 && dpkg-reconfigure locales

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV TZ Asia/Bangkok

# Update OS
RUN apt-get update && apt-get dist-upgrade -y

# Install mariaDB
RUN echo "deb [arch=amd64,i386] http://mirrors.bestthaihost.com/mariadb/repo/10.1/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/mariadb.list && \
	apt-key adv --recv-keys --keyserver keyserver.ubuntu.com F1656F24C74CD1D8 && \
	apt-get update && apt-get -y install mariadb-server

# Clean file
RUN apt-get autoclean

# Listen remote client
RUN sed -i "s|127.0.0.1|0.0.0.0|" /etc/mysql/my.cnf

COPY ./files /
RUN chmod +x /root/run-server.sh

# Config mariaDB and php-fpm
RUN chmod 0664 /etc/mysql/conf.d/mariadb.cnf

EXPOSE 22 3306

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/root/run-server.sh"]
