import {Router} from "express";
import {
	createProduct,
	deleteProduct,
	getProduct,
	getProducts,
	updateProduct,
} from "../controllers/products.controller.js";

const router = Router();

// GET all Products
router.get("/products", getProducts);

// GET a Product by ID
router.get("/products/:id", getProduct);

// DELETE a Product by ID
router.delete("/products/:id", deleteProduct);

// CREATE a new Product
router.post("/products", createProduct);

// UPDATE a Product by ID
router.patch("/products/:id", updateProduct);

export default router;
