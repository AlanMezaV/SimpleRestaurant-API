import {pool} from "../db.js";

export const getProducts = async (req, res) => {
	try {
		const query = `
            SELECT p.*, pr.NombreCompania AS NombreProveedor
            FROM PRODUCTOS p
            INNER JOIN PROVEEDORES pr ON p.IDProveedor = pr.IDProveedor
        `;
		const [rows] = await pool.query(query);
		res.json(rows);
	} catch (error) {
		return res.status(500).json({message: "Algo salió mal"});
	}
};

export const getProduct = async (req, res) => {
	try {
		const {id} = req.params;
		const query = `
            SELECT p.*, pr.NombreCompania AS NombreProveedor
            FROM PRODUCTOS p
            INNER JOIN PROVEEDORES pr ON p.IDProveedor = pr.IDProveedor
            WHERE p.IDProducto = ?
        `;
		const [rows] = await pool.query(query, [id]);

		if (rows.length <= 0) {
			return res.status(404).json({message: "Producto no encontrado"});
		}

		res.json(rows[0]);
	} catch (error) {
		return res.status(500).json({message: "Algo salió mal"});
	}
};

export const deleteProduct = async (req, res) => {
	try {
		const {id} = req.params;
		const [rows] = await pool.query(
			"DELETE FROM PRODUCTOS WHERE IDProducto = ?",
			[id]
		);

		if (rows.affectedRows <= 0) {
			return res.status(404).json({message: "Producto no encontrado"});
		}

		res.sendStatus(204);
	} catch (error) {
		return res.status(500).json({message: "Algo salió mal"});
	}
};

export const createProduct = async (req, res) => {
	try {
		const {NombreProducto, IDProveedor, Cantidad, Precio, Unidad} = req.body;
		const [rows] = await pool.query(
			"INSERT INTO PRODUCTOS (NombreProducto, IDProveedor, Cantidad, Precio, Unidad) VALUES (?, ?, ?, ?, ?)",
			[NombreProducto, IDProveedor, Cantidad, Precio, Unidad]
		);
		res.status(201).json({
			id: rows.insertId,
			NombreProducto,
			IDProveedor,
			Cantidad,
			Precio,
			Unidad,
		});
	} catch (error) {
		return res.status(500).json({message: "Algo salió mal"});
	}
};

export const updateProduct = async (req, res) => {
	try {
		const {id} = req.params;
		const {NombreProducto, IDProveedor, Cantidad, Precio, Unidad} = req.body;

		const [result] = await pool.query(
			"UPDATE PRODUCTOS SET NombreProducto = ?, IDProveedor = ?, Cantidad = ?, Precio = ?, Unidad = ? WHERE IDProducto = ?",
			[NombreProducto, IDProveedor, Cantidad, Precio, Unidad, id]
		);

		if (result.affectedRows === 0)
			return res.status(404).json({message: "Producto no encontrado"});

		const [rows] = await pool.query(
			"SELECT * FROM PRODUCTOS WHERE IDProducto = ?",
			[id]
		);

		res.json(rows[0]);
	} catch (error) {
		return res.status(500).json({message: "Algo salió mal"});
	}
};
