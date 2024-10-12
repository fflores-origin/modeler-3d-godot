import express, { Response, Request } from 'express';

import userController from "./controllers/users.controller";
import baseController from "./controllers/base.controller";
import modelsController from "./controllers/models.controller";

const router = express.Router();

router.get("/", async (req: Request, res: Response) => {
    res.status(200).json({ "message": `base modeler api` });
});

// CONTROLLERS
router.use("/users", userController)
router.use("/base", baseController)
router.use("/models", modelsController)

export default router;