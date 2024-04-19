FROM debian:bullseye

# 環境変数
ARG MYSQL_DB_NAME
ARG MYSQL_ROOT_PW
ARG MYSQL_USER_NAME
ARG MYSQL_USER_PW

# デフォルト操作をする上で必要な設定と機能のインストールを行う
ARG DEBIAN_FRONTEND=noninteractive
ARG DEBCONF_NOWARNINGS=yes
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    man \
    vim \
    curl \
    sudo \
    expect \
    && rm -rf /var/lib/apt/lists/*

# MariaDB, server, clientのインストール
RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# 設定ファイルのコピーと基本設定
COPY ./conf/mariadb-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf
RUN mysql_install_db --basedir=/usr --datadir=/vol_db/mysql --user=mysql
RUN mkdir -p /var/run/mysqld && chown mysql:mysql /var/run/mysqld

# ソケットファイルのディレクトリを作成し、権限を設定
RUN mkdir -p /tmp && chown mysql:mysql /tmp
RUN mkdir -p /var/log/mariadb && chown mysql:mysql /var/log/mariadb

# setup_db.shのコピーと実行権限の付与
COPY ./tools/setup_db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup_db.sh

# ポート指定
EXPOSE 3306

# コンテナ起動時にsetup_db.shを実行し、MariaDBを起動
CMD ["/bin/bash", "-c", "/usr/local/bin/setup_db.sh && mysqld --socket=/tmp/mysqld.sock"]
