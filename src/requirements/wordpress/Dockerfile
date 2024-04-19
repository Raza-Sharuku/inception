FROM debian:bullseye

# Install required packages
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-mbstring \
    php7.4-exif \
    php7.4-bcmath \
    php7.4-gd

WORKDIR /var/www/html

# Download WordPress
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz

#give permission
RUN		chown -R root:root /var/www/wordpress

# Copy custom PHP configuration
COPY php.ini /etc/php/7.4/cli/conf.d/custom.ini
COPY php.ini /etc/php/7.4/fpm/conf.d/custom.ini

# Copy custom PHP-FPM configuration
COPY www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Set environment variables for WordPress database connection
ENV WORDPRESS_DB_HOST=db
ENV WORDPRESS_DB_USER=wordpress
ENV WORDPRESS_DB_PASSWORD=wordpress_password
ENV WORDPRESS_DB_NAME=wordpress

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]