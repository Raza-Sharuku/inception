FROM debian:bullseye



#installation of Nginx
RUN apt-get update && apt-get install -y nginx

RUN useradd --system --no-create-home --shell /bin/false nginx

RUN rm -rf /var/lib/apt/lists/*
#設定ファイルのコピー
COPY nginx.conf /etc/nginx/nginx.conf

# SSL証明書と秘密鍵をコピー
COPY ssl/ssl_certificate.crt /etc/nginx/ssl/
COPY ssl/ssl_certificate.key /etc/nginx/ssl/


RUN mkdir -p /var/www/html

COPY index.html /var/www/html/
COPY 404.html /var/www/html/
COPY 50x.html /var/www/html/
COPY index.html /var/www/html/

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
