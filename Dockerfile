FROM php:8.1-fpm

# Author and Maintainer Information
LABEL author="Pranay Paunikar"
LABEL maintainer="Pranay Paunikar"

WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy only the composer files and install dependencies
COPY composer.json composer.lock /var/www/html/
RUN composer install --no-scripts

# Install PHP extensions
RUN docker-php-ext-install zip pdo_mysql

# Copy the rest of the application files
COPY . .

CMD ["php-fpm"]

