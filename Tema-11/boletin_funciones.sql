USE TransactSql
GO

-- 1. Pasar a May�sculas un nombre y apellido pasado por par�metro
CREATE OR ALTER FUNCTION pasarAMayus (@nombre VARCHAR(40), @apellido VARCHAR(40))
RETURNS VARCHAR(40) AS
	BEGIN
		RETURN CONCAT(UPPER(@nombre), ' ', UPPER(@apellido))
	END

SELECT dbo.pasarAMayus('Julian', 'Lorente Marroco')

-- 2. Pasar el n�mero del d�a (lunes 1, domingo 7) y devolver el texto Lunes, Martes...
CREATE OR ALTER FUNCTION numADia (@numDia INT)
RETURNS VARCHAR(10) AS
	BEGIN

		DECLARE @dia VARCHAR(10)

		SET @dia = CASE @numDia
		WHEN 1 THEN 'Lunes'
		WHEN 2 THEN 'Martes'
		WHEN 3 THEN 'Mi�rcoles'
		WHEN 4 THEN 'Jueves'
		WHEN 5 THEN 'Viernes'
		WHEN 6 THEN 'S�bado'
		WHEN 7 THEN 'Domingo'
		ELSE 'N/A'
		END

		RETURN @dia

	END

SELECT dbo.numADia(1)

-- 3. Crear una funcion a la que pasar dos n�meros y realizar la suma
CREATE OR ALTER FUNCTION suma (@num1 INT, @num2 INT)
RETURNS INT
	BEGIN
		RETURN @num1 + @num2
	END

SELECT dbo.suma(3, 2)

-- 4. Dise�e un programa que calcule la suma de las cifras de un n�mero sin importar cu�ntas cifras tenga el n�mero.
CREATE OR ALTER FUNCTION sumaCifras (@num INT)
RETURNS INT
AS
BEGIN
    DECLARE @suma INT = 0

    WHILE (@num > 0)
    BEGIN
        SET @suma += (@num % 10)
        SET @num /= 10
    END

    RETURN @suma
END

SELECT dbo.sumaCifras(234)

-- 5.Dise�e un programa que reciba un n�mero natural y retorne la suma de sus d�gitos impares.
CREATE OR ALTER FUNCTION sumaCifrasImpares (@num INT)
RETURNS INT
AS
BEGIN
    DECLARE @suma INT = 0

    WHILE (@num > 0)
    BEGIN
		IF (@num % 2 > 0)
		BEGIN
        SET @suma += (@num % 10)
		END
        SET @num /= 10
    END

    RETURN @suma
END

select dbo.sumaCifrasImpares(2345)

-- 6.Dado un n�mero natural de cuatro cifras dise�e una funci�n que permita obtener el rev�s del n�mero. As�, si se lee el n�mero 2385 el programa deber� imprimir 5832.
CREATE OR ALTER FUNCTION numeroReves (@num INT)
RETURNS INT
AS
BEGIN
    DECLARE @reves INT = 0

    WHILE (@num > 0)
    BEGIN
        SET @reves = CONCAT(@reves, @num % 10)
        SET @num /= 10
    END

    RETURN @reves
END

SELECT dbo.numeroReves(2385)