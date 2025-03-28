USE pubs
GO

-- T�tulo, precio y notas de los libros (titles) que tratan de cocina, ordenados de mayor a menor precio
SELECT title, price, notes FROM titles
WHERE TYPE IN ('mod_cook', 'trad_cook')
ORDER BY price DESC

-- ID, descripci�n y nivel m�ximo y m�nimo de los puestos de trabajo (jobs) que pueden tener un nivel 110
SELECT * FROM jobs
WHERE min_lvl <= 110 AND max_lvl >= 110

-- T�tulo, ID y tema de los libros que contengan la palabra "and� en las notas
SELECT title, title_id, [type] FROM titles
WHERE notes LIKE ('%and%')

-- Nombre y ciudad de las editoriales (publishers) de los Estados Unidos que no est�n en California ni en Texas
SELECT pub_name, city FROM publishers
WHERE country = 'USA' AND state NOT IN ('CA', 'TX')

-- T�tulo, precio, ID de los libros que traten sobre psicolog�a o negocios y cuesten entre diez y 20 d�lares
SELECT title, price, title_id FROM titles
WHERE [type] IN ('psychology', 'business') AND price BETWEEN 10 AND 20

-- Nombre completo (nombre y apellido) y direcci�n completa de todos los autores que no viven en California ni en Oreg�n
SELECT au_fname, au_lname, [address], city, [state], zip FROM authors
WHERE [state] NOT IN ('CA', 'OR')

-- Nombre completo y direcci�n completa de todos los autores cuyo apellido empieza por D, G o S
SELECT au_fname, au_lname, [address], city, [state], zip FROM authors
WHERE au_lname LIKE 'D%' OR au_lname LIKE 'G%' OR au_lname LIKE 'S%'

-- ID, nivel y nombre completo de todos los empleados con un nivel inferior a 100, ordenado alfab�ticamente
SELECT emp_id, job_lvl, fname, lname FROM employee
WHERE job_lvl < 100
ORDER BY fname ASC

-- Inserta un nuevo autor
INSERT INTO authors VALUES ('999-78-4000', 'Lorente', 'Juli�n', '642 123-5555', '123 Nervi�n Street', 'Seville', 'CA', 12345, 1)

-- Inserta dos libros, escritos por el autor que has insertado antes y publicados por la editorial "Ramona"
INSERT INTO titles VALUES ('BB1111', 'Outer Wilds', 'psychology', 1756, 80, 4000, 27, 30, 'A book about a game.', CURRENT_TIMESTAMP)
INSERT INTO titles VALUES ('BB1234', 'Ori and the Will of the Wisps', 'business', 1756, 50, 7000, 20, 400, 'The adventures of Ori.', CURRENT_TIMESTAMP)

-- Modifica la tabla jobs para que el nivel m�nimo sea 90
ALTER TABLE jobs DROP Constraint CK__jobs__min_lvl__534D60F1
UPDATE jobs
SET min_lvl = 90
WHERE min_lvl < 90
ALTER TABLE jobs ADD Constraint CK__jobs__min_lvl__534D60F1 Check (min_lvl >= 90)

-- Crea una nueva editorial (publihers) con ID 9908, nombre Mostachon Books y sede en Utrera
INSERT INTO publishers VALUES (9908, 'Mostachon Books', 'Utrera', NULL, 'Spain')

-- Cambia el nombre de la editorial con sede en Alemania para que se llame "Machen W�cher" traslasde su sede a Stuttgart
UPDATE publishers
SET pub_name = 'Machen W�cher'
WHERE country = 'Germany'

UPDATE publishers
SET city = 'Stuttgart'
WHERE city = 'M nchen'

-- Bolet�n 8.2
-- N�mero de libros que tratan de cada tema
SELECT [type], COUNT([type]) AS 'N� libros' FROM titles
GROUP BY [type]

-- N�mero de autores diferentes en cada ciudad y estado
SELECT [state] AS 'Estado', city AS 'Ciudad', COUNT(au_fname) AS 'Autores' FROM authors
GROUP BY [state], city

-- Nombre, apellidos, nivel y antig�edad en la empresa de los empleados con un nivel entre 100 y 150
SELECT fname AS 'Nombre', lname AS 'Apellido', (YEAR(CURRENT_TIMESTAMP) - YEAR(hire_date)) AS 'A�os Antig�edad' FROM employee
WHERE job_lvl BETWEEN 100 AND 150

-- N�mero de editoriales en cada pa�s. Incluye el pa�s
SELECT country AS 'Pa�s', COUNT(country) AS 'N� Editoriales'
FROM publishers
GROUP BY country

-- N�mero de unidades vendidas de cada libro en cada a�o (title_id, unidades y a�o)
SELECT title_id AS 'T�tulo', YEAR(ord_date) AS 'A�o', SUM(qty) AS 'Cantidad'
FROM sales
GROUP BY title_id, YEAR(ord_date)

-- N�mero de autores que han escrito cada libro (title_id y n�mero de autores)
SELECT title_id AS 'T�tulo', COUNT(au_id) AS 'N� Autores'
FROM titleauthor
GROUP BY title_id

-- ID, T�tulo, tipo y precio de los libros cuyo adelanto inicial (advance) tenga un valor superior a $7.000, ordenado por tipo y t�tulo
SELECT title_id AS 'ID', title AS 'T�tulo', [type] AS 'Tipo', price AS 'Precio'
FROM titles
WHERE advance > 7000
ORDER BY type, title ASC
