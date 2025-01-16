CREATE DATABASE FinRestricciones
GO
USE FinRestricciones
GO

CREATE TABLE Empleados (
    ID INT IDENTITY(1,1) PRIMARY KEY,           -- ID único para cada empleado
    Nombre VARCHAR(100) NOT NULL,               -- Nombre del empleado
    Apellido VARCHAR(100) NOT NULL,             -- Apellido del empleado
    Edad INT NOT NULL,                           -- Edad del empleado
    FechaContratacion DATE NOT NULL,             -- Fecha de contratación
    Salario DECIMAL(10, 2) NOT NULL,             -- Salario del empleado
    Cargo VARCHAR(50) NOT NULL,                 -- Cargo del empleado
    Departamento VARCHAR(50) NOT NULL,          -- Departamento en el que trabaja
    FechaNacimiento DATE NOT NULL,               -- Fecha de nacimiento
    Email VARCHAR(100) NOT NULL,                -- Correo electrónico
    Activo BIT NOT NULL,                         -- Estado activo o inactivo del empleado
    FechaSalida DATE NULL,                        -- Fecha de salida del empleado
	Constraint CK_Edad Check (Edad BETWEEN 18 AND 65),
	Constraint CK_Salario Check ((Salario BETWEEN 1000 AND 100000) AND (Salario IS NOT NULL AND Activo = 1) AND (Salario % 500 = 0)),
	Constraint CK_Email Check (Email LIKE '%@%' AND Email LIKE '%.%'),
	Constraint CK_FechaSalida Check (FechaSalida < FechaContratacion),
	Constraint CK_FechaNacimiento Check (FechaNacimiento < FechaContratacion),
	Constraint CK_Nombre Check (Nombre NOT LIKE '%[0-9]%'),
	Constraint CK_Apellido Check (Apellido NOT LIKE '%[a-zA-Z]%'),
	Constraint CK_Departamento Check (Departamento NOT IN ('General') AND Activo = 1),
	Constraint CK_FechaContratacion Check ((FechaContratacion < CAST(CURRENT_TIMESTAMP AS DATE)) AND ((CAST(CURRENT_TIMESTAMP AS DATE) - FechaContratacion = 1095) OR (FechaSalida IS NOT NULL)))
);