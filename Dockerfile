FROM mirror.ccs.tencentyun.com/library/node:22

WORKDIR /app

COPY . .

RUN npm config set registry https://registry.npmmirror.com
RUN npm ci

EXPOSE 3000

# 使用 PM2 启动
CMD ["pm2-runtime", "start", "ecosystem.config.cjs", "--no-daemon"]
