#!/bin/bash

# MariaDBサーバーを起動する関数
start_mariadb() 
{
  mysqld --defaults-file=/etc/mysql/mariadb.conf.d/50-server.cnf --innodb_use_native_aio=0
}

# MariaDBの設定を行う関数
setup_mariadb() 
{
    sleep 2
    # Wait for MariaDB server to start
    while ! mysqladmin ping -h"$MYSQL_HOST" --silent; do
        echo "Waiting for database connection..."
        sleep 10
    done
    echo "mysqld is alive"

    # データベースを作成
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB_NAME}\` CHARACTER SET utf8 COLLATE utf8_general_ci;"

    # rootユーザーのパスワードを設定し、全権限を付与
    mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER_NAME}\`@'localhost' IDENTIFIED BY '${MYSQL_USER_PW}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DB_NAME}\`.* TO \`${MYSQL_USER_NAME}\`@'localhost';"
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;"
    mysql -e "SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PW}');"
    mysql -e "FLUSH PRIVILEGES;"

    # 一般ユーザーを作成し、指定のデータベースに対する権限を付与
    mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER_NAME}\`@'%' IDENTIFIED BY '${MYSQL_USER_PW}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DB_NAME}\`.* TO \`${MYSQL_USER_NAME}\`@'%';"
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
    mysql -e "SET PASSWORD FOR 'root'@'%'=PASSWORD('${MYSQL_ROOT_PW}');"
    mysql -e "FLUSH PRIVILEGES;"

    echo "MariaDB setup completed successfully!"
}


# バックグラウンドでMariaDBサーバーを起動
start_mariadb &

# MariaDBの設定を行う
setup_mariadb

# MariaDBサーバーが終了するまで待機
wait