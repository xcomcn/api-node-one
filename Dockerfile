FROM my-node:22.17.0-alpine


WORKDIR /app

COPY . .

RUN npm config set registry https://registry.npmmirror.com
RUN npm install

EXPOSE 3000

# 使用 PM2 启动
CMD ["npm", "run", "dev"]
