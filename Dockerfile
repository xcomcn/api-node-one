# FROM mirror.ccs.tencentyun.com/library/node:22
FROM registry.cn-hangzhou.aliyuncs.com/library/node:22


WORKDIR /app

COPY . .

RUN npm config set registry https://registry.npmmirror.com
RUN npm install

EXPOSE 3000

# 使用 PM2 启动
CMD ["pm2-runtime", "start", "ecosystem.config.cjs", "--no-daemon"]
