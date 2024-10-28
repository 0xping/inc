#!/bin/bash

sleep 5  # Initial sleep for MariaDB to start up properly

# Wait for MariaDB to be available
# until mariadb -h mariadb -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW DATABASES;" 2>/dev/null; do
#     echo "Waiting for MariaDB..."
#     echo $MYSQL_USER  $MYSQL_PASSWORD
#     sleep 2
# done

echo "MariaDB is available."

# Continue with the WordPress setup
wp --allow-root core download
wp config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --dbhost="mariadb" --allow-root
wp core install --url="https://aait-lfd.42.fr" --title="$WP_TITLE" --admin_name=$WP_ADMIN_NAME --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root
wp user create  $WORDPRESS_USER $WORDPRESS_USER_EMAIL --role=author --user_pass=$WORDPRESS_USER_PASSWORD --allow-root

mkdir -p "/run/php/"
php-fpm7.4 -F
