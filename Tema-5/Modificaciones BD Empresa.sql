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
	numEmp Int,
	nombre Varchar(50),
	edad Int,
	oficina Int,
	puesto Varchar(100),
	fecha_contrato Date,
	jefe Varchar(50),
	cuota Int,
	ventas Int
)

CREATE TABLE CLIENTES (
	numClie Int,
	nombre Varchar(50),
	resp Int,
	limiteCredito Int
)

CREATE TABLE OFICINAS (
	oficina Int,
	ciudad Varchar(30),
	region Varchar(50),
	dir Int,
	objetivo Varchar(100),
	ventas Int
)

CREATE TABLE PRODUCTOS (
	idFab Int,
	idProducto Int,
	descripcion Varchar(200),
	precio Int,
	existencias Int
)

CREATE TABLE PEDIDOS (
	numPedido Int,
	fechaPedido Date,
	clie Int,
	resp Int,
	fab Int,
	producto Int,
	cant Int,
	importe Int
)