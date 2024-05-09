#! /bin/bash

# MariaDBサーバーを起動する関数
start_mariadb() 
{
    /usr/bin/tini -- mysqld --defaults-file=/etc/mysql/mariadb.conf.d/50-server.cnf
    # mysqld --defaults-file=/etc/mysql/mariadb.conf.d/50-server.cnf --innodb_use_native_aio=0
}

# MariaDBの設定を行う関数
setup_mariadb() 
{
    sleep 3  # Wait for MariaDB server to start
    echo "mysqld is alive"

    # データベースを作成（空のデータベース名を回避）
    mysql -h localhost -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DB_NAME\` CHARACTER SET utf8 COLLATE utf8_general_ci;"
    echo "データベースの作成完了: $MYSQL_DB_NAME"

    # rootユーザーのパスワードを設定し、全権限を付与
    mysql -h localhost -e "GRANT ALL ON *.* TO 'master'@'%' IDENTIFIED BY '$MYSQL_ROOT_PW' WITH GRANT OPTION;"
    mysql -h localhost -e "GRANT ALL PRIVILEGES ON \`$MYSQL_DB_NAME\`.* TO 'master'@'%';"
    mysql -h localhost -e "FLUSH PRIVILEGES;"
    echo "ルートユーザの設定完了"

    # 一般ユーザーを作成し、指定のデータベースに対する権限を付与（ユーザーが存在しない場合のみ）
    mysql -h localhost -e "CREATE USER IF NOT EXISTS '$MYSQL_USER_NAME'@'%' IDENTIFIED BY '$MYSQL_USER_PW';"
    mysql -h localhost -e "GRANT ALL PRIVILEGES ON \`$MYSQL_DB_NAME\`.* TO '$MYSQL_USER_NAME'@'%';"
    mysql -h localhost -e "FLUSH PRIVILEGES;"
    echo "一般ユーザの作成完了: $MYSQL_USER_NAME"

    echo "MariaDB setup completed successfully!"
}

# フォアグラウンドでMariaDBサーバーを起動
start_mariadb &

# MariaDBの設定を行う
setup_mariadb

wait