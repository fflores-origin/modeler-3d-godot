import express, { Request, Response } from "express";
import service from './../services/users.manager'
import { UserLoginDto } from "../schemas/dtos/users/users.models";

const router = express.Router();

router.get("/:userName", async (req: Request, res: Response) => {
    try {
        if (req.params.userName) {
            const data = await service.getByUserName(req.params.userName);
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
            var response = await service.login(userRequest);
            res.send(response);

        } else {
            throw new Error("Invalid Request");
        }
    } catch (error) {
        res.status(400).send(error.message);
    }
})

router.post("/register", async (req: Request, res: Response) => {
    try {
        if (req.body) {
            const userRequest = req.body as UserLoginDto;
            await service.register(userRequest);
            res.status(200).json({});
        } else {
            throw new Error("Invalid Request");
        }
    } catch (error) {
        res.status(500).send(error.message);
    }
})


router.post("/logout", async (req: Request, res: Response) => {
    try {

    } catch (error) {
        res.status(500).json({ message: 'Internal Server Error. Please contact administrator' });
    }
})

router.post("/recover", async (req: Request, res: Response) => {
    try {
        if (req.body) {

            const { username } = req.body;
            var response = await service.recover(username);
            res.send(response);

        } else {
            throw new Error("Invalid Request");
        }
    } catch (error) {
        res.status(500).json({ message: 'Internal Server Error. Please contact administrator' });
    }
})



export default router;