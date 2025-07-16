import express from "express";
const router = express.Router();

import { resWin } from "../utils/index.js";

router.all("/add", async (req, res) => {
  return resWin({ res, data: { hello: "完成" } });
});

export default router;
