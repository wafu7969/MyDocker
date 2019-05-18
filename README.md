# MyDocker
用docker-compose部署php+nginx+mysql+mongodb+redis+rabbit
作者：王福强

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

	具体请看docker-compose.yml配置内容和各个文件下的dockerfile。
