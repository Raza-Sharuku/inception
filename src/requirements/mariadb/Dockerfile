FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NOWARNINGS=yes

RUN apt-get update && \
    apt-get install -y apt-utils && \
    apt-get upgrade -y && \
    apt-get install -y man vim curl sudo expect mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# 設定ファイルのコピーと基本設定
COPY ./conf/mariadb-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /var/run/mysqld && \
    chown mysql:mysql /var/run/mysqld

RUN mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql

# setup_db.shのコピーと実行権限の付与
COPY ./tools/setup_db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup_db.sh
RUN mkdir -p /var/log/mariadb
# RUN chmod +x /var/log/mariadb

# ポート指定
EXPOSE 3306

USER mysql

CMD ["/usr/local/bin/setup_db.sh"]