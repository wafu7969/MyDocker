# MyDocker
	alpine分支是采用官方alpine构建的，优点是镜像特别的小
	用docker-compose部署php+nginx+mysql+mongodb+redis+rabbit
	作者：王福强

## php:7.2
	--支持mysqli扩展安装
	--支持pdo_mysql扩展安装
	--支持opcache扩展安装
	--支持redis扩展安装
	--支持mongodb扩展安装
	--支持rabbitmq扩展安装
	--支持与mysql容器建立连接
	--支持与redis容器建立连接
	
## nginx:1.15.11
	--支持与php容器建立连接
	--支持配置文件挂载到宿主机
	--支持网站文件挂载到宿主机
	--支持日志文件挂载到宿主机
	
## mysql:5.7
	--支持数据data挂载到宿主机
	--支持数据库配置文件挂载到宿主机
	--支持数据库日志文件挂载到宿主机
	--root初始化密码为：456321，安装完一定要记得修改
	
## mongo:4.1
	--支持数据文件挂载到宿主机
        --支持远程授权登录
	--支持构建时初始化数据
	
	
## redis:5.0.4
	--支持数据文件挂载到宿主机
	--支持配置文件挂载到宿主机
	--支持redis.conf配置文件启动（可以设置授权登陆）
	--redis初始密码：456321
	
## rabbitmq:3.7.14-management
	--支持数据文件挂载到宿主机
	--支持日志文件挂载到宿主机
	--初始化用户名guest，密码：guest 安装完一定要修改
	
具体请看docker-compose.yml配置内容和各个文件下的dockerfile。
