#!/bin/bash
#
apt-get update
apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng12-dev libxml2-dev gettext libicu-dev libcurl3-openssl-dev libssl-dev ImageMagick libmagick++-dev wget
docker-php-ext-install -j$(nproc) iconv mcrypt
docker-php-ext-install mbstring shmop soap sockets zip gettext pcntl intl
docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
docker-php-ext-install -j$(nproc) gd
#
pecl install igbinary-2.0.1
docker-php-ext-enable igbinary
pecl install swoole-1.9.18
docker-php-ext-enable swoole
#
expect -c "
spawn /usr/local/bin/pecl install redis-3.1.3
expect \"enable igbinary serializer support\? \[no\] \:\"
send \"yes\r\"
interact
"
docker-php-ext-enable redis
#
pecl install mongodb-1.2.9
docker-php-ext-enable mongodb
pecl install imagick-3.4.3
docker-php-ext-enable imagick
#
expect -c "
spawn /usr/local/bin/pecl install solr-2.4.0
expect \"Enable Solr Debugging \(Compiles solr in debug mode\) \[no\] \:\"
send \"no\r\"
expect \"libcURL install prefix \[\/usr\] \:\"
send \"\/usr\r\"
expect \"libxml2 install prefix \[\/usr\] \:\"
send \"\/usr\r\"
interact
"
#
docker-php-ext-enable solr
