FROM php:7.4-fpm
LABEL maintainer="Amine Amrani"

RUN mkdir -p /usr/src/php/ext

#Install System Packages
RUN  apt-get update && apt install -y unzip zlib1g-dev libicu-dev libsqlite3-dev sqlite3 libpng-dev libzip-dev wget libxml2-dev default-mysql-client


#Install PHP Extensions
RUN  docker-php-ext-install pdo_sqlite pdo_mysql zip pcntl intl gd mysqli zip  bcmath calendar dba exif gettext shmop sockets sysvmsg sysvsem sysvshm soap

# Install needed php extensions: memcached
RUN apt-get update && apt-get install -y libmemcached-dev zlib1g-dev \
    && pecl install memcached-3.1.4 \
    && docker-php-ext-enable memcached


# Install needed php extensions: memcache
RUN apt-get install --no-install-recommends -y unzip libssl-dev libpcre3 libpcre3-dev && \
    cd /usr/src/php/ext/ && \
    curl -sSL -o php7.zip https://github.com/websupport-sk/pecl-memcache/archive/NON_BLOCKING_IO_php7.zip && \
    unzip php7.zip && \
    mv pecl-memcache-NON_BLOCKING_IO_php7  memcache && \
    docker-php-ext-configure memcache --with-php-config=/usr/local/bin/php-config && \
    docker-php-ext-install memcache && \
    echo "extension=memcache.so" > /usr/local/etc/php/conf.d/ext-memcache.ini && \
    rm -rf /tmp/pecl-memcache-php7 php7.zip


# Install needed php extensions: bz2 
RUN apt-get install --no-install-recommends -yqq libbz2-dev && \
    docker-php-ext-install bz2

# Install needed php extensions: tidy
RUN apt-get update \
    && apt-get install -y libmagickwand-dev imagemagick libtidy-dev \
    && pecl install imagick-3.4.3RC2 \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install tidy \
    && docker-php-ext-enable tidy

# Install APCu and APC backward compatibility
RUN pecl install apcu \
    && pecl install apcu_bc-1.0.3 \
    && docker-php-ext-enable apcu --ini-name 10-docker-php-ext-apcu.ini \
    && docker-php-ext-enable apc --ini-name 20-docker-php-ext-apc.ini

RUN docker-php-ext-configure hash --with-mhash



# Install modules
RUN buildDeps="libpq-dev libzip-dev libicu-dev libpng-dev libjpeg62-turbo-dev libfreetype6-dev libmagickwand-6.q16-dev libxslt-dev" && \
    apt-get update && \
    apt-get install -y $buildDeps --no-install-recommends && \
    ln -s /usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16/MagickWand-config /usr/bin && \
    pecl install imagick && \
    echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-install \
        opcache \
        pdo \
        pdo_pgsql \
        pgsql \
        sockets \
        xsl \
        intl


RUN apt-get clean -y