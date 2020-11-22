#Download base image ubuntu 20.04
FROM ubuntu:20.04

# Update Software repository
RUN apt-get update

ENV DEBIAN_FRONTEND=noninteractive


MAINTAINER Deepak Kumar <deepakworldphp86@gmail.com>

ENV XDEBUG_PORT 9000

# install and configure nginx
RUN apt-get install -y nginx
RUN systemctl stop nginx.service
RUN systemctl start nginx.service
RUN systemctl enable nginx.service

# install MySQL
RUN apt-get install -y mysql-client mysql-server


# Install System Dependencies

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
	software-properties-common \
	&& apt-get update \
	&& apt-get install -y \
        # Install php 7.4
	php7.4-common\
	php7.4-xmlrpc\
        php7.4-cli \
        php7.4-json \
        php7.4-curl \
        php7.4-fpm \
        php7.4-gd \
        php7.4-ldap \
        php7.4-mbstring \
        php7.4-mysql \
        php7.4-soap \
        php7.4-sqlite3 \
        php7.4-xml \
        php7.4-zip \
        php7.4-intl \
	php7.1-mcrypt\
        php-imagick \
        php-oauth \
        # Install tools
	libfreetype6-dev \
        zlib1g-dev\
	libicu-dev \
        g++ \ 
        pacman \
        libssl-dev \
	libjpeg-turbo8-dev \
	libmcrypt-dev \
	libedit-dev \
	libedit2 \
	libxslt1-dev \
        libpng-dev \
	apt-utils \
	gnupg \
	redis-tools \
	mariadb-client \
	git \
	vim \
	wget \
        openssl \
        nano \
	curl \
	lynx \
	psmisc \
	unzip \
	tar \
        graphicsmagick \
        imagemagick \
        ghostscript \
        iputils-ping \
        locales \
	cron \
        sendmail-bin \ 
       sendmail \ 
       ca-certificates \
       bash-completion \
       && apt-get clean  && rm -rf /var/lib/apt/lists/*



# Install Node, NVM, NPM and Grunt

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  	&& apt-get install -y nodejs build-essential \
    && curl https://raw.githubusercontent.com/creationix/nvm/v0.16.1/install.sh | sh \
    && npm i -g grunt-cli yarn

# Install Composer
RUN curl -s https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Set locales
RUN locale-gen en_US.UTF-8 en_GB.UTF-8 de_DE.UTF-8 es_ES.UTF-8 fr_FR.UTF-8 it_IT.UTF-8 km_KH sv_SE.UTF-8 fi_FI.UTF-8

# Install Code Sniffer

RUN git clone https://github.com/magento/marketplace-eqp.git ~/.composer/vendor/magento/marketplace-eqp
RUN cd ~/.composer/vendor/magento/marketplace-eqp && composer install
RUN ln -s ~/.composer/vendor/magento/marketplace-eqp/vendor/bin/phpcs /usr/local/bin;

ENV PATH="/var/www/.composer/vendor/bin/:${PATH}"


# Install Mhsendmail

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install golang-go \
   && mkdir /opt/go \
   && export GOPATH=/opt/go \
   && go get github.com/mailhog/mhsendmail

# Install Magerun 2

RUN wget https://files.magerun.net/n98-magerun2.phar \
	&& chmod +x ./n98-magerun2.phar \
	&& mv ./n98-magerun2.phar /usr/local/bin/

# Configuring system
# Additional start
ENV PHP_MEMORY_LIMIT 4G
# Additional End

# install and configure php-fpm

ADD configs/nginx/nginx.conf /etc/nginx/
ADD configs/nginx/sites-available/magento /etc/nginx/sites-available/default
ADD configs/php/7.4/php.ini /etc/php/7.4/fpm/php.ini
ADD configs/php/7.4/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
ADD configs/php/7.4/pool.d/www.conf /etc/php/7.4/fpm/pool.d/www.conf

ADD . /configs

RUN ln -sf /configs/nginx/nginx.conf /etc/nginx/nginx.conf
RUN ln -sf /configs/nginx/sites-available/magento /etc/nginx/sites-enabled/default
RUN ln -sf /configs/php5/php.ini /etc/php/7.4/fpm/php.ini
RUN ln -sf /configs/php5/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf
RUN ln -sf /configs/php5/pool.d/www.conf /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 80

CMD bash -C '/configs/shell/start.sh';'bash'

VOLUME /var/www/html
WORKDIR /var/www/html

