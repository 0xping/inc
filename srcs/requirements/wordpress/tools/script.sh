#!/bin/bash

sleep 5  # Initial sleep for MariaDB to start up

# Continue with the WordPress setup
wp core download --allow-root
wp config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --dbhost="mariadb" --allow-root
wp core install --url="https://${LOGIN}.42.fr" --title="$WP_TITLE" --admin_name=$WP_ADMIN_NAME --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root
wp user create  $WORDPRESS_USER $WORDPRESS_USER_EMAIL --role=author --user_pass=$WORDPRESS_USER_PASSWORD --allow-root

mkdir -p /run/php/
php-fpm7.4 -F
