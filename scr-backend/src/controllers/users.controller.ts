import express, { Request, Response } from "express";
import userManager from './../services/users.manager'
import { UserLoginDto } from "../schemas/dtos/users/users.models";
import jwt from 'jsonwebtoken';

const router = express.Router();

router.get("/:userName", async (req: Request, res: Response) => {
    try {
        if (req.params.userName) {
            const data = await userManager.getByUserName(req.params.userName);
            res.status(200).json({ data });
        } else {
            res.status(400).json({ message: 'Non valid User' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal Server Error. Please contact administrator' });
    }
});

router.post("/login", async (req: Request, res: Response) => {

    try {
        if (req.body) {
            const userRequest = req.body as UserLoginDto;
            var user = await userManager.loginUser(userRequest);
            const token = jwt.sign(
                { user },
                process.env.SECRET_KEY,
                { expiresIn: '1d' }
            );

            res.send({ token });
        } else {
            throw new Error("Invalid Request");
        }
    } catch (error) {
        res.status(400).send(error.message);
    }
})


router.post("/logout", async (req: Request, res: Response) => {
    try {

    } catch (error) {
        res.status(500).json({ message: 'Internal Server Error. Please contact administrator' });
    }
})

export default router;