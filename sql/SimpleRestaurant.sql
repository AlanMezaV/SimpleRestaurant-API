Use sys;
CREATE DATABASE railway;
USE railway;

-- Creación de tablas

CREATE TABLE PRODUCTOS (
    IDProducto INT NOT NULL AUTO_INCREMENT,
    NombreProducto VARCHAR(100),
    IDProveedor INT,
    IDCategoria INT,
    Cantidad INT,
    CantidadMinima INT,
    Descontinuado BIT,
    PRIMARY KEY (IDProducto)
);

CREATE TABLE PROVEEDORES (
    IDProveedor INT NOT NULL AUTO_INCREMENT,
    NombreCompania VARCHAR(100),
    NombreContacto VARCHAR(100),
    CargoContacto VARCHAR(100),
    TelefonoContacto VARCHAR(20),
    TelefonoEmpresa VARCHAR(20),
    PRIMARY KEY (IDProveedor)
);

CREATE TABLE MESAS (
    IDMesa INT NOT NULL,
    NumeroMesa INT,
    Capacidad INT,
    EstadoMesa VARCHAR(50),
    PRIMARY KEY (IDMesa)
);


CREATE TABLE EMPLEADOS (
    IDEmpleado INT NOT NULL AUTO_INCREMENT,
    NombreEmp VARCHAR(100),
    ApellidosEmp VARCHAR(100),
    IDPuesto INT,
    NSS VARCHAR(20),
    RFC VARCHAR(20),
    Direccion VARCHAR(255),
    Telefono VARCHAR(20),
    Email VARCHAR(100),
    FechaContratacion DATE,
    Salario DECIMAL(10, 2),
    PRIMARY KEY (IDEmpleado)
);

CREATE TABLE PUESTOS (
    IDPuesto INT NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(100),
    PRIMARY KEY (IDPuesto)
);

CREATE TABLE PLATILLOS (
    IDPlatillo INT NOT NULL AUTO_INCREMENT,
    NombrePlatillo VARCHAR(100),
    Precio DECIMAL(10, 2),
    Grupo INT,
    PRIMARY KEY (IDPlatillo)
);

CREATE TABLE GRUPOPLATILLOS (
    IDGrupo INT NOT NULL,
    NombreGrupo VARCHAR(100),
    PRIMARY KEY (IDGrupo)
);

-- Claves foráneas (FK)

ALTER TABLE PRODUCTOS
ADD CONSTRAINT FK_Productos_Proveedores FOREIGN KEY (IDProveedor)
REFERENCES PROVEEDORES(IDProveedor);

ALTER TABLE EMPLEADOS
ADD CONSTRAINT FK_Empleados_Puestos FOREIGN KEY (IDPuesto)
REFERENCES PUESTOS(IDPuesto);

ALTER TABLE PLATILLOS
ADD CONSTRAINT FK_Platillos_GrupoPlatillos FOREIGN KEY (Grupo)
REFERENCES GRUPOPLATILLOS(IDGrupo);
