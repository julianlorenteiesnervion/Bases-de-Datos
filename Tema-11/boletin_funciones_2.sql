USE Northwind
GO

-- 1. OBTENER CANTIDAD DE PRODUCTOS VENDIDOS:
CREATE OR ALTER FUNCTION cantidadProductosVendidos ()
RETURNS INT AS
	BEGIN
		DECLARE @res INT
		SET @res = (SELECT SUM(Quantity) FROM [Order Details])
		RETURN @res
	END

SELECT dbo.cantidadProductosVendidos ()

-- 2. CÁLCULO DE FIBONACCI. A partir de un número obtener la sucesión de Fibonacci hasta ese número (en la sucesión de Fibonacci, el siguiente número es la suma de los dos anteriores): En la sucesión de fibonacci los dos primeros números son 1 y luego la suma de los dos anteriores. 1, 1, 2, 3, 5, 8, 13, 21...
CREATE OR ALTER FUNCTION fibonacci (@num INT)
RETURNS VARCHAR(1000)
AS
BEGIN
	DECLARE @mensaje VARCHAR(1000) = '1'
	DECLARE @numAnterior INT = 1
	DECLARE @numSiguiente INT = 1
	DECLARE @temp INT

	WHILE (@numSiguiente <= @num)
	BEGIN
		SET @mensaje += ', ' + CAST(@numSiguiente AS VARCHAR)
		SET @temp = @numSiguiente
		SET @numSiguiente = @numAnterior + @numSiguiente
		SET @numAnterior = @temp
	END

	RETURN @mensaje
END

SELECT dbo.fibonacci (21) AS 'Fibonacci'

-- 3. OBTENER DESCUENTO MÁXIMO POR CATEGORÍA:
CREATE OR ALTER FUNCTION descuentoMaximoPorCategoria (@categoria NVARCHAR(15))
RETURNS REAL
AS
	BEGIN
		RETURN (SELECT MAX(O.Discount) FROM Categories C
		INNER JOIN Products P ON C.CategoryID = P.CategoryID
		INNER JOIN [Order Details] O ON P.ProductID = O.ProductID
		WHERE C.CategoryName = @categoria)
	END

SELECT dbo.descuentoMaximoPorCategoria ('Seafood')

-- 4.Obtener los DÍAS LABORABLES ENTRE DOS FECHAS:
CREATE OR ALTER FUNCTION diasLaborables (@fechaInicio DATE, @fechaFinal DATE)
RETURNS INT
AS
	BEGIN
		RETURN ((DATEDIFF(DAY, @fechaInicio, @fechaFinal)) / 7) * 5
	END

SELECT dbo.diasLaborables ('2025-04-01', '2025-04-30')

-- 5. OBTENER TOTAL DE PEDIDOS POR CLIENTE:
CREATE OR ALTER FUNCTION obtenerPedidosPorCliente (@idCliente INT)
