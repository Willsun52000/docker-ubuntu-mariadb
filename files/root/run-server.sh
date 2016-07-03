#!/usr/bin/env bash

if [ ! -d /var/lib/mysql/mysql ]; then
	mysql_install_db

	# mysql_secure_installation
	USER=$(grep -m 1 user /etc/mysql/debian.cnf | cut -d= -f2 | tr -d "[[:space:]]")
	PASSWD=$(grep -m 1 password /etc/mysql/debian.cnf | cut -d= -f2 | tr -d "[[:space:]]")
	mysql -e "DELETE FROM mysql.user WHERE User='';"
	#mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
	mysql -e "DROP DATABASE IF EXISTS test;"
	mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
	mysql -e "FLUSH PRIVILEGES"
fi

chown mysql:mysql -R /var/lib/mysql
chown mysql:mysql -R /var/log/mysql

#service supervisor start
service ssh start
service rsyslog start
service mysql start
service cron start

tail -f /dev/null
