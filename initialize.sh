#!/bin/bash
#
apt-get update
apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng12-dev libxml2-dev gettext libicu-dev libcurl3-openssl-dev libssl-dev ImageMagick libmagick++-dev
docker-php-ext-install gd mbstring iconv shmop soap sockets zip mcrypt gettext pcntl intl
#
pecl install igbinary
pecl install swoole
#
expect -c "
spawn /usr/local/bin/pecl install redis
expect \"enable igbinary serializer support\? \[no\] \:\"
send \"yes\r\"
interact
"
#
pecl install mongodb
pecl install imagick
#
expect -c "
spawn /usr/local/bin/pecl install solr
expect \"Enable Solr Debugging \(Compiles solr in debug mode\) \[no\] \:\"
send \"no\r\"
expect \"libcURL install prefix \[\/usr\] \:\"
send \"\/usr\r\"
expect \"libxml2 install prefix \[\/usr\] \:\"
send \"\/usr\r\"
interact
"
#
