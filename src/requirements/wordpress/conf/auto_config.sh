#!/bin/bash

# MariaDBの起動を待つ
sleep 10

# wp-config.phpが存在しない場合のみ設定を行う
if [ ! -f /var/www/wordpress/wp-config.php ]; then
  # Create wp-config.php using WP-CLI
  wp config create --allow-root \
    --dbname=${MYSQL_DATABASE} \
    --dbuser=${MYSQL_USER} \
    --dbpass=${MYSQL_PASSWORD} \
    --dbhost=${MYSQL_HOST} \
    --path=/var/www/wordpress

  # Install WordPress core
  wp core install --allow-root \
    --url="http://localhost" \
    --title="My WordPress Site" \
    --admin_user="admin" \
    --admin_password="password" \
    --admin_email="admin@example.com" \
    --path=/var/www/wordpress

  # Create additional user
  wp user create --allow-root \
    user user@example.com \
    --user_pass="password" \
    --role=editor \
    --path=/var/www/wordpress
fi

# /run/phpディレクトリが存在しない場合は作成
mkdir -p /run/php

# php-fpmを実行
/usr/sbin/php-fpm8.0 -F