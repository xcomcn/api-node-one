require("dotenv").config();
const apps = [];
apps.push({
  name: "api-node-one",
  script: "src/index.js",
  instances: "1",
  exec_mode: "cluster",
  merge_logs: true, // 合并日志
  error_file: "./logs/error.log", // 错误日志文件
  out_file: "./logs/out.log", // 正常日志文件
});

module.exports = { apps };
