# 使用する基盤イメージ
FROM debian:bullseye

# パッケージのインストールとシステムのアップデート
RUN apt-get update && \
    apt-get install -y apt-utils mariadb-server mariadb-client mariadb-common && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

# 設定ファイルのコピー
COPY ./conf/mariadb-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# # ディレクトリの作成と所有権の設定
RUN mkdir -p /var/run/mysqld /var/log/mariadb && \
    chown -R mysql:mysql /var/run/mysqld /var/lib/mysql /var/log/mariadb

# データベースの初期化
RUN mariadb-install-db --basedir=/usr --datadir=/var/lib/mysql --user=mysql

# setup_db.shのコピーと実行権限の付与
COPY ./tools/setup_db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup_db.sh

# ポート指定
EXPOSE 3306

# # ユーザーの切り替え
USER mysql

# コンテナ起動時のコマンド
ENTRYPOINT ["/usr/local/bin/setup_db.sh"]
