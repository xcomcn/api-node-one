import express from "express";
const router = express.Router();

import { resWin } from "../utils/index.js";

router.post("/add", async (req, res) => {
  return resWin({ res, data: { hello: "word123" } });
});

export default router;
