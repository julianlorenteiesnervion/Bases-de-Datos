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
SELECT ProductID, (ListPrice - StandardCost) AS 'Beneficio', ((ListPrice - StandardCost) * 100) / StandardCost AS 'Porcentaje'
FROM SalesLT.Product

-- Número de productos de cada categoría
SELECT ProductCategoryID AS 'Categoría', COUNT(ProductID) AS 'Nº Productos'
FROM SalesLT.Product
GROUP BY ProductCategoryID

-- Cantidad de subcategorías que hay dentro de cada categoría padre
SELECT ParentProductCategoryID AS 'C. Padre', COUNT(ProductCategoryID) AS 'Subcategoría'
FROM SalesLT.ProductCategory
GROUP BY ParentProductCategoryID

-- Número de unidades vendidas de cada producto cada año
SELECT ProductID AS 'Producto', YEAR(ModifiedDate) AS 'Año', SUM(OrderQty) AS 'Unds. Vendidas'
FROM SalesLT.SalesOrderDetail
GROUP BY ProductID, YEAR(ModifiedDate)
