/* BASE DE DATOS EJERCICIO 2 */
CREATE DATABASE Ej2
GO
USE Ej2
GO

CREATE TABLE Empleados (
	DNI tinyInt,
	Constraint PK_DNI Primary Key (DNI)
)

CREATE TABLE Departamentos (
	NUMDPTO int,
	Constraint PK_NUMDPTO Primary Key (NUMDPTO)
)

CREATE TABLE Deptos_Empleados (
	DNI_EMPLEADO tinyInt,
	NUM_DPTO int,
	Constraint FK_DeptosEmpleados_Empleados_dniEmpleado FOREIGN KEY (DNI_EMPLEADO) REFERENCES Empleados (DNI),
	Constraint FK_DeptosEmpleados_Departamentos_numDpto FOREIGN KEY (NUM_DPTO) REFERENCES Departamentos (NUMDPTO)
)

/* BASE DE DATOS EJERCICIO 3 */
CREATE DATABASE Ej3
GO
USE Ej3
GO

CREATE TABLE FUTBOLISTAS (
	dni tinyInt,
	Constraint PK_FUTBOLISTAS Primary Key (dni)
)

CREATE TABLE PARTIDOS (
	id int,
	fecha date,
	Constraint PK_PARTIDOS Primary Key (id)
)

CREATE TABLE PARTIDOS_JUGADORES (
	id int,
	dni tinyInt,
	CONSTRAINT FK_PartidosJugadores_Partidos_id FOREIGN KEY (id) REFERENCES PARTIDOS (id),
	CONSTRAINT FK_PartidosJugadores_Futbolistas_dni FOREIGN KEY (dni) REFERENCES FUTBOLISTAS (dni)
)

/* BASE DE DATOS EJERCICIO 4 */
CREATE DATABASE Ej4
GO
USE Ej4
GO

CREATE TABLE CLIENTES (
	dni Int,
	Constraint PK_CLIENTES Primary Key (dni)
)

CREATE TABLE TRAJES (
	modelo Varchar(10),
	Constraint PK_TRAJES Primary Key (modelo)
)

CREATE TABLE COMPRAS (
	dni Int,
	modelo Varchar(10),
	fecha Date,
	unidades TinyInt,
	Constraint PK_COMPRAS Primary Key (dni, modelo, fecha),
	Constraint FK_Compras_Clientes_dni Foreign Key (dni) References CLIENTES (dni),
	Constraint FK_Compras_Trajes_modelo Foreign Key (modelo) References TRAJES (modelo)
)

/* BASE DE DATOS EJERCICIO 5 */
CREATE DATABASE Ej5
GO
USE Ej5
GO

CREATE TABLE PERSONAS (
	dni Int,
	Constraint PK_PERSONAS Primary Key (dni)
)

CREATE TABLE COCHES (
	matricula Int,
	color varchar(10),
	dueno Int,
	Constraint PK_COCHES Primary Key (matricula),
	Constraint FK_Coches_Personas_dueno Foreign Key (dueno) References PERSONAS (dni)
)

/* BASE DE DATOS EJERCICIO 6 */
CREATE DATABASE Ej6
GO
USE Ej6
GO

CREATE TABLE PERSONAS (
	dni Int,
	Constraint PK_PERSONAS Primary Key (dni)
)

CREATE TABLE COCHES (
	matricula Int,
	color Varchar(10),
	Constraint PK_COCHES Primary Key (matricula)
)

CREATE TABLE POSEEDORES (
	dni Int,
	matricula Int,
	fecha Date,
	Constraint PK_POSEEDORES Primary Key (dni, matricula, fecha),
	Constraint FK_Poseedores_Personas_dni Foreign Key (dni) References PERSONAS (dni),
	Constraint FK_Poseedores_Coches_matricula Foreign Key (matricula) References COCHES (matricula)
)

/* BASE DE DATOS EJERCICIO 8 */
CREATE DATABASE Ej8
GO
USE Ej8
GO

CREATE TABLE COCHES (
	matricula Int,
	cochera Int,
	Constraint PK_COCHES Primary Key (matricula)
)

CREATE TABLE COCHERAS (
	id Int,
	coche Int,
	Constraint PK_COCHERAS Primary Key (id),
	Constraint FK_COCHERA_COCHES Foreign Key (id) References COCHES (cochera),
	Constraint FK_MATRICULA_COCHES Foreign Key (coche) References COCHES (matricula)
)