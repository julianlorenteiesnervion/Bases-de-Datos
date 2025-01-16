CREATE DATABASE Ejemplos
GO
USE Ejemplos
GO

CREATE TABLE DATOSRESTRICTIVOS (
	id SmallInt IDENTITY(1,2),
	nombre Varchar(15) NOT NULL,
	numPelos Int,
	tipoRopa Char,
	numSuerte TinyInt,
	minutos TinyInt,
	Constraint PK_DATOSRESTRICTIVOS Primary Key (id),
	Constraint CK_nombre Check (nombre NOT LIKE 'N%' AND nombre NOT LIKE 'X%'),
	Constraint CK_numPelos Check (numPelos BETWEEN 0 AND 150000),
	Constraint CK_tipoRopa Check (tipoRopa IN ('C', 'F', 'E', 'P', 'B', 'N')),
	Constraint CK_numSuerte Check ((numSuerte BETWEEN 10 AND 40) AND numSuerte % 3 = 0),
	Constraint CK_minutos Check ((minutos BETWEEN 20 AND 85) OR (minutos BETWEEN 120 AND 185)),
	Constraint UQ_DATOSRESTRICTIVOS UNIQUE (nombre)
)

CREATE TABLE DATOSRELACIONADOS (
	nombreRelacionado Varchar(15),
	palabraTabu Varchar(20),
	numRarito TinyInt,
	numMasGrande SmallInt,
	Constraint FK_DATOSRELACIONADOS_DATOSRESTRICTIVOS_nombreRelacionado
	Foreign Key (nombreRelacionado) References DATOSRESTRICTIVOS (nombre),
	Constraint CK_palabraTabu Check (palabraTabu NOT IN
	('MENA', 'Gurtel', 'ERE', 'Procés', 'sobresueldo') AND
	palabraTabu NOT LIKE '%eo'),
	Constraint CK_numRarito Check (numRarito < 20 AND numRarito NOT IN (2, 3, 5, 7, 11, 13, 17, 19)),
	Constraint CK_numMasGrande Check (numMasGrande BETWEEN numRarito AND 1000),
	Constraint PK_DATOSRELACIONADOS Primary Key (numMasGrande)
)

CREATE TABLE DATOSALMOGOLLON (
	id SmallInt,
	limiteSuperior SmallInt,
	otroNumero SmallInt,
	numeroQueVinoDelMasAlla SmallInt,
	etiqueta Varchar(3),
	Constraint PK_DATOSALMOGOLLON Primary Key (id),
	Constraint CK_id Check (id % 5 != 0),
	Constraint CK_limiteSuperior Check (limiteSuperior BETWEEN 1500 AND 2000),
	Constraint CK_otroNumero Check (otroNumero > id AND otroNumero < limiteSuperior),
	Constraint UQ_DATOSALMOGOLLON UNIQUE (otroNumero),
	Constraint FK_DATOSALMOGOLLON_DATOSRELACIONADOS_numeroQueVinoDelMasAlla
	Foreign Key (numeroQueVinoDelMasAlla) References DATOSRELACIONADOS (numMasGrande),
	Constraint CK_etiqueta Check (etiqueta NOT IN ('lao', 'leo', 'lio', 'luo'))
)