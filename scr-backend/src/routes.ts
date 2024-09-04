import dotenv from 'dotenv';
import express from 'express';

import userController from "./controllers/users.controller";

dotenv.config();

const port = process.env.PORT;
const router = express.Router();

router.get("/", async (req, res) => {
    return res.json({ "message": `http://localhost:${port}/api` });
});

router.use("/users", userController)

export default router;