import express, { Response, Request } from 'express';

import userController from "./controllers/users.controller";

const router = express.Router();

router.get("/", async (req: Request, res: Response) => {
    res.status(200).json({ "message": `base modeler api` });
});

// CONTROLLERS
router.use("/users", userController)

export default router;