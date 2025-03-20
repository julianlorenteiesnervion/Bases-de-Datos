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
SELECT PC.Name, MAX() FROM SalesLT.ProductCategory AS PC
INNER JOIN SalesLT.Product AS P ON PC.ProductCategoryID = P.ProductCategoryID

SELECT * FROM SalesLT.ProductCategory
SELECT * FROM SalesLT.Product

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


