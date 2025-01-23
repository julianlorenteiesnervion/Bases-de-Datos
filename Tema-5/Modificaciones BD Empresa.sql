/*
Base de Datos Empresa:

Empleados: numemp (PK), nombre, edad, oficina, puesto, fecha_contrato, jefe, cuota, ventas;

Clientes: numclie (PK), nombre, resp(FK Empleados(numemp)), limitecredito;

Oficinas: oficina (PK), ciudad, region, dir(FK Empleados(numemp)), objetivo, ventas;

Productos:idfab (PK),   idproducto (PK), descripcion, precio, existencias;

Pedidos: numpedido (PK), fechapedido, clie (FK Clientes(numclie)), resp (FK Empleados(numemp)), fab (FK Productos(idfab)),
		 producto (FK Productos(idproducto)), cant, importe;
*/

CREATE DATABASE Empresa
GO
USE Empresa
GO

CREATE TABLE EMPLEADOS (
	numEmp Int Not Null,
	nombre Varchar(50),
	edad Int,
	oficina Int,
	puesto Varchar(100),
	fecha_contrato Date,
	jefe Int,
	cuota Int,
	ventas Int
)

ALTER TABLE EMPLEADOS ADD Constraint PK_EMPLEADOS Primary Key (numEmp)
ALTER TABLE EMPLEADOS ADD Constraint FK_EMPLEADOS_EMPLEADOS_jefe Foreign Key (jefe) References EMPLEADOS (numEmp)
ON DELETE NO ACTION
ON UPDATE NO ACTION

CREATE TABLE CLIENTES (
	numClie Int Not Null,
	nombre Varchar(50),
	resp Int,
	limiteCredito Int
)

ALTER TABLE CLIENTES ADD Constraint PK_CLIENTES Primary Key (numClie)

CREATE TABLE OFICINAS (
	oficina Int Not Null,
	ciudad Varchar(30),
	region Varchar(50),
	dir Int,
	objetivo Varchar(100),
	ventas Int
)

ALTER TABLE OFICINAS ADD Constraint PK_OFICINAS Primary Key (oficina)
ALTER TABLE OFICINAS ADD Constraint FK_OFICINAS_EMPLEADOS_dir Foreign Key (dir) References EMPLEADOS (numEmp)
ON UPDATE CASCADE
ON DELETE CASCADE

CREATE TABLE PRODUCTOS (
	idFab Int Not Null,
	idProducto Int Not Null,
	descripcion Varchar(200),
	precio Int,
	existencias Int
)

ALTER TABLE PRODUCTOS ADD Constraint PK_PRODUCTOS Primary Key (idFab, idProducto)

CREATE TABLE PEDIDOS (
	numPedido Int Not Null,
	fechaPedido Date,
	clie Int,
	resp Int,
	fab Int,
	producto Int,
	cant Int,
	importe Int
)

ALTER TABLE PEDIDOS ADD Constraint PK_PEDIDOS Primary Key (numPedido)
ALTER TABLE PEDIDOS ADD Constraint FK_PEDIDOS_CLIENTES_clie Foreign Key (clie) References CLIENTES (numClie)
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE PEDIDOS ADD Constraint FK_PEDIDOS_EMPLEADOS_resp Foreign Key (resp) References EMPLEADOS (numEmp)
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE PEDIDOS ADD Constraint FK_PEDIDOS_PRODUCTOS_fab_producto Foreign Key (fab, producto) References PRODUCTOS (idFab, idProducto)
ON UPDATE CASCADE
ON DELETE CASCADE