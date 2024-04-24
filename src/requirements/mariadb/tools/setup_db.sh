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

    # rootユーザーのパスワードを設定し、全権限を付与
    mysql -e "SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${MYSQL_ROOT_PW}');"
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;"
    mysql -e "FLUSH PRIVILEGES;"

    # データベースを作成
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB_NAME}\` CHARACTER SET utf8 COLLATE utf8_general_ci;"

    # 一般ユーザーを作成し、指定のデータベースに対する権限を付与
    mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER_NAME}\`@'localhost' IDENTIFIED BY '${MYSQL_USER_PW}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DB_NAME}\`.* TO \`${MYSQL_USER_NAME}\`@'localhost';"
    mysql -e "FLUSH PRIVILEGES;"

    echo "MariaDB setup completed successfully!"
}


# バックグラウンドでMariaDBサーバーを起動
start_mariadb &

# MariaDBの設定を行う
setup_mariadb

# MariaDBサーバーが終了するまで待機
wait