FROM mongo:4.1
MAINTAINER wangfuqiang "wafu7969@qq.com"

#设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 将本地的setup.js映射到Docker容器中
COPY ./setup/setup.js /docker-entrypoint-initdb.d/