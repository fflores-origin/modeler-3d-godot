import express, { Request, Response } from "express";
import service from './../services/models.manager'

const router = express.Router();

router.get("/listProjectsByUser", async (req: Request, res: Response) => {
    try {

        res.status(200).send({"message": "Ok"});

    } catch (error) {
        res.status(500).json({ message: 'Internal Server Error. Please contact administrator' });
    }
});

router.post("/listProjectsMarket", async (req: Request, res: Response) => {
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