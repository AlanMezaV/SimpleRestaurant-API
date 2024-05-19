--USE master
--GO
CREATE DATABASE SimpleRestaurantBD
GO
USE SimpleRestaurantBD
GO

-- Creación de tablas

CREATE TABLE PRODUCTOS (
    IDProducto INT NOT NULL,
    NombreProducto VARCHAR(100),
    IDProveedor INT,
    Cantidad INT,
    CantidadMinima INT,
    UnidadMedida VARCHAR(50),
    Precio DECIMAL(10, 2),
)
GO

CREATE TABLE PROVEEDORES (
    IDProveedor INT NOT NULL,
    NombreCompania VARCHAR(100),
    NombreContacto VARCHAR(100),
    CargoContacto VARCHAR(100),
    TelefonoContacto VARCHAR(20),
    TelefonoEmpresa VARCHAR(20)
)
GO

CREATE TABLE CATEGORIAS (
    IDCategoria INT NOT NULL,
    NombreCategoria VARCHAR(100)
)
GO

CREATE TABLE INVENTARIODIARIO (
    IDInventario INT NOT NULL,
    IDEmpleado INT,
    IDProducto INT,
    CantidadInicial INT,
    CantidadFinal INT,
    Fecha DATE
)
GO

CREATE TABLE CLIENTES (
    IDCliente INT NOT NULL,
    NombreCliente VARCHAR(100),
    TelefonoCliente VARCHAR(20),
    TotalVisitas INT
)
GO

CREATE TABLE RESERVACIONES (
    IDReservacion INT NOT NULL,
    IDCliente INT,
    IDMesa INT,
    FechaReservada DATE,
    HoraReservada TIME,
    EstadoReservacion VARCHAR(50)
)
GO

CREATE TABLE MESAS (
    IDMesa INT NOT NULL,
    NumeroMesa INT,
    Capacidad INT,
    EstadoMesa VARCHAR(50)
)
GO

CREATE TABLE ORDENES (
    IDOrden INT NOT NULL,
    IDCliente INT,
    IDEmpleado INT,
	IDMesa INT,
    FechaOrden DATE,
    HoraOrden TIME
)
GO

CREATE TABLE ORDENDETALLE (
    IDOrden INT NOT NULL,
    IDMenu INT NOT NULL,
    Precio DECIMAL(10, 2),
    Cantidad INT,
    Descuento DECIMAL(5, 2),
    Estado VARCHAR(50)
)
GO

CREATE TABLE MENU (
    IDMenu INT NOT NULL,
    Nombre VARCHAR(100),
    Descripcion VARCHAR(255),
    IDProducto INT,
    Disponible BIT
)
GO

CREATE TABLE EMPLEADOS (
    IDEmpleado INT NOT NULL,
    NombreEmp VARCHAR(100),
    ApellidosEmp VARCHAR(100),
    IDPuesto INT,
    NSS VARCHAR(20),
    RFC VARCHAR(20),
    Direccion VARCHAR(255),
    Telefono VARCHAR(20),
    Email VARCHAR(100),
    FechaContratacion DATE,
    Salario DECIMAL(10, 2)
)
GO

CREATE TABLE ASISTENCIAS (
    IDAsistencia INT NOT NULL,
    IDEmpleado INT,
    Fecha DATE,
    HoraEntrada TIME,
    HoraSalida TIME,
    Tipo VARCHAR(50)
)
GO

CREATE TABLE VACACIONES (
    IDVacaciones INT NOT NULL,
    IDEmpleado INT,
    FechaVac DATE,
    Estado VARCHAR(50)
)
GO

CREATE TABLE PUESTOS (
    IDPuesto INT NOT NULL,
    Nombre VARCHAR(100)
)
GO

CREATE TABLE HORARIOS (
    IDHorario INT NOT NULL,
    IDEmpleado INT,
    DiaSemana VARCHAR(20),
    HoraEntrada TIME,
    HoraSalida TIME
)
GO

CREATE TABLE PLATILLOS (
    IDPlatillo INT NOT NULL,
    NombrePlatillo VARCHAR(100),
    Precio DECIMAL(10, 2),
    Grupo VARCHAR(50),
)
GO

CREATE TABLE GRUPOPLATILLOS (
    IDGrupo INT NOT NULL,
    NombreGrupo VARCHAR(100),
)

-- Claves primarias (PK)

ALTER TABLE PRODUCTOS
ADD CONSTRAINT PK_Productos PRIMARY KEY (IDProducto)
GO

ALTER TABLE PROVEEDORES
ADD CONSTRAINT PK_Proveedores PRIMARY KEY (IDProveedor)
GO

ALTER TABLE CATEGORIAS
ADD CONSTRAINT PK_Categorias PRIMARY KEY (IDCategoria)
GO

ALTER TABLE INVENTARIODIARIO
ADD CONSTRAINT PK_InventarioDiario PRIMARY KEY (IDInventario)
GO

ALTER TABLE CLIENTES
ADD CONSTRAINT PK_Clientes PRIMARY KEY (IDCliente)
GO

ALTER TABLE RESERVACIONES
ADD CONSTRAINT PK_Reservaciones PRIMARY KEY (IDReservacion)
GO

