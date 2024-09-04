import express, { Request, Response } from "express";
import userManager from './../services/users.manager'

const router = express.Router();

router.get("/:userName", async (req: Request, res: Response) => {

    try {
        if (req.params.userName) {
            const data = await userManager.getByUserName(req.params.userName);
            res.status(200).json({ data });
        } else {
            res.status(500).json({ message: 'no se envio un user valido' });
        }
    } catch (error) {
        res.status(500).json({ message: 'Ocurrio un error interno. Contacte administrador' });
    }

});



export default router;