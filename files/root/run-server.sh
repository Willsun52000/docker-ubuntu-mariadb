#!/usr/bin/env bash

chown -R www-data:www-data /srv/*

if [ ! -d /var/lib/mysql/mysql ]; then
	mysql_install_db
fi

chown mysql:mysql -R /var/lib/mysql

#service supervisor start
service ssh start
service rsyslog start
service mysql start
service cron start

openssl dhparam -dsaparam -out /etc/nginx/dhparam.pem 4096

tail -f /dev/null
