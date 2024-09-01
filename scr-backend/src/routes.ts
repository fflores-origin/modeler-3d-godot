import dotenv from 'dotenv';
import express from 'express';

// import deudoresController from "./controllers/deudoresController";

dotenv.config();

const port = process.env.PORT;
const router = express.Router();

router.get("/", async (req, res) => {
    return res.json({ "message": `http://localhost:${port}/api` });
});

// router.use("/deudores", deudoresController)

export default router;