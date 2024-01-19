FROM mongo:4.4.27
MAINTAINER wangfuqiang "wafu7969@qq.com"

#设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 将本地初始化数据的脚本setup.sh映射到容器/docker-entrypoint-initdb.d中
ENV AUTO_RUN_DIR /docker-entrypoint-initdb.d
ENV INSTALL_MONGO_SHELL setup.sh
COPY ./$INSTALL_MONGO_SHELL $AUTO_RUN_DIR/
RUN chmod a+x $AUTO_RUN_DIR/$INSTALL_MONGO_SHELL