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
	Constraint PK_COCHES Primary Key (matricula)
)

CREATE TABLE COCHERAS (
	id Int,
	Constraint PK_COCHERAS Primary Key (id),
)

CREATE TABLE COCHES_COCHERAS (
	matricula Int,
	idCochera Int Not Null,
	Constraint PK_COCHES_COCHERAS Primary Key (matricula),
	Constraint FK_CochesCocheras_Cocheras_idCochera Foreign Key (idCochera) References COCHERAS (id),
	Constraint UQ_COCHES_COCHERAS Unique (idCochera)
)

/* BASE DE DATOS EJERCICIO 9 */
CREATE DATABASE Ej9
GO
USE Ej9
GO

CREATE TABLE AULAS (
	numero Int,
	Constraint PK_AULAS Primary Key (numero)
)

CREATE TABLE ORDENADORES (
	id Int,
	aula Int,
	Constraint PK_ORDENADORES Primary Key (id),
	Constraint FK_Ordenadores_Aulas_aula Foreign Key (aula) References AULAS (numero)
)

CREATE TABLE ALUMNOS (
	dni Int,
	ordenador Int,
	Constraint PK_ALUMNOS Primary Key (dni),
	Constraint FK_Alumnos_Ordenadores_ordenador Foreign Key (ordenador) References ORDENADORES (id)
)

/* BASE DE DATOS EJERCICIO 10 */
CREATE DATABASE Ej10
GO
USE Ej10
GO

CREATE TABLE ALUMNOS (
	dni Int,
	Constraint PK_ALUMNOS Primary Key (dni)
)

CREATE TABLE ORDENADORES (
	id Int,
	Constraint PK_ORDENADORES Primary Key (id)
)

CREATE TABLE AULAS (
	numero Int,
	Constraint PK_AULAS Primary Key (numero)
)

CREATE TABLE UTILIZA (
	dni Int,
	ordenador Int,
	curso Int,
	Constraint PK_UTILIZA Primary Key (dni, ordenador, curso),
	Constraint FK_Utiliza_Alumnos_dni Foreign Key (dni) References ALUMNOS (dni),
	Constraint FK_Utiliza_Ordenadores_ordenador Foreign Key (ordenador) References ORDENADORES (id)
)

CREATE TABLE ESTA (
	ordenador Int,
	aula Int,
	curso Int,
	Constraint PK_ESTA Primary Key (ordenador, aula, curso),
	Constraint FK_Esta_Ordenadores_ordenador Foreign Key (ordenador) References ORDENADORES (id),
	Constraint FK_Esta_Aulas_aula Foreign Key (aula) References AULAS (numero)
)

/* BASE DE DATOS EJERCICIO 11 */
CREATE DATABASE Ej11
GO
USE Ej11
GO

CREATE TABLE ALUMNOS (
	dni Int,
	Constraint PK_ALUMNOS Primary Key (dni)
)

CREATE TABLE ORDENADORES (
	id Int,
	Constraint PK_ORDENADORES Primary Key (id)
)

CREATE TABLE APLICACIONES (
	titulo Varchar(30),
	Constraint PK_APLICACIONES Primary Key (titulo)
)

CREATE TABLE UTILIZA (
	alumno Int,
	ordenador Int,
	aplicacion Varchar(30),
	tiempo Time,
	Constraint PK_UTILIZA Primary Key (alumno, aplicacion),
	Constraint FK_Utiliza_Alumnos_alumno Foreign Key (alumno) References ALUMNOS (dni),
	Constraint FK_Utiliza_Ordenadores_ordenador Foreign Key (ordenador) References ORDENADORES (id),
	Constraint FK_Utiliza_Aplicaciones_aplicacion Foreign Key (aplicacion) References APLICACIONES (titulo)
)

/* BASE DE DATOS EJERCICIO 12 */
CREATE DATABASE Ej12
GO
USE Ej12
GO

CREATE TABLE AUTOBUSES (
	matricula Int,
	Constraint PK_AUTOBUSES Primary Key (matricula)
)

CREATE TABLE LINEAS (
	numero Int,
	Constraint PK_LINEAS Primary Key (numero)
)

CREATE TABLE CALLES (
	nombre Varchar(100),
	Constraint PK_CALLES Primary Key (nombre)
)

CREATE TABLE CONDUCTORES (
	dni Int,
	calle Varchar(100),
	Constraint PK_CONDUCTORES Primary Key (dni),
	Constraint FK_Conductores_Calles_calle Foreign Key (calle) References CALLES (nombre)
)

CREATE TABLE UTILIZA (
	conductor Int,
	autobus Int,
	linea Int,
	dia Date,
	Constraint PK_UTILIZA Primary Key (conductor, autobus, dia),
	Constraint FK_Utiliza_Conductores_conductor Foreign Key (conductor) References CONDUCTORES (dni),
	Constraint FK_Utiliza_Autobuses_autobus Foreign Key (autobus) References AUTOBUSES (matricula),
	Constraint FK_Utiliza_Lineas_linea Foreign Key (linea) References LINEAS (numero)
)

CREATE TABLE PASA (
	linea Int,
	calle Varchar(100),
	Constraint PK_PASA Primary Key (linea, calle),
	Constraint FK_Pasa_Lineas_linea Foreign Key (linea) References LINEAS (numero),
	Constraint FK_Pasa_Calles_calle Foreign Key (calle) References CALLES (nombre)
)