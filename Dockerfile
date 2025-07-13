# Stage 1: 安装生产依赖 & 准备应用
FROM mirror.ccs.tencentyun.com/library/node:20-alpine AS builder

WORKDIR /app

# 仅复制依赖清单以利用缓存
COPY package*.json ./

# 切换镜像源并安装生产依赖
RUN npm config set registry https://registry.npmmirror.com \
  && npm ci --production --verbose

# 复制应用源代码
COPY . .

# Stage 2: 生成最终运行镜像
FROM mirror.ccs.tencentyun.com/library/node:20-alpine

WORKDIR /app

# 明确生产环境变量
ENV NODE_ENV=production

# 拷贝生产依赖与应用代码
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/src ./src
COPY --from=builder /app/ecosystem.config.cjs ./
COPY --from=builder /app/package.json ./

EXPOSE 3000

# 使用 PM2 启动
CMD ["pm2-runtime", "start", "ecosystem.config.cjs", "--no-daemon"]
