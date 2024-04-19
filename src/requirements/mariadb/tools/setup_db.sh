#!/bin/bash

# Wait for MariaDB server to start
while ! mysqladmin ping --silent --socket=/tmp/mysqld.sock; do
    sleep 1
done

# execute mysql_secure_installation script
expect -c '
set timeout 5;
spawn mysql_secure_installation --socket=/tmp/mysqld.sock;
expect "Enter current password for root (enter for none): ";
send -- "\n";
expect "Set root password?";
send -- "n\n";
expect "Remove anonymous users?";
send "Y\n";
expect "Disallow root login remotely?";
send "N\n";
expect "Remove test database and access to it?";
send "Y\n";
expect "Reload privilege tables now?";
send "Y\n";
interact;'
echo "mysql_secure_installation finished:$?"

# データベースがなかったら作成する→基本的な設定を行うスクリプト（パスワードやルート権限等）
mysql --socket=/tmp/mysqld.sock -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB_NAME}\`;"
mysql --socket=/tmp/mysqld.sock -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER_NAME}\`@'localhost' IDENTIFIED BY '${MYSQL_USER_PW}';"
mysql --socket=/tmp/mysqld.sock -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DB_NAME}\`.* TO \`${MYSQL_USER_NAME}\`@'%';"
mysql --socket=/tmp/mysqld.sock -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PW}';"
mysql --socket=/tmp/mysqld.sock -e "FLUSH PRIVILEGES;"

# mysqladmin -u root -p $MYSQL_ROOT_PW shutdown