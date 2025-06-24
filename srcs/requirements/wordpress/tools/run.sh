#!/bin/bash

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root
sleep 10

wp config create \
    --dbname=${DB_NAME} \
    --dbuser=${DB_USER} \
    --dbpass=${DB_PASSWORD} \
    --dbhost=${WP_DB_HOST} \
    --allow-root

sed -i "/\/\* That's all, stop editing! Happy publishing. \*\//i define( 'WP_CONTENT_DIR', __DIR__ . '/wp-content' );" /var/www/html/wp-config.php
sed -i "/\/\* That's all, stop editing! Happy publishing. \*\//i define( 'WP_CONTENT_URL', 'https://' . \$_SERVER['HTTP_HOST'] . '/wp-content' );" /var/www/html/wp-config.php

wp plugin install redis-cache --activate --allow-root
wp plugin activate redis-cache --allow-root
wp redis enable --allow-root

sed -i "/\/\* That's all, stop editing! Happy publishing. \*\//i define( 'WP_REDIS_HOST', '${WP_REDIS_HOST}' );" /var/www/html/wp-config.php
sed -i "/\/\* That's all, stop editing! Happy publishing. \*\//i define( 'WP_REDIS_PORT', '${WP_REDIS_PORT}' );" /var/www/html/wp-config.php
sed -i "/\/\* That's all, stop editing! Happy publishing. \*\//i define( 'WP_CACHE', true );" /var/www/html/wp-config.php
sed -i "/\/\* That's all, stop editing! Happy publishing. \*\//i define( 'WP_REDIS_DISABLED', false );" /var/www/html/wp-config.php
sed -i "/\/\* That's all, stop editing! Happy publishing. \*\//i define( 'WP_REDIS_OBJECT_CACHE', true );" /var/www/html/wp-config.php
sed -i "/\/\* That's all, stop editing! Happy publishing. \*\//i define( 'WP_REDIS_DEBUG', true );" /var/www/html/wp-config.php

wp core install \
    --url=${WP_CACHE_KEY_SALT} \
    --title=${WP_TITLE} \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PASSWORD} \
    --admin_email=${WP_ADMIN_EMAIL} \
    --allow-root

wp user create ${WP_USER} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD} --allow-root

exec "$@"
