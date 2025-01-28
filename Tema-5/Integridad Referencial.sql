DROP DATABASE IF EXISTS Agenda;
CREATE DATABASE Agenda;
GO
USE Agenda;
GO

CREATE TABLE Contactos (
  nombre varchar(25),
  dni varchar(9),
  PRIMARY KEY (dni)
)

CREATE TABLE Telefonos (
  id int Identity(0,1),
  numero varchar(9),
  dni varchar(9),
   Constraint PK_TELEFONOS PRIMARY KEY(id),
   Constraint FK_TELEFONOS_CONTACTOS_dni Foreign Key (dni) References CONTACTOS (dni)
   ON UPDATE CASCADE
   ON DELETE CASCADE
   -- Para anular, usaría SET NULL
   -- Para rechazar, usaría NO ACTION
   -- Para propagar, uso el CASCADE
)

INSERT INTO Contactos values('Ana', '111');
INSERT INTO Contactos values('Pepe', '222');
INSERT INTO Contactos values('Juan', '333');

INSERT INTO Telefonos (numero, dni) values ('1111', '111');
INSERT INTO Telefonos (numero, dni) values ('2222', '111');
INSERT INTO Telefonos (numero, dni) values ('3333', '111');
INSERT INTO Telefonos (numero, dni) values ('4444', '222');
INSERT INTO Telefonos (numero, dni) values ('5555', '222');
INSERT INTO Telefonos (numero, dni) values ('5555', '333');

DROP DATABASE IF EXISTS Instituto
CREATE DATABASE Instituto
GO
USE Instituto
GO

CREATE TABLE PROFESORES (
	dni Int,
	nombre Varchar(100),
	Constraint PK_PROFESORES Primary Key (dni)
)

CREATE TABLE ASIGNATURAS (
	cod Int,
	nombre Varchar(100),
	horasSemanales Int,
	profesor Int,
	Constraint PK_ASIGNATURAS Primary Key (cod),
	Constraint FK_ASIGNATURAS_PROFESORES_profesor Foreign Key (profesor) References PROFESORES (dni)
	ON UPDATE SET NULL
	ON DELETE SET NULL
)



CREATE TABLE ALUMNOS (
	dni Int,
	asignatura Int,
	Constraint PK_ALUMNOS Primary Key (dni),
	Constraint FK_ALUMNOS_ASIGNATURAS_asignatura Foreign Key (asignatura) References ASIGNATURAS (cod)
	ON UPDATE CASCADE
	ON DELETE CASCADE
)
	

CREATE TABLE MATRICULAS (
	id Int,
	alumno Int,
	asignatura Int,
	nombre Varchar(100),
	dni Int,
	Constraint PK_MATRICULAS Primary Key (id),
	Constraint FK_MATRICULAS_ALUMNOS_alumno Foreign Key (alumno) References ALUMNOS (dni)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	Constraint FK_MATRICULAS_ASIGNATURAS_asignatura Foreign Key (asignatura) References ASIGNATURAS (cod)
	ON UPDATE CASCADE
	ON DELETE CASCADE
)


ALTER TABLE MATRICULAS ADD
alumno Int,
asignatura Int,
Constraint FK_MATRICULAS_ALUMNOS_alumno Foreign Key (alumno) References ALUMNOS (dni)
ON UPDATE CASCADE
ON DELETE CASCADE,
Constraint FK_MATRICULAS_ASIGNATURAS_asignatura Foreign Key (asignatura) References ASIGNATURAS (cod)
ON UPDATE CASCADE
ON DELETE CASCADE