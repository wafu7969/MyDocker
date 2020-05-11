FROM redis:5.0-alpine3.11
MAINTAINER wangfuqiang "wafu7969@qq.com"

# 修改源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# 安装ca 证书
RUN apk update && \
    apk add --no-cache ca-certificates 

#设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone