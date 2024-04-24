FROM debian:bullseye

# 必要なパッケージのインストールとキャッシュの削除
RUN apt-get update && apt-get install -y nginx openssl &&  rm -rf /var/lib/apt/lists/*

# 自己署名証明書の生成
RUN mkdir /etc/nginx/ssl && \
    openssl req -newkey rsa:4096 -nodes -keyout /etc/nginx/ssl/server.key \
    -x509 -days 365 -out /etc/nginx/ssl/server.crt \
    -subj "/C=JP/ST=Tokyo/L=city/O=42tokyo/CN=sraza.42.fr"

# nginx.confをコンテナにコピー
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

# コンテンツのコピー
RUN mkdir -p /var/www/html
COPY index.html /var/www/html/index.html

# ファイルのパーミッションを変更
RUN chmod -R 755 /var/www/html

# ポート443番を使用する
EXPOSE 443

# Nginxをフォアグラウンドで実行
CMD ["nginx", "-g", "daemon off;"]