ALTER TABLE MESAS
ADD CONSTRAINT PK_Mesas PRIMARY KEY (IDMesa)
GO

ALTER TABLE ORDENES
ADD CONSTRAINT PK_Ordenes PRIMARY KEY (IDOrden)
GO

ALTER TABLE ORDENDETALLE
ADD CONSTRAINT PK_OrdenDetalle PRIMARY KEY (IDOrden, IDMenu)
GO

ALTER TABLE MENU
ADD CONSTRAINT PK_Menu PRIMARY KEY (IDMenu)
GO

ALTER TABLE EMPLEADOS
ADD CONSTRAINT PK_Empleados PRIMARY KEY (IDEmpleado)
GO

ALTER TABLE ASISTENCIAS
ADD CONSTRAINT PK_Asistencias PRIMARY KEY (IDAsistencia)
GO

ALTER TABLE VACACIONES
ADD CONSTRAINT PK_Vacaciones PRIMARY KEY (IDVacaciones)
GO

ALTER TABLE PUESTOS
ADD CONSTRAINT PK_Puestos PRIMARY KEY (IDPuesto)
GO

ALTER TABLE HORARIOS
ADD CONSTRAINT PK_Horarios PRIMARY KEY (IDHorario)
GO

ALTER TABLE PLATILLOS
ADD CONSTRAINT PK_Platillos PRIMARY KEY (IDPlatillo)
GO

ALTER TABLE GRUPOPLATILLOS
ADD CONSTRAINT PK_GrupoPlatillos PRIMARY KEY (IDGrupo)
GO

-- Claves foráneas (FK)

ALTER TABLE PRODUCTOS
ADD CONSTRAINT FK_Productos_Proveedores FOREIGN KEY (IDProveedor)
REFERENCES PROVEEDORES(IDProveedor)
GO

ALTER TABLE PRODUCTOS
ADD CONSTRAINT FK_Productos_Categorias FOREIGN KEY (IDCategoria)
REFERENCES CATEGORIAS(IDCategoria)
GO

ALTER TABLE INVENTARIODIARIO
ADD CONSTRAINT FK_InventarioDiario_Empleados FOREIGN KEY (IDEmpleado)
REFERENCES EMPLEADOS(IDEmpleado)
GO

ALTER TABLE INVENTARIODIARIO
ADD CONSTRAINT FK_InventarioDiario_Productos FOREIGN KEY (IDProducto)
REFERENCES PRODUCTOS(IDProducto)
GO

ALTER TABLE RESERVACIONES
ADD CONSTRAINT FK_Reservaciones_Clientes FOREIGN KEY (IDCliente)
REFERENCES CLIENTES(IDCliente)
GO

ALTER TABLE RESERVACIONES
ADD CONSTRAINT FK_Reservaciones_Mesas FOREIGN KEY (IDMesa)
REFERENCES MESAS(IDMesa)
GO

ALTER TABLE ORDENES
ADD CONSTRAINT FK_Ordenes_Clientes FOREIGN KEY (IDCliente)
REFERENCES CLIENTES(IDCliente)
GO

ALTER TABLE ORDENES
ADD CONSTRAINT FK_Ordenes_Empleados FOREIGN KEY (IDEmpleado)
REFERENCES EMPLEADOS(IDEmpleado)
GO

ALTER TABLE ORDENES
ADD CONSTRAINT FK_Ordenes_Mesas FOREIGN KEY (IDMesa)
REFERENCES MESAS(IDMesa)
GO

ALTER TABLE ORDENDETALLE
ADD CONSTRAINT FK_OrdenDetalle_Ordenes FOREIGN KEY (IDOrden)
REFERENCES ORDENES(IDOrden)
GO

ALTER TABLE ORDENDETALLE
ADD CONSTRAINT FK_OrdenDetalle_Menu FOREIGN KEY (IDMenu)
REFERENCES MENU(IDMenu)
GO

ALTER TABLE MENU
ADD CONSTRAINT FK_Menu_Productos FOREIGN KEY (IDProducto)
REFERENCES PRODUCTOS(IDProducto)
GO

ALTER TABLE EMPLEADOS
ADD CONSTRAINT FK_Empleados_Puestos FOREIGN KEY (IDPuesto)
REFERENCES PUESTOS(IDPuesto)
GO

ALTER TABLE ASISTENCIAS
ADD CONSTRAINT FK_Asistencias_Empleados FOREIGN KEY (IDEmpleado)
REFERENCES EMPLEADOS(IDEmpleado)
GO

ALTER TABLE VACACIONES
ADD CONSTRAINT FK_Vacaciones_Empleados FOREIGN KEY (IDEmpleado)
REFERENCES EMPLEADOS(IDEmpleado)
GO

ALTER TABLE HORARIOS
ADD CONSTRAINT FK_Horarios_Empleados FOREIGN KEY (IDEmpleado)
REFERENCES EMPLEADOS(IDEmpleado)
GO

ALTER TABLE PLATILLOS
ADD CONSTRAINT FK_Platillos_GrupoPlatillos FOREIGN KEY (Grupo)
REFERENCES GRUPOPLATILLOS(IDGrupo)
GO