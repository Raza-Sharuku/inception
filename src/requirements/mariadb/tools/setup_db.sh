#!/bin/bash

# Wait for MariaDB server to start
# while ! mysqladmin ping --silent --socket=/var/run/mysqld/mysqld.sock ; do
#   echo "Waiting for database connection..."
#   sleep 5
# done

# データベースがなかったら作成する→基本的な設定を行うスクリプト（パスワードやルート権限等）
# mysql --socket=/var/run/mysqld/mysqld.sock -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB_NAME}\`;"
# mysql --socket=/var/run/mysqld/mysqld.sock -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER_NAME}\`@'localhost' IDENTIFIED BY '${MYSQL_USER_PW}';"
# mysql --socket=/var/run/mysqld/mysqld.sock -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DB_NAME}\`.* TO \`${MYSQL_USER_NAME}\`@'%';"
# mysql --socket=/var/run/mysqld/mysqld.sock -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PW}';"
# mysql --socket=/var/run/mysqld/mysqld.sock -e "FLUSH PRIVILEGES;"

# mysqladmin -u root -p $MYSQL_ROOT_PW shutdown



# Wait for MariaDB server to start
while ! mysqladmin ping -h localhost -u root -p"${MYSQL_ROOT_PW}" --silent; do
  echo "Waiting for database connection..."
  sleep 5
done

# データベースがなかったら作成する→基本的な設定を行うスクリプト（パスワードやルート権限等）
mysql -u root -p"${MYSQL_ROOT_PW}" -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB_NAME}\`;"
mysql -u root -p"${MYSQL_ROOT_PW}" -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER_NAME}\`@'localhost' IDENTIFIED BY '${MYSQL_USER_PW}';"
mysql -u root -p"${MYSQL_ROOT_PW}" -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DB_NAME}\`.* TO \`${MYSQL_USER_NAME}\`@'%';"
mysql -u root -p"${MYSQL_ROOT_PW}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PW}';"
mysql -u root -p"${MYSQL_ROOT_PW}" -e "FLUSH PRIVILEGES;"

echo "MariaDB setup completed successfully!"