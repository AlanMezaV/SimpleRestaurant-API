import express from "express";
import morgan from "morgan";

import indexRoutes from "./routes/index.routes.js";

const app = express();

// Middlewares
app.use(morgan("dev"));
app.use(express.json());

// Routes
app.use("/", indexRoutes);

app.use((req, res, next) => {
	res.status(404).json({message: "Not found"});
});

//Mostrar todos los alumnos
app.get("/api/alumnos", (req, res) => {
	conexion.query("SELECT * FROM alumnos", (error, filas) => {
		if (error) {
			throw error;
		} else {
			res.send(filas);
		}
	});
});

export default app;
