#!/usr/bin/env bash

if [ ! -d /var/lib/mysql/mysql ]; then
	mysql_install_db

	# mysql_secure_installation
	USER=$(grep user /etc/mysql/debian.cnf | head -n1 | awk '{print $3}')
	PASSWD=$(grep password /etc/mysql/debian.cnf | head -n1 | awk '{print $3}')
	mysql -e "DELETE FROM mysql.user WHERE User='';"
	#mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
	mysql -e "DROP DATABASE IF EXISTS test;"
	mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
	mysql -e "FLUSH PRIVILEGES"
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${USER}'@'localhost' IDENTIFIED BY '${PASSWD}';"
	mysql -u root mysql < /etc/mysql/timezone_posix.sql
fi

chown mysql:mysql -R /var/lib/mysql
chown mysql:mysql -R /var/log/mysql

systemctl restart ssh
systemctl restart rsyslog
systemctl restart mysql
systemctl restart cron

tail -f /dev/null
