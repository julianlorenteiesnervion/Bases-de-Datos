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
CREATE OR ALTER FUNCTION FnTotalApostadoCC (@idCaballo SMALLINT, @idCarrera SMALLINT)
RETURNS SMALLMONEY
AS
	BEGIN
		RETURN (SELECT Importe FROM LTApuestas WHERE @idCaballo = IDCaballo AND @idCarrera = IDCarrera)
	END

SELECT dbo.FnTotalApostadoCC (4, 2)

-- 3. Crea una función escalar llamada FnPremioConseguido que reciba como parámetros el ID de una apuesta y nos devuelva el dinero que ha ganado dicha apuesta. Para obtener el dinero conseguido se tendrá que mirar en qué posición ha quedado el caballo en la apuesta pasada por parámetro sabiendo que si ha quedado el primero el premio será el importe apostado por el campo premio1; si ha quedado en segunda posición el premio será el importe apostado por el campo premio 2, y si ha quedado en otra posición el premio será 0. Si no encontramos la apuesta pasada por parámetro devolverá un NULL.
CREATE FUNCTION dbo.FnPremioConseguido (@IDApuesta INT)
RETURNS SMALLMONEY
AS
BEGIN
    DECLARE @Premio SMALLMONEY;

    SELECT @Premio = 
        CASE 
            WHEN CC.Posicion = 1 THEN A.Importe * (CC.Premio1 / A.Importe)
            WHEN CC.Posicion = 2 THEN A.Importe * (CC.Premio2 / A.Importe)
            ELSE 0
        END
    FROM LTApuestas A
    INNER JOIN LTCaballosCarreras CC
        ON A.IDCaballo = CC.IDCaballo AND A.IDCarrera = CC.IDCarrera
    WHERE A.ID = @IDApuesta;

    RETURN @Premio
END

SELECT dbo.FnPremioConseguido (3)

-- 4. Crea una función que devuelva una tabla con tres columnas: ID del caballo, Premio1 y Premio2. El parámetro de entrada será el ID de la carrera. Debes usar la función del Ejercicio 2. Si lo estimas oportuno puedes crear otras funciones para realizar parte de los cálculos.
CREATE OR ALTER FUNCTION CalcularTotalApostadoCarrera (@idCarrera SMALLINT)
RETURNS SMALLMONEY
AS
	BEGIN
		RETURN (SELECT SUM(Importe) FROM LTApuestas
		WHERE IDCarrera = @idCarrera)
	END

-- CREATE OR ALTER FUNCTION CalcularPremiosApuestas ()

-- 