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
