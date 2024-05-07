#!/bin/bash

sleep 1

# 解凍
tar -xzvf /tmp/wordpress-6.2.tar.gz -C /var/www/html/ >/dev/null && chmod -R 755 /var/www/html/wordpress
sleep 3
echo "Wordpress Unzipping completed"

# wp-config.phpが存在しない場合のみ設定を行う
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
  cd /var/www/html/wordpress

  # Create wp-config.php using WP-CLI
  wp config create --dbhost=mariadb --dbname=${MYSQL_DB_NAME} --dbuser=${MYSQL_USER_NAME} --dbpass=${MYSQL_USER_PW} --allow-root

  echo "Database : $MYSQL_DB_NAME"

  # Install WordPress core
  wp core install --url="${SITE_DOMAIN_NAME}" --title=${WP_SITE_TITLE} --admin_user=${WP_ADMIN_NAME} --admin_password=${WP_ADMIN_PASSWD} --admin_email="master@example.com" --allow-root

  # Create additional user
  wp user create "${WP_AUTHOR_NAME}" sraza@example.com --user_pass="${WP_AUTHOR_PASSWD}" --role=author --allow-root

  mv /tmp/index.html /var/www/html/wordpress/

  echo "wp-config.php Setting Completed"
fi

mkdir -p /var/run/php-fpm8
chown -R www-data:www-data /var/www/html/wordpress

# php-fpmを実行
/usr/sbin/php-fpm8.0 -F