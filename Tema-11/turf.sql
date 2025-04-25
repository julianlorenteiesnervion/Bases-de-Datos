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
		RETURN (SELECT SUM(Importe) FROM LTApuestas WHERE @idCaballo = IDCaballo AND @idCarrera = IDCarrera)
	END

SELECT dbo.FnTotalApostadoCC (1, 1)

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
    WHERE A.ID = @IDApuesta

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

-- 5. Crea una función FnPalmares que reciba un ID de caballo y un rango de fechas y nos devuelva el palmarés de ese caballo en ese intervalo de tiempo. El palmarés es el número de victorias, segundos puestos, etc. Se devolverá una tabla con dos columnas: Posición y NumVeces, que indicarán, respectivamente, cada una de las posiciones y las veces que el caballo ha obtenido ese resultado.
CREATE OR ALTER FUNCTION FnPalmares (@idCaballo SMALLINT, @fechaInicio DATE, @fechaFinal DATE)
RETURNS TABLE
AS RETURN SELECT CC.Posicion, COUNT(CC.IDCaballo) 'Veces' FROM LTCaballosCarreras CC
		INNER JOIN LTCarreras C ON CC.IDCarrera = C.ID
		WHERE CC.IDCaballo = @idCaballo AND C.Fecha BETWEEN @fechaInicio AND @fechaFinal
		GROUP BY CC.Posicion

SELECT * FROM dbo.FnPalmares (1, '2018-01-01', '2018-03-10')

-- 6. Crea una función FnCarrerasHipodromo que nos devuelva las carreras celebradas en un hipódromo en un rango de fechas. La función recibirá como parámetros el nombre del hipódromo y la fecha de inicio y fin del intervalo y nos devolverá una tabla con las siguientes columnas: Fecha de la carrera, número de orden, numero de apuestas realizadas, número de caballos inscritos, número de caballos que la finalizaron y nombre del ganador.
CREATE OR ALTER FUNCTION FnCarrerasHipodromo (@Hipodromo VARCHAR(30), @FechaInicio DATE, @FechaFin DATE)
RETURNS TABLE
AS
RETURN (
    SELECT 
        C.Fecha AS 'Fecha de la carrera',
        C.NumOrden AS 'Número de orden',
        COUNT(DISTINCT A.ID) AS 'Número de apuestas realizadas',
        COUNT(DISTINCT CC.IDCaballo) AS 'Número de caballos inscritos',
        COUNT(DISTINCT CASE WHEN CC.Posicion IS NOT NULL THEN CC.IDCaballo END) AS 'Número de caballos que finalizaron',
        MAX(CabGanador.Nombre) AS 'Nombre del ganador'
    FROM LTCarreras C
    LEFT JOIN LTApuestas A ON C.ID = A.IDCarrera
    LEFT JOIN LTCaballosCarreras CC ON C.ID = CC.IDCarrera
    LEFT JOIN (
        SELECT CC.IDCarrera, Cab.Nombre 
        FROM LTCaballosCarreras CC
        INNER JOIN LTCaballos Cab ON CC.IDCaballo = Cab.ID
        WHERE CC.Posicion = 1
    ) AS CabGanador ON C.ID = CabGanador.IDCarrera
    WHERE 
        C.Hipodromo = @Hipodromo
        AND C.Fecha BETWEEN @FechaInicio AND @FechaFin
    GROUP BY 
        C.ID, C.Fecha, C.NumOrden
)

SELECT * FROM dbo.FnCarrerasHipodromo('Gran Hipodromo de Andalucia', '2018-01-01', '2018-03-31')

-- 7. Crea una función FnObtenerSaldo a la que pasemos el ID de un jugador y una fecha y nos devuelva su saldo en esa fecha. Si se omite la fecha, se devolverá el saldo actual
CREATE OR ALTER FUNCTION FnObtenerSaldo (@IDJugador INT, @Fecha DATE = NULL)
RETURNS SMALLMONEY
AS
BEGIN
    DECLARE @Saldo SMALLMONEY;

    -- Si no se proporciona fecha, usar la fecha actual
    SET @Fecha = ISNULL(@Fecha, GETDATE());

    -- Obtener el último saldo registrado hasta la fecha especificada
    SELECT TOP 1 @Saldo = Saldo FROM LTApuntes 
    WHERE IDJugador = @IDJugador AND Fecha <= @Fecha
    ORDER BY Fecha DESC, Orden DESC

    RETURN @Saldo
END

-- Saldo del jugador 1 al 4 de marzo de 2018
SELECT dbo.FnObtenerSaldo(1, '2018-03-04') AS Saldo
