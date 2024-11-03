#!/bin/bash

# Start MariaDB
service mariadb start

# Wait for MariaDB to start
sleep 5

# Create database and user if they do not exist
mysql -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;"
mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -e "GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';"

# Stop MariaDB
service mariadb stop

# Start the MariaDB daemon
exec mysqld
