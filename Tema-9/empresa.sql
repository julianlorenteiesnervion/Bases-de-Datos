USE Empresa
GO

-- 53. Mostrar la información de los empleados junto a la información de las oficinas en las que trabajan.
SELECT *
FROM Empleados AS E
INNER JOIN Oficinas AS O ON E.oficina = O.oficina

-- 54. Igual que el ejercicio anterior, pero mostrando solo los empleados que trabajan en las oficinas del sur.
SELECT *
FROM Empleados AS E
INNER JOIN Oficinas AS O ON E.oficina = O.oficina
WHERE O.region = 'sur'

-- 55. Igual que el ejercicio anterior, ordenando los empleados por edad.
SELECT *
FROM Empleados AS E
INNER JOIN Oficinas AS O ON E.oficina = O.oficina
WHERE O.region = 'sur'
ORDER BY E.edad

-- 56. Escribir una consulta que muestre la información de todos los empleados junto a los datos de su oficina.
SELECT *
FROM Empleados AS E
INNER JOIN Oficinas AS O ON E.oficina = O.oficina

-- 57. Escribir una consulta que muestre la información de todos los empleados (trabajen o no en una oficina) junto a la información de su oficina.
SELECT *
FROM Empleados AS E
LEFT JOIN Oficinas AS O ON E.oficina = O.oficina

-- 58. Listar las oficinas del este indicando para cada una de ellas su número, ciudad, números y nombres de sus empleados. Hacer una versión en la que aparecen sólo las que tienen empleados, y hacer otra en las que además aparezcan las oficinas del este que no tienen empleados.
SELECT O.oficina, O.ciudad, E.numemp, E.nombre
FROM Oficinas AS O
INNER JOIN Empleados AS E ON O.oficina = E.oficina
ORDER BY O.oficina ASC

SELECT O.oficina, O.ciudad, E.numemp, E.nombre
FROM Oficinas AS O
LEFT JOIN Empleados AS E ON O.oficina = E.oficina
ORDER BY O.oficina ASC

-- 59. Listar los pedidos mostrando su número de pedido e importe, junto a la información del cliente (nombre y límite de crédito) que realiza el pedido.
SELECT P.numpedido, P.importe, C.nombre, C.limitecredito
FROM Pedidos AS P
INNER JOIN Clientes AS C ON P.clie = C.numclie

-- 60. Igual que el ejercicio anterior mostrando además la información del empleado que fue responsable de este pedido.
SELECT P.numpedido, P.importe, C.nombre, C.limitecredito, E.*
FROM Pedidos AS P
INNER JOIN Clientes AS C ON P.clie = C.numclie
INNER JOIN Empleados AS E ON P.resp = E.numemp

-- 61. Mostrar para cada producto la información de sus pedidos
SELECT PR.idproducto, PE.*
FROM Productos AS PR
INNER JOIN Pedidos AS PE ON PR.idproducto = PE.producto

-- 62. Listar los datos de cada uno de los empleados, la ciudad y región en donde trabaja.
SELECT E.*, O.ciudad, O.region
FROM Empleados AS E
INNER JOIN Oficinas AS O ON O.oficina = E.oficina

-- 63. Listar todas las oficinas con objetivo superior a 60.000 euros indicando para cada una de ellas el nombre de su director.
SELECT O.oficina, E.nombre
FROM OFICINAS AS O
INNER JOIN Empleados AS E ON O.dir = E.numemp
WHERE O.objetivo >= 60000
