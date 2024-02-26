import express from "express";
import morgan from "morgan";

import indexRoutes from "./routes/index.routes.js";

const app = express();

import {PORT} from "./config.js";

app.listen(PORT);
console.log(`Server on port http://localhost:${PORT}`);

// Middlewares
app.use(morgan("dev"));
app.use(express.json());

// Routes
app.use("/", indexRoutes);

app.use((req, res, next) => {
	res.status(404).json({message: "Not found"});
});

export default app;
