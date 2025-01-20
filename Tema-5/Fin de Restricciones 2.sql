CREATE DATABASE FinRestricciones2
GO
USE FinRestricciones
GO

CREATE TABLE Productos (
    ID INT IDENTITY(1,1) PRIMARY KEY,           -- ID único para cada producto
    Nombre NVARCHAR(100) NOT NULL,               -- Nombre del producto
    Precio DECIMAL(10, 2) NOT NULL,              -- Precio del producto
    Stock INT NOT NULL,                          -- Cantidad disponible en stock
    Categoria NVARCHAR(50) NOT NULL,             -- Categoría del producto
    FechaIngreso DATE NOT NULL,                  -- Fecha de ingreso del producto
    Descuento DECIMAL(5, 2) NULL,                -- Descuento aplicable al producto
    Activo BIT NOT NULL,                          -- Estado activo o inactivo del producto
	Constraint CK_Precio Check (Precio > 0 OR (Descuento = 0 AND Precio = CAST(Precio AS INT))),
	Constraint CK_Stock Check (((Stock % 10 = 0 AND Categoria = 'Electrónica') OR (Stock < 500 AND Categoria = 'Alimentos'))),
	Constraint CK_Stock2 Check ((Stock >= 0 AND Activo = 0) AND (Stock > 0 AND Activo = 1)),
	Constraint CK_Descuento Check ((Descuento < (Precio * 0.5) AND Descuento >= 0) OR (Descuento < 20 AND Activo = 1) OR (Descuento > 0 AND FechaIngreso > '2020-01-01')),
	Constraint CK_FechaIngreso Check (FechaIngreso < CURRENT_TIMESTAMP),
	Constraint CK_Nombre Check (Nombre LIKE ('%[a-zA-Z0-9]%')),
	Constraint CK_Categoria Check (Categoria IN ('Electrónica', 'Ropa', 'Alimentos'))
);


insert into Productos values ('hola', 50, 2, 'Electrónica', '2020-02-02', 50, 1)