USE Bichos
GO

-- Introduce dos nuevos clientes. Asígnales los códigos que te parezcan adecuados
INSERT INTO BI_Clientes VALUES (107, 612345987, 'Calle Corta, 12', NULL, 'Pablo Iglesias')
INSERT INTO BI_Clientes VALUES (108, 678987987, 'Calle Utrera, 11', NULL, 'José Manuel')

-- Introduce una mascota para cada uno de ellos. Asígnales los códigos que te parezcan adecuados
INSERT INTO BI_Mascotas VALUES ('PP123', 'Ibérico', 'Cerdo', '2020-11-22', NULL, 'Pata Negra', 107)
INSERT INTO BI_Mascotas VALUES ('PP321', 'Alemán', 'Gato', '2021-05-10', NULL, 'Oreo', 108)

-- Escribe un SELECT para obtener los IDs de las enfermedades que ha sufrido alguna mascota. Los IDs no deben repetirse
SELECT IDEnfermedad FROM BI_Mascotas_Enfermedades

-- El cliente Josema Ravilla ha llevado a visita a todas sus mascotas
-- Escribe un SELECT para averiguar el código de Josema Ravilla
SELECT Codigo FROM BI_Clientes
WHERE Nombre = 'Josema Ravilla'

-- Escribe otro SELECT para averiguar los códigos de las mascotas de Josema Ravilla
SELECT Codigo FROM BI_Mascotas
WHERE CodigoPropietario = (SELECT Codigo FROM BI_Clientes WHERE Nombre = 'Josema Ravilla')

-- Con los códigos obtenidos en la consulta anterior, escribe los INSERT correspondientes en la tabla BI_Visitas. La fecha y hora se tomarán del sistema
INSERT INTO BI_Visitas VALUES (CURRENT_TIMESTAMP, 38, 20, 'GM002')
INSERT INTO BI_Visitas VALUES (CURRENT_TIMESTAMP, 40, 10, 'PH002')

-- Todos los perros del cliente 104 han enfermado el 20 de diciembre de sarna
-- Escribe un SELECT para averiguar los códigos de todos los perros del cliente 104
SELECT Codigo FROM BI_Mascotas
WHERE Especie = 'Perro' AND CodigoPropietario = 104

-- Con los códigos obtenidos en la consulta anterior, escribe los INSERT correspondientes en la tabla BI_Mascotas_Enfermedades
INSERT INTO BI_Mascotas_Enfermedades VALUES (14, 'PH004', CURRENT_TIMESTAMP, NULL)
INSERT INTO BI_Mascotas_Enfermedades VALUES (15, 'PH104', CURRENT_TIMESTAMP, NULL)
INSERT INTO BI_Mascotas_Enfermedades VALUES (16, 'PM004', CURRENT_TIMESTAMP, NULL)

-- Escribe una consulta para obtener el nombre, especie y raza de todas las mascotas, ordenados por edad
SELECT Alias, Especie, Raza FROM BI_Mascotas
ORDER BY FechaFallecimiento DESC