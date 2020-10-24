FROM node:12-alpine
MAINTAINER wangfuqiang "wafu7969@qq.com"

COPY repositories /etc/apk/repositories
RUN npm install -g yapi-cli --registry https://registry.npm.taobao.org
EXPOSE 3000 9090