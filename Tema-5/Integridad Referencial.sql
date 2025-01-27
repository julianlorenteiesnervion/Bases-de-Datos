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