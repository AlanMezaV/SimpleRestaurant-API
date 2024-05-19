import {pool} from "../db.js";

export const getEmployees = async (req, res) => {
	try {
		const query = `
            SELECT e.*, p.Nombre AS NombrePuesto
            FROM EMPLEADOS e
            INNER JOIN PUESTOS p ON e.IDPuesto = p.IDPuesto
        `;
		const [rows] = await pool.query(query);
		res.json(rows);
	} catch (error) {
		return res.status(500).json({message: "Something goes wrong"});
	}
};

export const getEmployee = async (req, res) => {
	try {
		const {id} = req.params;
		const [rows] = await pool.query(
			"SELECT * FROM EMPLEADOS WHERE IDEmpleado = ?",
			[id]
		);

		if (rows.length <= 0) {
			return res.status(404).json({message: "Employee not found"});
		}

		res.json(rows[0]);
	} catch (error) {
		return res.status(500).json({message: "Something goes wrong"});
	}
};

export const deleteEmployee = async (req, res) => {
	try {
		const {id} = req.params;
		const [rows] = await pool.query(
			"DELETE FROM EMPLEADOS WHERE IDEmpleado = ?",
			[id]
		);

		if (rows.affectedRows <= 0) {
			return res.status(404).json({message: "Employee not found"});
		}

		res.sendStatus(204);
	} catch (error) {
		return res.status(500).json({message: "Something goes wrong"});
	}
};

export const createEmployee = async (req, res) => {
	try {
		const {
			NombreEmp,
			ApellidosEmp,
			IDPuesto,
			NSS,
			RFC,
			Direccion,
			Telefono,
			Email,
			FechaContratacion,
			Salario,
		} = req.body;
		const [rows] = await pool.query(
			"INSERT INTO EMPLEADOS (NombreEmp, ApellidosEmp, IDPuesto, NSS, RFC, Direccion, Telefono, Email, FechaContratacion, Salario) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
			[
				NombreEmp,
				ApellidosEmp,
				IDPuesto,
				NSS,
				RFC,
				Direccion,
				Telefono,
				Email,
				FechaContratacion,
				Salario,
			]
		);
		res.status(201).json({
			id: rows.insertId,
			NombreEmp,
			ApellidosEmp,
			IDPuesto,
			NSS,
			RFC,
			Direccion,
			Telefono,
			Email,
			FechaContratacion,
			Salario,
		});
	} catch (error) {
		return res.status(500).json({message: "Something goes wrong"});
	}
};

export const updateEmployee = async (req, res) => {
	try {
		const {id} = req.params;
		const {name, salary} = req.body;

		const [result] = await pool.query(
			"UPDATE EMPLEADOS SET name = IFNULL(?, name), salary = IFNULL(?, salary) WHERE id = ?",
			[name, salary, id]
		);

		if (result.affectedRows === 0)
			return res.status(404).json({message: "Employee not found"});

		const [rows] = await pool.query("SELECT * FROM EMPLEADOS WHERE id = ?", [
			id,
		]);

		res.json(rows[0]);
	} catch (error) {
		return res.status(500).json({message: "Something goes wrong"});
	}
};
