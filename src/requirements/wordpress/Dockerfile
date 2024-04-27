FROM debian:bullseye

RUN apt-get update && apt-get install -y lsb-release apt-transport-https ca-certificates wget && \
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    php8.0 \
    php8.0-fpm \
    php8.0-mysql \
    php8.0-mbstring \
    php8.0-xml \
    php8.0-zip \
    php8.0-gd \
    php8.0-curl \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# WordPressの解凍とインストール
RUN mkdir -p /var/www/html
WORKDIR /var/www/html

COPY tools/wordpress-6.2.tar.gz /tmp/
RUN chmod +x /tmp/

# php-fpmの設定
RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/8.0/fpm/php.ini
RUN sed -i 's/;listen.owner.*/listen.owner = www-data/' /etc/php/8.0/fpm/pool.d/www.conf
RUN sed -i 's/;listen.group.*/listen.group = www-data/' /etc/php/8.0/fpm/pool.d/www.conf

# wp-cliのインストール
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# auto_config.shスクリプトのコピーと実行権限の付与
COPY conf/auto_config.sh /var/www/html/
COPY ./tools/index.html /tmp/
RUN chmod +x /var/www/html/auto_config.sh

RUN tar -xzvf /tmp/wordpress-6.2.tar.gz -C /var/www/html/ >/dev/null && chmod -R 755 /var/www/html/wordpress  

EXPOSE 9000

# エントリーポイントの設定
ENTRYPOINT ["/var/www/html/auto_config.sh"]