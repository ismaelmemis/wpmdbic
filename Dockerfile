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
PHP_EXT_DIR=$(php -i | grep extension_dir | awk '{print $NF}') && \
PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;") && \
cp /tmp/ioncube/ioncube_loader_lin_${PHP_VERSION}.so $PHP_EXT_DIR/ioncube_loader_lin_${PHP_VERSION}.so && \
echo "zend_extension = $PHP_EXT_DIR/ioncube_loader_lin_${PHP_VERSION}.so" > /usr/local/etc/php/conf.d/00-ioncube.ini
RUN pecl install xdebug && docker-php-ext-enable xdebug
# Clean up
RUN rm -rf /tmp/ioncube*

WORKDIR /var/www/html