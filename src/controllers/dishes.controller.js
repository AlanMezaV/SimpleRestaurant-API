import {pool} from "../db.js";

export const getPlatillos = async (req, res) => {
	try {
		const query = `
            SELECT p.*, g.NombreGrupo AS NombreGrupo
            FROM PLATILLOS p
            INNER JOIN GRUPOPLATILLOS g ON p.Grupo = g.IDGrupo
        `;
		const [rows] = await pool.query(query);
		res.json(rows);
	} catch (error) {
		return res.status(500).json({message: "Something goes wrong"});
	}
};

export const getPlatillo = async (req, res) => {
	try {
		const {id} = req.params;
		const [rows] = await pool.query(
			`SELECT p.*, g.NombreGrupo AS NombreGrupo
            FROM PLATILLOS p
            INNER JOIN GRUPOPLATILLOS g ON p.Grupo = g.IDGrupo
            WHERE IDPlatillo = ?`,
			[id]
		);

		if (rows.length <= 0) {
			return res.status(404).json({message: "Platillo not found"});
		}

		res.json(rows[0]);
	} catch (error) {
		return res.status(500).json({message: "Something goes wrong"});
	}
};

export const deletePlatillo = async (req, res) => {
	try {
		const {id} = req.params;
		const [rows] = await pool.query(
			"DELETE FROM PLATILLOS WHERE IDPlatillo = ?",
			[id]
		);

		if (rows.affectedRows <= 0) {
			return res.status(404).json({message: "Platillo not found"});
		}

		res.sendStatus(204);
	} catch (error) {
		return res.status(500).json({message: "Something goes wrong"});
	}
};

export const createPlatillo = async (req, res) => {
	try {
		const {NombrePlatillo, Precio, Grupo} = req.body;
		const [rows] = await pool.query(
			"INSERT INTO PLATILLOS (NombrePlatillo, Precio, Grupo) VALUES (?, ?, ?)",
			[NombrePlatillo, Precio, Grupo]
		);
		res.status(201).json({
			id: rows.insertId,
			NombrePlatillo,
			Precio,
			Grupo,
		});
	} catch (error) {
		return res.status(500).json({message: "Something goes wrong"});
	}
};

export const updatePlatillo = async (req, res) => {
	try {
		const {id} = req.params;
		const {NombrePlatillo, Precio, Grupo} = req.body;

		const [result] = await pool.query(
			"UPDATE PLATILLOS SET NombrePlatillo = IFNULL(?, NombrePlatillo), Precio = IFNULL(?, Precio), Grupo = IFNULL(?, Grupo) WHERE IDPlatillo = ?",
			[NombrePlatillo, Precio, Grupo, id]
		);

		if (result.affectedRows === 0)
			return res.status(404).json({message: "Platillo not found"});

		const [rows] = await pool.query(
			"SELECT * FROM PLATILLOS WHERE IDPlatillo = ?",
			[id]
		);

		res.json(rows[0]);
	} catch (error) {
		return res.status(500).json({message: "Something goes wrong"});
	}
};
