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

-- 1. Nombre completo (Title, nombre, inicial del segundo nombre, apellidos) de todos los clientes que en los nombres de sus compañías aparezcan las palabras "cycle” o "bike”
SELECT Title, FirstName, MiddleName, LastName
FROM SalesLT.Customer
WHERE CompanyName LIKE ('%cycle%') OR CompanyName LIKE ('%bike%')

-- 2. Repite la consulta anterior sin incluir la inicial del nombre. ¿Obtienes la misma información? ¿A qué es debido?
-- Respuesta: Sí que obtengo la misma información, ya que no tenemos ninguna condición en la consulta que dependa de la inicial del nombre
SELECT Title, FirstName, LastName
FROM SalesLT.Customer
WHERE CompanyName LIKE ('%cycle%') OR CompanyName LIKE ('%bike%')

-- 4. Número de productos de cada color
SELECT Color, COUNT(ProductID) AS 'Nº Productos'
FROM SalesLT.Product
GROUP BY Color

-- 5. El margen de un producto es la diferencia entre su precio de venta (ListPrice) y su precio de coste (StandardPrice). Crea una consulta que obtenga nombre y número del producto, margen y categoría
SELECT Name, ProductID, ListPrice - StandardCost AS 'Margin', ProductCategoryID
FROM SalesLT.Product

-- 6. ID de categoría y margen medio de los productos de esa categoría. Ten en cuenta que el margen medio es la media de los márgenes
SELECT ProductCategoryID, SUM(ListPrice - StandardCost) / COUNT(ListPrice) AS 'Margen medio'
FROM SalesLT.Product
GROUP BY ProductCategoryID

-- 7. Consulta cuantas direcciones diferentes tenemos de cada país
SELECT CountryRegion, COUNT(AddressID) AS 'Direcciones'
FROM SalesLT.Address
GROUP BY CountryRegion

-- 8. Consulta cuantas direcciones diferentes tenemos de cada país y estado
SELECT CountryRegion, StateProvince, COUNT(AddressID) AS 'Direcciones'
FROM SalesLT.Address
GROUP BY CountryRegion, StateProvince

-- 9. Consulta cuantas direcciones diferentes tenemos de cada país, estado y ciudad
SELECT CountryRegion, StateProvince, City, COUNT(AddressID) AS 'Direcciones'
FROM SalesLT.Address
GROUP BY CountryRegion, StateProvince, City