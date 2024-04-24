#!/bin/bash

# MariaDBサーバーを起動する関数
start_mariadb() 
{
  mysqld --defaults-file=/etc/mysql/mariadb.conf.d/50-server.cnf --innodb_use_native_aio=0
}

# MariaDBの設定を行う関数
setup_mariadb() 
{
  # Wait for MariaDB server to start
  while ! mysqladmin ping -h localhost --silent; do
    echo "Waiting for database connection..."
    sleep 5
  done

  echo "mysqld is alive"

  # データベースがなかったら作成する→基本的な設定を行うスクリプト（パスワードやルート権限等）
  mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB_NAME}\`;"
  
  # rootユーザーのパスワードをリセット
  mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PW}';"
  
  # 一般ユーザーを削除（存在する場合）
  mysql -e "DROP USER IF EXISTS \`${MYSQL_USER_NAME}\`@'localhost';"
  mysql -e "DROP USER IF EXISTS \`${MYSQL_USER_NAME}\`@'%';"
  
  # 一般ユーザーを作成
  mysql -e "CREATE USER \`${MYSQL_USER_NAME}\`@'localhost' IDENTIFIED BY '${MYSQL_USER_PW}';"
  mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DB_NAME}\`.* TO \`${MYSQL_USER_NAME}\`@'%';"
  mysql -e "FLUSH PRIVILEGES;"

  echo "MariaDB setup completed successfully!"
}

# バックグラウンドでMariaDBサーバーを起動
start_mariadb &

# MariaDBの設定を行う
setup_mariadb

# MariaDBサーバーが終了するまで待機
wait