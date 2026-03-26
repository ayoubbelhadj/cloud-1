#!/bin/bash

mysqld_safe --skip-networking &

sleep 3

if [ ! -f /var/lib/mysql/.initialized ]; then
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
    mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
    touch /var/lib/mysql/.initialized
fi

mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

mysqld_safe --bind-address=0.0.0.0 --port=3306
