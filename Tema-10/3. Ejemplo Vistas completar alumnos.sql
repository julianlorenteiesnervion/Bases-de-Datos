USE NorthWind

--AOB: VISTAS. Vamos a ver como podemos sustituir unas consultas por una vista
-- para que quede mas simplificado.

-- Unidades vendidas de cada producto en 1996
SELECT OD.ProductID, P.ProductName, SUM(OD.Quantity) AS VentasAnuales FROM Products AS P
	INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
	INNER JOIN Orders AS O ON OD.OrderID = O.OrderID
	Where Year (O.OrderDate) = 1996 
	Group By OD.ProductID, P.ProductName


-- Las del 97. Incluimos los productos con ventas cero
SELECT P.ProductID, P.ProductName, SUM(ISNULL(OD.Quantity,0)) AS VentasAnuales 
FROM Products AS P
	LEFT JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
	LEFT JOIN Orders AS O ON OD.OrderID = O.OrderID
	Where Year (O.OrderDate) = 1997 OR O.OrderDate IS NULL
	Group By P.ProductID, P.ProductName

-- REALIZAR CON UNA CONSULTA
-- Queremos saber:
--Obtener nombre del producto, Ventas del producto en el 96, 
--ventas en el 97, INCREMENTO DE VENTAS DEL AÑO 96 AL 97,
-- y Diferencia porcentual entre los dos valores.
-- Para obtener la diferencia porcentual usar:
--CAST (((V97.VentasAnuales - ISNULL(V96.VentasAnuales, 0))*100)/V96.VentasAnuales AS Decimal(5,1)) AS Porcentaje
SELECT P.ProductName, (SELECT OD.PRODUCTID, COUNT(OD.ProductID) FROM Orders AS O
INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
WHERE YEAR(O.OrderDate) = 1996
GROUP BY OD.ProductID) AS 'Ventas del 96'
FROM Products AS P
INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
INNER JOIN Orders AS O ON OD.OrderID = O.OrderID
--GROUP BY P.ProductName

SELECT * FROM [Order Details]
SELECT * FROM Orders
SELECT * FROM Products

-- Ahora crea las vistas necesarias y reescribe la consulta anterior
-- con las vistas