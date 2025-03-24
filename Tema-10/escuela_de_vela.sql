USE LeoSailing
GO

-- 1. Queremos saber nombre, apellidos y edad de cada miembro y el número de regatas que ha disputado en barcos de cada clase.
SELECT M.nombre, M.apellidos, DATEDIFF(YEAR, ) AS 'Edad' FROM LS_Miembros M