FROM php:8.3-fpm-alpine

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions mysqli pdo_mysql gd zip opcache

WORKDIR /var/www/html

COPY . /var/www/html

RUN mkdir -p cache upload xhr/logs && chown -R www-data:www-data cache upload xhr/logs

EXPOSE 9000
CMD ["php-fpm"]