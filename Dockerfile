#Download base image ubuntu 20.04
FROM ubuntu:20.04

# Update Software repository
RUN apt-get update

ENV DEBIAN_FRONTEND=noninteractive


MAINTAINER Deepak Kumar <deepakworldphp86@gmail.com>

ENV XDEBUG_PORT 9000

# Install System Dependencies

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
	software-properties-common \
	&& apt-get update \
	&& apt-get install -y \
        # Install apache
        apache2 \
        # Install php 7.4
        libapache2-mod-php7.4 \
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


# Install oAuth

#RUN apt-get update \
#  	&& apt-get install -y \
#  	libpcre3 \
#  	libpcre3-dev \
#  	# php-pear \
#  	&& pecl install oauth \
#  	&& echo "extension=oauth.so" > /usr/local/etc/php/conf.d/docker-php-ext-oauth.ini

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

# Install XDebug

#RUN yes | pecl install xdebug && \
#	 echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.iniOLD

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

ADD .docker/config/php.ini /usr/local/etc/php/php.ini
ADD .docker/config/magento.conf /etc/apache2/sites-available/magento.conf
ADD .docker/config/custom-xdebug.ini /usr/local/etc/php/conf.d/custom-xdebug.ini
COPY .docker/bin/* /usr/local/bin/
COPY .docker/users/* /var/www/
RUN chmod +x /usr/local/bin/*
RUN ln -s /etc/apache2/sites-available/magento.conf /etc/apache2/sites-enabled/magento.conf

RUN curl -o /etc/bash_completion.d/m2install-bash-completion https://raw.githubusercontent.com/yvoronoy/m2install/master/m2install-bash-completion
RUN curl -o /etc/bash_completion.d/n98-magerun2.phar.bash https://raw.githubusercontent.com/netz98/n98-magerun2/master/res/autocompletion/bash/n98-magerun2.phar.bash
RUN echo "source /etc/bash_completion" >> /root/.bashrc
RUN echo "source /etc/bash_completion" >> /var/www/.bashrc

RUN chmod 777 -Rf /var/www /var/www/.* \
	&& chown -Rf www-data:www-data /var/www /var/www/.* \
	&& usermod -u 1000 www-data \
	&& chsh -s /bin/bash www-data\
	&& a2enmod rewrite \
	&& a2enmod headers

VOLUME /var/www/html
WORKDIR /var/www/html
