FROM php:7.4.30-fpm
MAINTAINER wangfuqiang "wafu7969@qq.com"

#设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#更新安装依赖包和PHP核心拓展
RUN apt-get update && apt-get install -y \
    git \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libssl-dev \
    cmake \
    wget \
    && wget https://nih.at/libzip/libzip-1.3.2.tar.gz && tar -zxvf libzip-1.3.2.tar.gz && cd libzip-1.3.2  \
    && ./configure \
    && make && make install \
    && cd .. && rm -rf libzip-1.3.2 && rm -rf libzip-1.3.2.tar.gz \
    && docker-php-ext-configure gd --with-jpeg=/usr/include --with-freetype=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-enable gd \
    && docker-php-ext-install zip \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install opcache \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install bcmath \
    && rm -rf /var/lib/apt/lists/*

#将预先下载好的拓展包从宿主机拷贝进去
COPY ./ext-source/redis-4.3.0.tgz /home/redis-4.3.0.tgz
COPY ./ext-source/mongodb-1.5.3.tgz /home/mongodb-1.5.3.tgz
COPY ./ext-source/rabbitmq-c-0.8.0.tar.gz /home/rabbitmq-c-0.8.0.tar.gz
COPY ./ext-source/amqp-1.9.4.tgz /home/amqp-1.9.4.tgz

#安装 PECL 拓展，这里我们安装的是Redis
RUN pecl install /home/redis-4.3.0.tgz && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini
RUN pecl install /home/mongodb-1.5.3.tgz && echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/mongodb.ini

#安装swoole扩展
RUN pecl install swoole-4.5.1 \
   && docker-php-ext-enable swoole

#安装第三方拓展，这里是先安装rabbitmq-c-master再安装php amqp 拓展
RUN cd /home \
&& tar -zxvf rabbitmq-c-0.8.0.tar.gz \
&& cd rabbitmq-c-0.8.0 \
&& mkdir /opt/rabbitmq-c-0.8.0 \
&& ./configure --prefix=/opt/rabbitmq-c-0.8.0 \
&& make && make install

#amqp更新版本下载地址 https://pecl.php.net/package/amqp
RUN cd /home \
&& tar -zxvf amqp-1.9.4.tgz \
&& cd amqp-1.9.4 \
&& phpize \
&& ./configure --with-php-config=/usr/local/bin/php-config --with-amqp --with-librabbitmq-dir=/opt/rabbitmq-c-0.8.0 \
&& make clean && make && make install&& echo "extension=amqp.so" > /usr/local/etc/php/conf.d/amqp.ini


#安装 Composer
ENV COMPOSER_HOME /root/composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
ENV PATH $COMPOSER_HOME/vendor/bin:$PATH


#删除已经安装好的包
RUN cd /home \
&& rm -f ./redis-4.3.0.tgz \
&& rm -f ./mongodb-1.5.3.tgz \
&& rm -f ./rabbitmq-c-0.8.0.tar.gz \
&& rm -rf ./rabbitmq-c-0.8.0 \
&& rm -f ./amqp-1.9.4.tgz \
&& rm -rf ./amqp-1.9.4 \
&& rm -rf /tmp/* \
&& rm -rf /var/cache/apk/*


WORKDIR /data
#Write Permission
