FROM nginx:1.23.1
MAINTAINER wangfuqiang "wafu7969@qq.com"

#设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone