# Use the official WordPress image as the base
FROM wordpress:php7.4

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    unzip

# Download and install ionCube Loader
WORKDIR /tmp
RUN wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz
RUN tar xvfz  /tmp/ioncube_loaders_lin_x86-64.tar.gz
# RUN PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;") && \
#     cp /tmp/ioncube/ioncube_loader_lin_${PHP_VERSION}.so /usr/local/lib/php/extensions/no-debug-non-zts-20220829/ioncube_loader_lin_${PHP_VERSION}.so && \
#     echo "zend_extension = /usr/local/lib/php/extensions/no-debug-non-zts-20220829/ioncube_loader_lin_${PHP_VERSION}.so" > /usr/local/etc/php/conf.d/00-ioncube.ini
RUN \
    cp /tmp/ioncube/ioncube_loader_lin_7.4.so /usr/local/lib/php/extensions/no-debug-non-zts-20220829/ioncube_loader_lin_7.4.so && \
    echo "zend_extension = /usr/local/lib/php/extensions/no-debug-non-zts-20220829/ioncube_loader_lin_7.4.so" > /usr/local/etc/php/conf.d/00-ioncube.ini
RUN pecl install xdebug && docker-php-ext-enable xdebug
# Clean up
RUN rm -rf /tmp/ioncube*

WORKDIR /var/www/html