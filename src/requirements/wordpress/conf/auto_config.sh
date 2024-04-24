#!/bin/bash

# MariaDBの起動を待つ
sleep 10

tar -xzvf /tmp/wordpress-6.2.tar.gz -C /var/www/html/ >/dev/null && chmod -R 755 /var/www/html/wordpress


# wp-config.phpが存在しない場合のみ設定を行う
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
  # Create wp-config.php using WP-CLI
  wp config create --allow-root \
    --dbname=${MYSQL_DB_NAME} \
    --dbuser=${MYSQL_USER_NAME} \
    --dbpass=${MYSQL_USER_PW} \
    --dbhost=${MYSQL_USER_NAME} \
    --path=/var/www/html/wordpress

  # Install WordPress core
  wp core install --allow-root \
    --url="http://localhost" \
    --title="My WordPress Site" \
    --admin_user=${WP_ADMIN_NAME} \
    --admin_password=${WP_ADMIN_PASSWD} \
    --admin_email="admin@example.com" \
    --path=/var/www/html/wordpress

  # Create additional user
  wp user create --allow-root \
    user user@example.com \
    --user_pass=${WP_EDITOR_PASSWD} \
    --role=editor \
    --path=/var/www/html/wordpress
fi

# /run/phpディレクトリが存在しない場合は作成
mkdir -p /run/php

# php-fpmを実行
/usr/sbin/php-fpm8.0 -F