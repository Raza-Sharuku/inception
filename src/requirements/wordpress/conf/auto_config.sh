#!/bin/bash


# MariaDBの起動を待つ
while ! mysqladmin ping -h"$MYSQL_HOST" --silent; do
    echo "Waiting for database connection..."
    sleep 10
done

# wp-config.phpが存在しない場合のみ設定を行う
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then

  # 解凍
  # tar -xzvf /tmp/wordpress-6.2.tar.gz -C /var/www/html/ >/dev/null && chmod -R 755 /var/www/html/wordpress
  
  # Create wp-config.php using WP-CLI
  wp config create --allow-root \
    --dbname=${MYSQL_DB_NAME} \
    --dbuser=${MYSQL_USER_NAME} \
    --dbpass=${MYSQL_USER_PW} \
    --dbhost=${MYSQL_HOST} \
    --path=/var/www/html/wordpress \
    --allow-root

  # Install WordPress core
  wp core install --allow-root \
    --url="${SITE_DOMAIN_NAME}" \
    --title="inception" \
    --admin_user=${WP_ADMIN_NAME} \
    --admin_password=${WP_ADMIN_PASSWD} \
    --admin_email="admin@example.com" \
    --path=/var/www/html/wordpress \
    --allow-root

  # Create additional user
  wp user create --allow-root \
    --user=${WP_AUTHOR_NAME} \
    user@example.com \
    --user_pass=${WP_AUTHOR_PASSWD} \
    --role=author \
    --path=/var/www/html/wordpress \
    --allow-root

fi

mv /tmp/index.html /var/www/html/wordpress

# /run/phpディレクトリが存在しない場合は作成
mkdir -p /run/php

# php-fpmを実行
/usr/sbin/php-fpm8.0 -F