USE Bichos
GO

-- 1. Nombre de la mascota, raza, especie y fecha de nacimiento de aquellos que hayan sufrido leucemia, moquillo o toxoplasmosis
SELECT M.Alias, M.Raza, M.Especie, M.FechaNacimiento
FROM BI_Mascotas AS M
INNER JOIN BI_Mascotas_Enfermedades AS ME ON M.Codigo = ME.Mascota
INNER JOIN BI_Enfermedades AS E ON ME.IDEnfermedad = E.ID
WHERE E.Nombre IN ('Leucemia', 'Moquillo', 'Toxoplasmosis')
GROUP BY M.Alias, M.Raza, M.Especie, M.FechaNacimiento

-- 2. Nombre, raza y especie de las mascotas que hayan ido a alguna visita en primavera (del 20 de marzo al 20 de Junio)
SELECT M.Alias, M.Raza, M.Especie
FROM BI_Mascotas AS M
INNER JOIN BI_Visitas AS V ON M.Codigo = V.Mascota
WHERE (MONTH(V.Fecha) = 3 AND DAY(V.Fecha) >= 20) -- Del 20 de marzo en adelante
	OR (MONTH(V.Fecha) = 4) -- Todo abril
	OR (MONTH(V.Fecha) = 5) -- Todo mayo
	OR (MONTH(V.Fecha) = 6 AND DAY(V.Fecha) <= 20) -- Hasta el 20 de junio
GROUP BY M.Alias, M.Raza, M.Especie

-- 3. Nombre y teléfono de los propietarios de mascotas que hayan sufrido rabia, sarna, artritis o filariosis y hayan tardado más de 10 días en curarse. Los que no tienen fecha de curación, considera la fecha actual para calcular la duración del tratamiento.
SELECT C.Nombre, C.Telefono
FROM BI_Clientes AS C
INNER JOIN BI_Mascotas AS M ON C.Codigo = M.CodigoPropietario
INNER JOIN BI_Mascotas_Enfermedades AS ME ON M.Codigo = ME.Mascota
INNER JOIN BI_Enfermedades AS E ON ME.IDEnfermedad = E.ID
WHERE E.Nombre IN ('Rabia', 'Sarna', 'Artritis', 'Filariosis') AND DATEDIFF(DAY, ME.FechaInicio, ME.FechaCura) >= 10
GROUP BY C.Nombre, C.Telefono

-- 4. Nombre y especie de las mascotas que hayan ido alguna vez a consulta mientras estaban enfermas. Incluye el nombre de la enfermedad que sufrían y la fecha de la visita.
SELECT M.Alias, M.Especie, E.Nombre, V.Fecha
FROM BI_Mascotas AS M
INNER JOIN BI_Visitas AS V ON M.Codigo = V.Mascota
INNER JOIN BI_Mascotas_Enfermedades AS ME ON M.Codigo = ME.Mascota
INNER JOIN BI_Enfermedades AS E ON ME.IDEnfermedad = E.ID
WHERE V.Fecha BETWEEN ME.FechaInicio AND ME.FechaCura
GROUP BY M.Alias, M.Especie, E.Nombre, V.Fecha

-- 5. Nombre, dirección y teléfono de los clientes que tengan mascotas de al menos dos especies diferentes
SELECT C.Nombre, C.Direccion, C.Telefono
FROM BI_Clientes AS C
INNER JOIN BI_Mascotas AS M ON C.Codigo = M.CodigoPropietario
GROUP BY C.Nombre, C.Direccion, C.Telefono
HAVING COUNT(M.Especie) >= 2 -- ¿Por qué HAVING y no WHERE?

-- 6. Nombre, teléfono y número de mascotas de cada especie que tiene cada cliente. Mostrar también la especie de la mascota
SELECT C.Nombre, C.Telefono, M.Especie, COUNT(M.Codigo) AS 'Nº Mascotas'
FROM BI_Clientes AS C
INNER JOIN BI_Mascotas AS M ON C.Codigo = M.CodigoPropietario
GROUP BY C.Nombre, C.Telefono, M.Especie

-- 7. Nombre, especie y nombre del propietario de aquellas mascotas que hayan sufrido una enfermedad de tipo infeccioso (IN) o genético (GE) más de una vez.
SELECT M.Alias, M.Especie, C.Nombre
FROM BI_Clientes AS C
INNER JOIN BI_Mascotas AS M ON C.Codigo = M.CodigoPropietario
INNER JOIN BI_Mascotas_Enfermedades AS ME ON M.Codigo = ME.Mascota
INNER JOIN BI_Enfermedades AS E ON ME.IDEnfermedad = E.ID
GROUP BY M.Alias, M.Especie, C.Nombre
HAVING COUNT(E.Tipo) > 1 -- Lo mismo que antes: ¿Por qué HAVING y no WHERE?
