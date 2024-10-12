import express, { Request, Response } from "express";

const router = express.Router();

router.get("/getLanguages", async (req: Request, res: Response) => {
    try {
        if (req.body) {
            res.status(200).send(req.body);
        } else {
            res.status(400).json({ message: 'Invalid Request' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal Server Error. Please contact administrator' });
    }
});


export default router;