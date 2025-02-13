USE AdventureWorksLT2019
GO

-- Nombre del producto, código y precio, ordenado de mayor a menor precio
SELECT [Name], ProductID, ListPrice
FROM SalesLT.Product
ORDER BY ListPrice DESC

-- Número de direcciones de cada Estado/Provincia
SELECT StateProvince AS 'Estado/Provincia', COUNT(AddressID) AS 'Nº Direcciones'
FROM SalesLT.Address
GROUP BY StateProvince

-- Nombre del producto, código, número, tamaño y peso de los productos que estaban a la venta durante todo el mes de septiembre de 2002. No queremos que aparezcan aquellos cuyo peso sea superior a 2000
SELECT [Name], ProductID, ProductNumber, Size, [Weight]
FROM SalesLT.Product
WHERE SellStartDate <= '20020901' AND (SellEndDate IS NULL OR SellEndDate >= '20020930') AND [Weight] < 2000

-- Margen de beneficio de cada producto (Precio de venta menos el coste), y porcentaje que supone respecto del precio de venta
select * from