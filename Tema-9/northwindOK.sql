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

-- Boletín 9.1
-- 1. Nombre de los proveedores y número de productos que nos vende cada uno
SELECT S.ContactName, COUNT(P.SupplierID) AS 'Nº Productos'
FROM Suppliers AS S
INNER JOIN Products AS P ON S.SupplierID = P.SupplierID
GROUP BY S.ContactName

-- 2. Nombre completo y telefono de los vendedores que trabajen en New York, Seattle, Vermont, Columbia, Los Angeles, Redmond o Atlanta.
SELECT ContactName
FROM Suppliers
WHERE City IN ('New York', 'Seattle', 'Vermont', 'Columbia', 'Los Angeles', 'Redmond', 'Atlanta')

-- 3. Número de productos de cada categoría y nombre de la categoría.
SELECT COUNT(P.ProductID) AS 'Nº Productos', C.CategoryName
FROM Products AS P
INNER JOIN Categories AS C ON P.CategoryID = C.CategoryID
GROUP BY C.CategoryName

-- 4. Nombre de la compañía de todos los clientes que hayan comprado queso de cabrales o tofu
SELECT C.CompanyName
FROM Customers AS C
INNER JOIN Orders AS O ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
INNER JOIN Products AS P ON P.ProductID = OD.ProductID
WHERE P.ProductName IN ('Queso Cabrales', 'Tofu')

-- 5. Empleados (ID, nombre, apellidos y teléfono) que han vendido algo a Bon app' o Meter Franken (nombre de la compañía)
SELECT E.EmployeeID, E.FirstName, E.LastName, E.HomePhone
FROM Employees AS E
INNER JOIN Orders AS O ON  O.EmployeeID = E.EmployeeID
INNER JOIN Customers AS C ON O.CustomerID = C.CustomerID
WHERE C.CompanyName IN ('Bon app''', 'Meter Franken')
GROUP BY E.EmployeeID, E.FirstName, E.LastName, E.HomePhone

-- 6. Empleados (ID, nombre, apellidos, mes y día de su cumpleaños) que no han vendido nunca nada a ningún cliente de Portugal.
SELECT E.EmployeeID, E.FirstName, E.LastName, MONTH(E.BirthDate) AS 'Mes', DAY(E.BirthDate) AS 'Día'
FROM Employees AS E
INNER JOIN Orders AS O ON E.EmployeeID = O.EmployeeID
INNER JOIN Customers AS C ON O.CustomerID = C.CustomerID
WHERE C.Country != 'Portugal'
GROUP BY E.EmployeeID, E.FirstName, E.LastName, MONTH(E.BirthDate), DAY(E.BirthDate)

-- 7. Total de ventas en US$ de productos de cada categoría (nombre de la categoría)
SELECT C.CategoryName, SUM(O.UnitPrice * O.Quantity) AS 'Total'
FROM Categories AS C
INNER JOIN Products AS P ON C.CategoryID = P.CategoryID
INNER JOIN [Order Details] AS O ON P.ProductID = O.ProductID
GROUP BY C.CategoryName

-- 8. Total de ventas en US$ de cada empleado cada año (nombre, apellidos, dirección).
SELECT CONCAT(E.FirstName + ' ', E.LastName + ' ', E.[Address]) AS 'Empleado', YEAR(O.OrderDate) AS 'Año', SUM(OD.UnitPrice * OD.Quantity) AS 'Total ventas'
FROM Employees AS E
INNER JOIN Orders AS O ON E.EmployeeID = O.EmployeeID
INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
GROUP BY E.FirstName, E.LastName, E.[Address], YEAR(O.OrderDate)
ORDER BY E.FirstName, YEAR(O.OrderDate)

-- 9. Ventas de cada producto en el año 97. Nombre del producto y unidades
SELECT P.ProductName, SUM(OD.Quantity) AS 'Uds'
FROM Products AS P
INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
INNER JOIN Orders AS O ON OD.OrderID = O.OrderID
WHERE YEAR(O.OrderDate) = 1997
GROUP BY P.ProductName

-- 11. Empleados (nombre y apellidos) que trabajan a las órdenes de Andrew Fuller.
SELECT FirstName, LastName
FROM Employees
WHERE ReportsTo = (SELECT EmployeeID FROM Employees WHERE FirstName = 'Andrew' AND LastName = 'Fuller')

-- 12. Número de subordinados que tiene cada empleado, incluyendo los que no tienen ninguno. Nombre, apellidos, ID.
-- Dónde está el número de subordinados?!?!