USE AdventureWorksLT2019
GO

-- 1. Nombre y direcci�n completas de todos los clientes que tengan alguna sede en Canada.
CREATE VIEW FullAddressCanadaCustomer AS (
	SELECT C.FirstName, CONCAT(A.AddressLine1, ISNULL(A.AddressLine2, ''), ' ', A.City, ' ', A.StateProvince, ' ', A.CountryRegion) AS 'Full Address' FROM SalesLT.Customer AS C
	INNER JOIN SalesLT.CustomerAddress AS CA ON C.CustomerID = CA.CustomerID
	INNER JOIN SalesLT.Address AS A ON CA.AddressID = A.AddressID
	WHERE A.CountryRegion = 'Canada'
)

-- 2. Nombre de cada categor�a y producto m�s caro y m�s barato de la misma, incluyendo los precios.
SELECT PC.Name, MAX() FROM SalesLT.ProductCategory AS PC
INNER JOIN SalesLT.Product AS P ON PC.ProductCategoryID = P.ProductCategoryID

SELECT * FROM SalesLT.ProductCategory
SELECT * FROM SalesLT.Product