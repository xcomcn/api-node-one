import "dotenv/config";
import express from "express";
import cors from "cors";

import userRouter from "./routes/user.js";
const app = express();

// 配置跨域
app.use(cors());
// 解析JSON请求体
app.use(express.json());

// 挂载路由
app.use("/api/users", userRouter);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`服务启动 ${PORT}`);
});
``;
