USE Bichos
GO

-- Introduce dos nuevos clientes. As�gnales los c�digos que te parezcan adecuados
INSERT INTO BI_Clientes VALUES (107, 612345987, 'Calle Corta, 12', NULL, 'Pablo Iglesias')
INSERT INTO BI_Clientes VALUES (108, 678987987, 'Calle Utrera, 11', NULL, 'Jos� Manuel')

-- Introduce una mascota para cada uno de ellos. As�gnales los c�digos que te parezcan adecuados
INSERT INTO BI_Mascotas VALUES ('PP123', 'Ib�rico', 'Cerdo', '2020-11-22', NULL, 'Pata Negra', 107)
INSERT INTO BI_Mascotas VALUES ('PP321', 'Alem�n', 'Gato', '2021-05-10', NULL, 'Oreo', 108)

-- Escribe un SELECT para obtener los IDs de las enfermedades que ha sufrido alguna mascota. Los IDs no deben repetirse
SELECT IDEnfermedad FROM BI_Mascotas_Enfermedades
