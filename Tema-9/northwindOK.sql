Use Northwind
GO

-- Nombre del país y número de clientes de cada país, ordenados alfabéticamente por el nombre del país
SELECT Country, COUNT(Country) AS Clientes FROM Customers
GROUP BY Country
ORDER BY Country ASC

-- ID de producto y número de unidades vendidas de cada producto (El número de unidades las obtenemos del campo Quantity de Order Detail
SELECT ProductID, SUM(Quantity) FROM [Order Details]
GROUP BY ProductID

-- ID del cliente y número de pedidos que nos ha hecho
SELECT CustomerID, COUNT(CustomerID) AS Pedidos FROM Orders
GROUP BY CustomerID

-- ID del cliente, año y número de pedidos que nos ha hecho cada año
SELECT CustomerID, YEAR(OrderDate) AS 'Año', COUNT(CustomerID) AS 'Pedidos' FROM Orders
GROUP BY CustomerID, YEAR(OrderDate)

-- ID del producto, precio unitario y total facturado de ese producto, ordenado por cantidad facturada de mayor a menor. Si hay varios precios unitarios para el mismo producto tomaremos el mayor
SELECT ProductID, MAX(UnitPrice), SUM((Quantity * UnitPrice) - ((Quantity * UnitPrice) * Discount)) AS 'Facturado' FROM [Order Details]
GROUP BY ProductID
ORDER BY Facturado DESC

-- ID del proveedor e importe total del stock acumulado de productos correspondientes a ese proveedor
SELECT SupplierID, SUM(UnitsInStock * UnitPrice) AS 'Stock Acumulado' FROM Products
GROUP BY SupplierID

-- Número de pedidos registrados mes a mes de cada año
SELECT COUNT(*) AS 'Pedidos', MONTH(OrderDate) AS 'Mes', YEAR(OrderDate) AS 'Año' FROM Orders
GROUP BY MONTH(OrderDate), YEAR(OrderDate)

-- Año y tiempo medio transcurrido entre la fecha de cada pedido (OrderDate) y la fecha en la que lo hemos enviado (ShipDate), en días para cada año
SELECT YEAR(OrderDate) AS 'Año', AVG(DAY(ShippedDate - OrderDate)) AS 'Tiempo medio' FROM Orders
GROUP BY (YEAR(OrderDate))
ORDER BY YEAR(OrderDate) ASC

-- ID del distribuidor y número de pedidos enviados a través de ese distribuidor
SELECT ShipVia AS 'SupplierID', COUNT(ShipVia) AS 'Pedidos enviados' FROM Orders
GROUP BY ShipVia

-- ID de cada proveedor y número de productos distintos que nos suministra
SELECT SupplierID, COUNT(SupplierID) AS 'Productos distintos' FROM Products
GROUP BY SupplierID

-- Boletín 8.1+
-- 2. ID de producto y número de unidades vendidas de cada producto.  Añade el nombre del producto
SELECT P.ProductID, P.ProductName, SUM(O.Quantity) AS 'Uds. Vendidas'
FROM Products AS P
INNER JOIN [Order Details] AS O ON P.ProductID = O.ProductID
GROUP BY P.ProductID, P.ProductName

-- 3. ID del cliente y número de pedidos que nos ha hecho. Añade nombre (CompanyName) y ciudad del cliente
SELECT C.CustomerID, C.CompanyName, C.City, COUNT(O.CustomerID) AS 'Nº Pedidos'
FROM Customers AS C
INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CompanyName, C.City

-- 4. ID del cliente, año y número de pedidos que nos ha hecho cada año. Añade nombre (CompanyName) y ciudad del cliente, así como la fecha del primer pedido que nos hizo
SELECT C.CustomerID, C.CompanyName, C.City, YEAR(O.OrderDate) AS 'Año', COUNT(O.CustomerID) AS 'Nº Pedidos', MIN(OrderDate) AS 'Primer pedido'
FROM Customers AS C
INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.CompanyName, C.City, YEAR(O.OrderDate)

-- 5. ID del producto, precio unitario y total facturado de ese producto, ordenado por cantidad facturada de mayor a menor. Si hay varios precios unitarios para el mismo producto tomaremos el mayor. Añade el nombre del producto
SELECT O.ProductID, P.ProductName, MAX(O.UnitPrice) AS 'Precio unitario', SUM(O.UnitPrice * O.Quantity) AS 'Total facturado'
FROM [Order Details] AS O
INNER JOIN Products AS P ON O.ProductID = P.ProductID
GROUP BY O.ProductID, P.ProductName -- ¿Por qué hay que poner el product name aquí?
ORDER BY SUM(O.UnitPrice * O.Quantity) DESC

-- 6. ID del proveedor e importe total del stock acumulado de productos correspondientes a ese proveedor. Añade el nombre del proveedor
SELECT S.SupplierID, S.ContactName, (UnitPrice * UnitsInStock) AS 'Importe total stock'
FROM Suppliers AS S
INNER JOIN Products AS P ON S.SupplierID = P.SupplierID

-- 9. ID del distribuidor y número de pedidos enviados a través de ese distribuidor. Añade el nombre del distribuidor
SELECT S.ShipperID, S.CompanyName, COUNT(O.OrderID) AS 'Pedidos enviados'
FROM Shippers AS S
INNER JOIN Orders AS O ON S.ShipperID = O.ShipVia
GROUP BY S.ShipperID, S.CompanyName

-- 10. ID de cada proveedor y número de productos distintos que nos suministra. Añade el nombre del proveedor
SELECT S.SupplierID, S.ContactName, COUNT(P.ProductID) AS 'Products'
FROM Suppliers AS S
INNER JOIN Products AS P ON S.SupplierID = P.SupplierID
GROUP BY S.SupplierID, S.ContactName
