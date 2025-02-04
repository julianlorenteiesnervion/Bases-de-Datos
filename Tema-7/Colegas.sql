Create Database Colegas
go
Use Colegas
GO
-- People
Create Table People (
	ID SmallInt Not NULL Constraint PKPeople Primary Key,
	Nombre VarChar(20) Not NULL,
	Apellidos VarChar(20) Not NULL,
	FechaNac Date NULL
)
GO
-- Carros
Create Table Carros (
	ID SmallInt Not NULL Constraint PKCarros Primary Key,
	Marca VarChar(15) Not NULL,
	Modelo VarChar(20) Not NULL,
	Anho SmallInt NULL Constraint CKAnno Check (Anho Between 1900 AND YEAR(Current_Timestamp)),
	Color VarChar(15),
	IDPropietario SmallInt NULL Constraint FKCarroPeople Foreign Key References People (ID) On Update No action On Delete No action
)
-- Libros
Create Table Libros(
	ID Int Not NULL Constraint PKLibros Primary Key,
	Titulo VarChar(60) Not NULL,
	Autors VarChar(50) NULL
)
GO
--Lecturas
Create Table Lecturas(
	IDLibro Int Not NULL,
	IDLector SmallInt Not NULL,
	Constraint PKLecturas Primary Key (IDLibro, IDLector),
	Constraint FKLecturasLibros Foreign Key (IDLibro) References Libros (ID) On Update No action On Delete No action,
	Constraint FKLecturasLectores Foreign Key (IDLector) References People (ID) On Update No action On Delete No action,
	AnhoLectura SmallInt NULL
)

-- Insercciones People
INSERT INTO People VALUES (1, 'Eduardo', 'Mingo', '1990-07-14')
INSERT INTO People VALUES (2, 'Margarita', 'Padera', '1992-11-11')
INSERT INTO People VALUES (4, 'Eloisa', 'Lamandra', '2000-03-02')
INSERT INTO People VALUES (5, 'Jordi', 'Videndo', '1989-05-28')
INSERT INTO People VALUES (6, 'Alfonso', 'Sito', '1978-10-10')

-- Insercciones Carros
INSERT INTO Carros VALUES (1, 'Seat', 'Ibiza', 2014, 'Blanco', NULL)
INSERT INTO Carros VALUES (2, 'Ford', 'Focus', 2016, 'Rojo', 1)
INSERT INTO Carros VALUES (3, 'Toyota', 'Prius', 2017, 'Blanco', 4)
INSERT INTO Carros VALUES (5, 'Renault', 'Megane', 2004, 'Azul', 2)
INSERT INTO Carros VALUES (8, 'Mitsubishi', 'Colt', 2011, 'Rojo', 6)

-- Insercciones Libros
INSERT INTO Libros VALUES (2, 'El corazón de las Tinieblas', 'Joseph Conrad')
INSERT INTO Libros VALUES (4, 'Cien años de soledad', 'Gabriel García Márquez')
INSERT INTO Libros VALUES (8, 'Harry Potter y la cámara de los secretos', 'J. K. Rowling')
INSERT INTO Libros VALUES (16, 'Evangelio del Flying Spaguetti Monster', 'Bobby Henderson')

-- Insercciones Lecturas
INSERT INTO Lecturas (IDLibro, IDLector) VALUES (4, 1)
INSERT INTO Lecturas (IDLibro, IDLector) VALUES (2, 2)
INSERT INTO Lecturas (IDLibro, IDLector) VALUES (4, 4)
INSERT INTO Lecturas (IDLibro, IDLector) VALUES (8, 4)
INSERT INTO Lecturas (IDLibro, IDLector) VALUES (16, 5)
INSERT INTO Lecturas (IDLibro, IDLector) VALUES (16, 6)

-- Margarita le ha vendido su coche a Alfonso
UPDATE Carros
SET IDPropietario = (SELECT ID FROM People WHERE Nombre = 'Alfonso')
WHERE IDPropietario = (SELECT ID FROM People WHERE Nombre = 'Margarita')

-- Queremos saber los nombres y apellidos de todos los que tienen 30 años o más
SELECT Nombre, Apellidos
FROM People
WHERE DATEDIFF(YEAR, FechaNac, GETDATE()) >= 30

-- Marca, año y modelo de todos los coches que no sean blancos ni verdes
SELECT Marca, Anho, Modelo
FROM Carros
WHERE Color NOT IN ('Blanco', 'Verde')

-- El nuevo gobierno regional ha prohibido todas las religiones, excepto la oficial. Por ello, los pastafarianos se ven obligados a ocultarse. Inserta un nuevo libro titulado "Vidas santas" cuyo autor es el Abate Bringas. Actualiza la tabla lecturas para cambiar las lecturas del Evangelio del FSM por este nuevo libro
INSERT INTO Libros VALUES (32, 'Vidas santas', 'Abate Bringas')

UPDATE Lecturas
SET IDLibro = (SELECT ID FROM Libros WHERE Titulo = 'Vidas santas')
WHERE IDLibro = (SELECT ID FROM Libros WHERE Titulo = 'Evangelio del Flying Spaguetti Monster')

-- Eloísa también ha leído El corazón de las tinieblas y le ha gustado mucho
INSERT INTO Lecturas (IDLibro, IDLector) VALUES (2, 4)

-- Jordi se ha comprado el Seat IbIZA
INSERT INTO Carros VALUES (9, 'Seat', 'Ibiza', 2010, 'Negro', 5)

-- Haz una consulta que nos devuelva los ids de los colegas que han leído alguno de los libros con ID par
SELECT IDLector
FROM Lecturas
WHERE IDLibro % 2 = 0