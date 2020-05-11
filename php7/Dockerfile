FROM php:7.2.30-fpm-alpine3.11
MAINTAINER wangfuqiang "wafu7969@qq.com"

#设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 修改源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# 安装ca证书和PHP核心拓展
RUN apk update && \
    apk add --no-cache ca-certificates \
	shadow \
	autoconf \
	gcc \
	g++ \
	curl \
	make \
	openssl-dev \
	pcre-dev \
    libjpeg-turbo-dev \
    libpng-dev  \
    freetype \
    libxml2 \
    libxslt \
    libmcrypt \
    libzip-dev \
	&& docker-php-ext-configure gd \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install zip \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install opcache \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install bcmath

# 安装Redis扩展	
ENV PHPREDIS_VERSION 4.3.0
RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mkdir -p /usr/src/php/ext \
    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
    && docker-php-ext-install redis \
    && rm -rf /usr/src/php #如果这段不加构建的镜像将大100M 

# 安装mongodb扩展
RUN pecl install mongodb \
    && docker-php-ext-enable mongodb \
	&& rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*

	
#安装Composer
ENV COMPOSER_HOME /root/composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV PATH $COMPOSER_HOME/vendor/bin:$PATH


#向外暴露的端口
EXPOSE 9000
RUN usermod -u 1000 www-data