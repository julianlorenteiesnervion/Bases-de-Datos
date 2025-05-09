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

-- 2. C�LCULO DE FIBONACCI. A partir de un n�mero obtener la sucesi�n de Fibonacci hasta ese n�mero (en la sucesi�n de Fibonacci, el siguiente n�mero es la suma de los dos anteriores): En la sucesi�n de fibonacci los dos primeros n�meros son 1 y luego la suma de los dos anteriores. 1, 1, 2, 3, 5, 8, 13, 21...
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

-- 3. OBTENER DESCUENTO M�XIMO POR CATEGOR�A:
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

-- 4.Obtener los D�AS LABORABLES ENTRE DOS FECHAS:
CREATE OR ALTER FUNCTION diasLaborables (@fechaInicio DATE, @fechaFinal DATE)
RETURNS INT
AS
	BEGIN
		RETURN ((DATEDIFF(DAY, @fechaInicio, @fechaFinal)) / 7) * 5
	END

SELECT dbo.diasLaborables ('2025-04-01', '2025-04-30')

-- 5. OBTENER TOTAL DE PEDIDOS POR CLIENTE:
CREATE OR ALTER FUNCTION obtenerPedidosPorCliente (@idCliente NCHAR(5))
RETURNS INT
AS
	BEGIN
		RETURN (SELECT COUNT(CustomerID) FROM Orders
		WHERE CustomerID = @idCliente)
	END

SELECT dbo.obtenerPedidosPorCliente ('VINET')

-- 6. Funci�n que calcule el promedio de una serie de valores. Los par�metros de la funci�n se pasar�n de forma �1,2,3,4�.�:
CREATE OR ALTER FUNCTION promedioSerieValores (@valores VARCHAR(300))
RETURNS DECIMAL(18, 2)
AS
	BEGIN
		RETURN (SELECT AVG(CAST(VALUE AS DECIMAL(18, 2))) FROM STRING_SPLIT(@valores, ','))
	END

SELECT dbo.promedioSerieValores ('1,2,3,4')

-- 7. OBTENER LOS DETALLES DE PEDIDOS DE  TODOS LOS CLIENTES. Obtener el identificador de la orden, el nombre del producto, la cantidad pedida y el nombre de la compa��ia.:
CREATE OR ALTER FUNCTION detallesPedidosTodosClientes()
RETURNS TABLE
AS
RETURN
		SELECT o.OrderID, p.ProductName, od.Quantity, c.CompanyName
		FROM Orders o
		JOIN [Order Details] od ON o.OrderID = od.OrderID
		JOIN Products p ON od.ProductID = p.ProductID
		JOIN Customers c ON o.CustomerID = c.CustomerID

SELECT * From dbo.detallesPedidosTodosClientes ()

-- 8. OBTENER VENTAS MENSUALES POR CATEGOR�A. Mostrar por cada a�o y mes, el nombre de la categor�a y la cantidad de ventas realizadas.:
CREATE OR ALTER FUNCTION VentasMensualesPorCategoria ()
RETURNS TABLE
AS
RETURN
    SELECT 
        YEAR(o.OrderDate) AS A�o,
        MONTH(o.OrderDate) AS Mes,
        c.CategoryName AS Categoria,
        SUM(od.Quantity) AS TotalVentas
    FROM Orders o
    JOIN [Order Details] od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    JOIN Categories c ON p.CategoryID = c.CategoryID
    WHERE o.OrderDate IS NOT NULL
    GROUP BY 
        YEAR(o.OrderDate),
        MONTH(o.OrderDate),
        c.CategoryName

SELECT * FROM dbo.VentasMensualesPorCategoria ()

-- 9. OBTENER RESUMEN SEMANAL DE VENTAS. Queremos mostrar por cada semana, las ventas realizadas.
CREATE OR ALTER FUNCTION ResumenSemanalVentas ()
RETURNS TABLE
AS
RETURN SELECT DATEPART(WEEK, OrderDate) AS 'Semana', COUNT(OrderID) AS 'Ventas' FROM Orders
	GROUP BY DATEPART(WEEK, OrderDate)

SELECT * FROM dbo.ResumenSemanalVentas ()

-- 10. OBTENER LOS 10 PRODUCTOS M�S VENDIDOS:
CREATE OR ALTER FUNCTION DiezProductosMasVendidos()
RETURNS TABLE
AS
RETURN SELECT TOP 10 ProductID FROM [Order Details] GROUP BY ProductID ORDER BY SUM(Quantity)

SELECT * FROM dbo.DiezProductosMasVendidos ()