# FROM debian:bullseye

# # PHPのパッケージのインストール？
# RUN apt-get update && apt-get install -y lsb-release apt-transport-https ca-certificates wget && \
#     wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
#     echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

# RUN apt-get update && apt-get install -y \
#     curl \
#     php8.0 \
#     php8.0-fpm \
#     php8.0-mysql \
#     php8.0-mbstring \
#     php8.0-xml \
#     php8.0-zip \
#     php8.0-gd \
#     php8.0-curl \
#     mariadb-client \
#     && rm -rf /var/lib/apt/lists/*

# # WordPressの解凍とインストール
# RUN mkdir -p /var/www/html
# WORKDIR /var/www/html

# # システムユーザーとグループの作成
# RUN adduser --system --no-create-home --shell /bin/false nginx \
#     && addgroup --system nginx

# # www.conf設定のコピー
# # COPY ./conf/php-fpm.conf /etc/php/8.0/fpm/php-fpm.conf
# COPY ./conf/www.conf /etc/php/8.0/fpm/pool.d/www.conf

# # wordpressのtarのコピーと実行権限の変更(auto_configで実行できるように)
# COPY tools/wordpress-6.2.tar.gz /tmp/
# RUN chmod +x /tmp/


# # # php-fpmの設定
# RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/8.0/fpm/php.ini

# # wp-cliのインストール
# RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# RUN chmod +x wp-cli.phar
# RUN mv wp-cli.phar /usr/local/bin/wp
# RUN chmod +x /usr/local/bin/wp

# # auto_config.shスクリプトのコピーと実行権限の付与
# COPY conf/auto_config.sh /var/www/html/
# COPY ./tools/index.html /tmp/
# RUN chmod 777 /var/www/html/auto_config.sh /tmp/index.html

# RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

# EXPOSE 9000

# # エントリーポイントの設定
# ENTRYPOINT ["/var/www/html/auto_config.sh"]

# RUN echo "CMD will start from here"
# CMD [ "php-fpm8.0", "--nodaemonize" ]

FROM debian:bullseye

# PHPのパッケージのインストール
RUN apt-get update && apt-get install -y lsb-release apt-transport-https ca-certificates wget && \
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

RUN apt-get update && apt-get install -y \
    curl \
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

# システムユーザーとグループの作成
RUN adduser --system --no-create-home --shell /bin/false nginx \
    && addgroup --system nginx

# www.conf設定のコピー
COPY ./conf/www.conf /etc/php/8.0/fpm/pool.d/www.conf

# wordpressのtarのコピーと実行権限の変更(auto_configで実行できるように)
COPY tools/wordpress-6.2.tar.gz /tmp/
RUN chmod +x /tmp/

# php-fpmの設定
RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/8.0/fpm/php.ini

# wp-cliのインストール
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp

# auto_config.shスクリプトのコピーと実行権限の付与
COPY conf/auto_config.sh /var/www/html/
COPY ./tools/index.html /tmp/
RUN chmod 755 /var/www/html/auto_config.sh /tmp/index.html

RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

EXPOSE 9000

ENTRYPOINT ["/var/www/html/auto_config.sh"]