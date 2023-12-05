FROM php:8.1-fpm

WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP extensions
RUN docker-php-ext-install zip pdo_mysql
COPY composer.json composer.lock /var/www/html/
RUN composer install --no-scripts

COPY . .

#RUN composer install --no-scripts

CMD ["php-fpm"]

