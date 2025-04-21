USE AntonioTurf
GO

-- 1. Crea una función inline llamada FnCarrerasCaballo que reciba un rango de fechas (inicio y fin) y nos devuelva el número de carreras disputadas por cada caballo entre esas dos fechas. Las columnas serán ID (del caballo), nombre, sexo, fecha de nacimiento y número de carreras disputadas.
CREATE OR ALTER FUNCTION FnCarrerasCaballo (@inicio DATE, @fin DATE)
RETURNS TABLE
AS
RETURN SELECT CABALLOS.ID, CABALLOS.Nombre, CABALLOS.Sexo, CABALLOS.FechaNacimiento, COUNT(CARRERAS.ID) AS 'Nº Carreras' FROM LTCarreras CARRERAS
	INNER JOIN LTCaballos CABALLOS ON CARRERAS.ID = CABALLOS.ID
	WHERE CARRERAS.Fecha BETWEEN @inicio AND @fin
	GROUP BY CABALLOS.ID, CABALLOS.Nombre, CABALLOS.Sexo, CABALLOS.FechaNacimiento

SELECT * FROM dbo.FnCarrerasCaballo ('2018-01-10', '2018-02-20')

-- 2. Crea una función escalar llamada FnTotalApostadoCC que reciba como parámetros el ID de un caballo y el ID de una carrera y nos devuelva el dinero que se ha apostado a ese caballo en esa carrera.
CREATE OR ALTER FUNCTION FnTotalApostadoCC ()

SELECT * FROM LTCaballosCarreras