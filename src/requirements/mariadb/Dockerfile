FROM debian:bullseye

ENV MYSQL_DB_NAME=
ENV MYSQL_ROOT_PW=
ENV MYSQL_USER_NAME=
ENV MYSQL_USER_PW=

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NOWARNINGS=yes

RUN apt-get update && \
    apt-get install -y apt-utils && \
    apt-get upgrade -y && \
    apt-get install -y man vim curl sudo expect && \
    rm -rf /var/lib/apt/lists/*

# MariaDB, server, clientのインストール
RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# 設定ファイルのコピーと基本設定
COPY ./conf/mariadb-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod +x /etc/mysql/mariadb.conf.d/50-server.cnf
RUN mkdir -p /var/run/mysqld && \
    chown mysql:mysql /var/run/mysqld && \
    chmod +x /var/run/mysqld

# ログディレクトリの作成と権限設定
RUN mkdir -p /var/log/mariadb && \
    chown mysql:mysql /var/log/mariadb

RUN mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql

#ユーザー設定
RUN getent group mysql || groupadd -r mysql
RUN getent passwd mysql || useradd -r -g mysql mysql

# ソケットファイルのディレクトリを作成し、権限を設定
RUN mkdir -p /tmp && chown mysql:mysql /tmp

# setup_db.shのコピーと実行権限の付与
COPY ./tools/setup_db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup_db.sh

# ポート指定
EXPOSE 3306

USER mysql

CMD ["/usr/local/bin/setup_db.sh"]

# CMD ["/bin/bash", "-c", "/usr/local/bin/setup_db.sh && mysqld --defaults-file=/etc/mysql/mariadb.conf.d/50-server.cnf"]