# MyDocker
用docker-compose部署php+nginx+mysql+mongodb+redis+rabbit

php:7.2
	--支持mysqli扩展安装
	--支持pdo_mysql扩展安装
	--支持opcache扩展安装
	--支持redis扩展安装
	--支持mongodb扩展安装
	--支持rabbitmq扩展安装
	--支持rabbitmq扩展安装
nginx:1.15.11
	--支持与php容器建立连接
	--支持配置文件挂载到宿主机
	--支持网站文件挂载到宿主机
	--支持日志文件挂载到宿主机
mysql:5.7
	--支持数据data挂载到宿主机
    --支持数据库配置文件挂载到宿主机
	--支持数据库日志文件挂载到宿主机
mongo:4.1
	--支持数据文件挂载到宿主机
redis:5.0.4
	--支持数据文件挂载到宿主机
	--支持配置文件挂载到宿主机
	--支持redis.conf配置文件启动（可以设置授权登陆）
rabbitmq:3.7.14-management
	--支持数据文件挂载到宿主机
	--支持日志文件挂载到宿主机

具体docker-compose.yml配置如下：

version: '3.2'
services:
  php-fpm:
      build: ./php7/
      ports:
        - "9000:9000"
      links:
        - mysql-db:mysql-db
        - redis-db:redis-db
      volumes:
        - ./www:/data/www:rw
        - ./php7/php.ini:/usr/local/etc/php/php.ini:ro # 当前php配置文件；可以拷贝修改php-dev.ini为想要的配置
        - ./php7/php-fpm.conf:/usr/local/etc/php-fpm.conf:ro
        - ./php7/logs:/var/log/php-fpm:rw
      restart: always
      command: php-fpm

  nginx:
      build: ./nginx
      depends_on:
        - php-fpm
      links:
        - php-fpm:php-fpm
      volumes:
        - ./www:/data/www:rw
        - ./nginx/conf.d:/etc/nginx/conf.d:ro
        - ./nginx/certs:/etc/nginx/certs
        - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
        - ./nginx/logs:/var/log/nginx
      ports:
        - "80:80"
        - "8080:8080"
        - "443:443"
      restart: always
      command: nginx -g 'daemon off;'

  mysql-db:
      build: ./mysql
      ports:
        - "3306:3306"
      volumes:
        - ./mysql/data:/var/lib/mysql:rw
        - ./mysql/logs:/var/lib/mysql-logs:rw
        - ./mysql/conf.d:/etc/mysql/conf.d:ro
      environment:
        MYSQL_ROOT_PASSWORD: 456321
      restart: always
      command: "--character-set-server=utf8"

  redis-db:
      build: ./redis
      ports:
        - "6379:6379"
      command: redis-server /etc/redis/redis.conf #redis 将以 /etc/redis/redis.conf 为配置文件启动
      volumes:
        - ./redis/data:/data
        - ./redis/conf/redis.conf:/etc/redis/redis.conf  # 重要： 配置文件映射，docker镜像redis 默认无配置文件 用这个命令后docker会把宿主机的配置文件映射到容器中
      restart: always

  mongodb:
      build: ./mongo
      restart: always
      ports:
        - 27017:27017  # 本地端口(可自定义):容器内默认端口(mongo设定为27017)
      volumes:
      #  - ./mongo/setup:/docker-entrypoint-initdb.d/  # 本地文件路径:容器内映射路径
        - ./mongo/data:/data/db
#      command: [--auth]   # mongod --auth
#      tty: true
      #environment:  # admin账号和密码
        #MONGO_INITDB_ROOT_USERNAME: admin
        #MONGO_INITDB_ROOT_PASSWORD: admin

# 如果不需要MongoDB的网页端，以下内容可以不加
#  mongo-express:  # 会自动从Docker Hub上自动获取mongo-express这个镜像
#    image: mongo-express
#    restart: always
#    ports:
#    - 8080:8081  # 本地端口(可自定义):容器内默认端口(mongo-express设定为8080)
#    environment:  # 这里只能使用与上方MONGO_INITDB_ROOT_USERNAME相同的root账号
#      ME_CONFIG_MONGODB_ADMINUSERNAME: admin
#      ME_CONFIG_MONGODB_ADMINPASSWORD: admin

  rabbitmq:
      build: ./rabbit
      restart: always
      ports:
        - "5672:5672"
        - "15672:15672"
      volumes:
        - ./rabbit/data:/var/lib/rabbitmq
        - ./rabbit/logs:/var/log/rabbitmq/log