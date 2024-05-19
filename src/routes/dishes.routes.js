import {Router} from "express";
import {
	createPlatillo,
	deletePlatillo,
	getPlatillo,
	getPlatillos,
	updatePlatillo,
} from "../controllers/platillos.controller.js";

const router = Router();

// GET all Platillos
router.get("/platillos", getPlatillos);

// GET A Platillo
router.get("/platillos/:id", getPlatillo);

// DELETE A Platillo
router.delete("/platillos/:id", deletePlatillo);

// INSERT A Platillo
router.post("/platillos", createPlatillo);

// UPDATE A Platillo
router.patch("/platillos/:id", updatePlatillo);

export default router;
