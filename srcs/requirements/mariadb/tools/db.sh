#!/bin/bash

# Check if the MariaDB data directory is empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql
fi

# Start MariaDB
service mariadb start

# Wait for MariaDB to start
sleep 5

# Create database and user if they do not exist
mysql -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;"
mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -e "GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';"
mysql -e "FLUSH PRIVILEGES;"

# Stop MariaDB
service mariadb stop

# Start the MariaDB daemon
exec mysqld
