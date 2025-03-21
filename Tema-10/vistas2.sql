USE AdventureWorksLT2019
GO

-- 1. Nombre y dirección completas de todos los clientes que tengan alguna sede en Canada.
CREATE VIEW FullAddressCanadaCustomer AS (
	SELECT C.FirstName, CONCAT(A.AddressLine1, ISNULL(A.AddressLine2, ''), ' ', A.City, ' ', A.StateProvince, ' ', A.CountryRegion) AS 'Full Address' FROM SalesLT.Customer AS C
	INNER JOIN SalesLT.CustomerAddress AS CA ON C.CustomerID = CA.CustomerID
	INNER JOIN SalesLT.Address AS A ON CA.AddressID = A.AddressID
	WHERE A.CountryRegion = 'Canada'
)

-- 2. Nombre de cada categoría y producto más caro y más barato de la misma, incluyendo los precios.
WITH ProductosPorCategoria AS (
    SELECT
        pc.Name AS Categoria,
        p.Name AS Producto,
        p.ListPrice AS Precio,
        ROW_NUMBER() OVER (PARTITION BY pc.Name ORDER BY p.ListPrice DESC) AS RankCaro,
        ROW_NUMBER() OVER (PARTITION BY pc.Name ORDER BY p.ListPrice ASC) AS RankBarato
    FROM SalesLT.ProductCategory pc
    JOIN SalesLT.Product p ON pc.ProductCategoryID = p.ProductCategoryID
)
SELECT
    Categoria,
    MAX(CASE WHEN RankCaro = 1 THEN Producto END) AS ProductoMasCaro,
    MAX(CASE WHEN RankCaro = 1 THEN Precio END) AS PrecioMasCaro,
    MAX(CASE WHEN RankBarato = 1 THEN Producto END) AS ProductoMasBarato,
    MAX(CASE WHEN RankBarato = 1 THEN Precio END) AS PrecioMasBarato
FROM ProductosPorCategoria
GROUP BY Categoria

-- 3. Total de Ventas en cada país en dinero (Ya hecha en el boletín 9.3).
CREATE VIEW TotalVentas AS (
	SELECT A.CountryRegion, SUM(S.TotalDue) AS 'Total' FROM SalesLT.Address AS A
	INNER JOIN SalesLT.CustomerAddress AS CA ON A.AddressID = CA.AddressID
	INNER JOIN SalesLT.SalesOrderHeader AS S ON CA.CustomerID = S.CustomerID
	GROUP BY A.CountryRegion
	)

-- 4. Número de clientes que tenemos en cada país. Contaremos cada dirección como si fuera un cliente distinto.
CREATE VIEW NumeroClientes AS (
	SELECT A.CountryRegion, COUNT(A.AddressID) AS 'Nº' FROM SalesLT.Address AS A
	GROUP BY A.CountryRegion
)

-- 5. Repite la consulta anterior pero contando cada cliente una sola vez. Si el cliente tiene varias direcciones, sólo consideraremos aquella en la que nos haya comprado la última vez.
CREATE VIEW UltimaCompraClientePais AS
SELECT c.CustomerID, a.CountryRegion, MAX(soh.OrderDate) AS UltimaCompra FROM SalesLT.Customer c
JOIN SalesLT.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
JOIN SalesLT.CustomerAddress ca ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address a ON ca.AddressID = a.AddressID
GROUP BY c.CustomerID, a.CountryRegion

-- 6. Repite la consulta anterior pero en este caso si el cliente tiene varias direcciones, sólo consideraremos aquella en la que nos haya comprado más.
CREATE VIEW ClienteCompraPais AS
SELECT c.CustomerID, a.CountryRegion, COUNT(soh.SalesOrderID) AS NumeroCompras FROM SalesLT.Customer c
JOIN SalesLT.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
JOIN SalesLT.CustomerAddress ca ON c.CustomerID = ca.CustomerID
JOIN SalesLT.Address a ON ca.AddressID = a.AddressID
GROUP BY c.CustomerID, a.CountryRegion

CREATE VIEW CompraMaximaClientePais AS
SELECT CustomerID, CountryRegion, MAX(NumeroCompras) AS MaximoCompras FROM ClienteCompraPais
GROUP BY CustomerID

-- 7. Los tres países en los que más hemos vendido, incluyendo la cifra total de ventas y la fecha de la última venta.
CREATE VIEW TresPaises AS
	SELECT TOP 3 a.CountryRegion, SUM(soh.TotalDue) AS TotalVentas, MAX(soh.OrderDate) AS UltimaVenta FROM SalesLT.SalesOrderHeader soh
	JOIN SalesLT.CustomerAddress ca ON soh.CustomerID = ca.CustomerID
	JOIN SalesLT.Address a ON ca.AddressID = a.AddressID
	GROUP BY a.CountryRegion
	ORDER BY TotalVentas DESC

-- 8. Sobre la consulta tres de ventas por país, calcula el valor medio y repite la consulta tres pero incluyendo solamente los países cuyas ventas estén por encima de la media.
WITH VentasPorPais AS (
    SELECT a.CountryRegion, SUM(soh.TotalDue) AS TotalVentas FROM SalesLT.SalesOrderHeader soh
    JOIN SalesLT.CustomerAddress ca ON soh.CustomerID = ca.CustomerID
    JOIN SalesLT.Address a ON ca.AddressID = a.AddressID
    GROUP BY a.CountryRegion
)
SELECT CountryRegion, TotalVentas FROM VentasPorPais
WHERE TotalVentas > (SELECT AVG(TotalVentas) FROM VentasPorPais)

-- 9. Nombre de la categoría y número de clientes diferentes que han comprado productos de cada una.
SELECT pc.Name AS Categoria, COUNT(DISTINCT soh.CustomerID) AS NumeroClientes FROM SalesLT.ProductCategory pc
JOIN SalesLT.Product p ON pc.ProductCategoryID = p.ProductCategoryID
JOIN SalesLT.SalesOrderDetail sod ON p.ProductID = sod.ProductID
JOIN SalesLT.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY pc.Name

-- 10. Clientes que nunca han comprado ninguna bicicleta (discriminarlas por categorías)
SELECT c.CustomerID, 'Bikes' AS Categoria FROM SalesLT.Customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM SalesLT.SalesOrderHeader soh
    JOIN SalesLT.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
    JOIN SalesLT.Product p ON sod.ProductID = p.ProductID
    JOIN SalesLT.ProductCategory pc ON p.ProductCategoryID = pc.ProductCategoryID
    WHERE pc.Name = 'Bikes' AND soh.CustomerID = c.CustomerID
)

-- 11. A la consulta anterior, añádele el total de compras (en dinero) efectuadas por cada cliente.
SELECT c.CustomerID, 'Bikes' AS Categoria, ISNULL(SUM(soh.TotalDue), 0) AS TotalCompras FROM SalesLT.Customer c
LEFT JOIN SalesLT.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
WHERE c.CustomerID NOT IN (
    SELECT soh.CustomerID
    FROM SalesLT.SalesOrderHeader soh
    JOIN SalesLT.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
    JOIN SalesLT.Product p ON sod.ProductID = p.ProductID
    JOIN SalesLT.ProductCategory pc ON p.ProductCategoryID = pc.ProductCategoryID
    WHERE pc.Name = 'Bikes'
)
GROUP BY c.CustomerID