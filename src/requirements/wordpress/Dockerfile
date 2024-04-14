FROM debian:bullseye

#installation of wordpress
RUN apt-get update && apt-get install -y wordpress php-fpm

#設定ファイルのコピー
COPY nginx.conf /etc/nginx/nginx.conf


EXPOSE 9000

CMD ["php-fpm"]