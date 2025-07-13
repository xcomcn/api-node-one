# --- 阶段 1: 构建依赖 ---
FROM mirror.ccs.tencentyun.com/library/node:20-alpine AS builder

# 设置工作目录
WORKDIR /app

# 优先复制 package.json 和 package-lock.json 以利用 Docker 缓存
COPY package*.json ./

# 安装所有依赖
RUN npm ci

# --- 阶段 2: 复制应用文件 ---
FROM mirror.ccs.tencentyun.com/library/node:20-alpine AS app-files

# 设置工作目录
WORKDIR /app

# 复制所有应用源代码
COPY . .

# --- 阶段 3: 生产环境镜像 ---
FROM mirror.ccs.tencentyun.com/library/node:20-alpine

# 设置最终镜像的工作目录
WORKDIR /app

# 从前一阶段复制所需文件
# 从 'builder' 阶段复制 node_modules
COPY --from=builder /app/node_modules ./node_modules
# 从 'app-files' 阶段复制应用文件
COPY --from=app-files /app/src ./src
COPY --from=app-files /app/ecosystem.config.cjs ./ecosystem.config.cjs
COPY --from=app-files /app/package.json ./package.json

# 暴露 Express 应用端口
EXPOSE 3000

# 使用 PM2 启动应用
CMD ["pm2-runtime", "start", "ecosystem.config.cjs", "--no-daemon"]

# 如果不需要 PM2，可以使用以下命令
# CMD ["node", "src/index.js"]