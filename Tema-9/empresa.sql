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

-- 64. Listar los pedidos superiores a 2.500 euros, incluyendo el nombre del empleado responsable del pedido y el nombre del cliente que lo solicitó. Ordenar la consulta por el nombre del cliente.
SELECT P.*, E.nombre, C.nombre
FROM Pedidos AS P
INNER JOIN Empleados AS E ON P.resp = E.numemp
INNER JOIN Clientes AS C ON C.numclie = P.clie
WHERE P.importe > 2500
ORDER BY C.nombre

-- 65. Listar ordenados por el nombre los empleados que han realizado algún pedido.
SELECT E.nombre
FROM Empleados AS E
INNER JOIN Pedidos AS P ON E.numemp = P.resp
GROUP BY E.nombre
HAVING COUNT(P.resp) > 0
ORDER BY E.nombre

-- 66. Hallar los empleados que realizaron su primer pedido el mismo día que fueron contratados.
SELECT E.nombre
FROM Empleados AS E
INNER JOIN Pedidos AS P ON E.numemp = P.resp
WHERE E.contrato = (SELECT MIN(P1.fechapedido) FROM Pedidos AS P1 WHERE P1.resp = E.numemp)

-- 67. Listar los empleados con una cuota superior a la de su jefe; para cada empleado sacar sus datos y el número, nombre y cuota de su jefe.
SELECT E.numemp, E.nombre, E.cuota, J.numemp AS 'num_jefe', J.nombre AS 'nombre_jefe', J.cuota AS 'cuota_jefe'
FROM Empleados AS E
INNER JOIN Empleados AS J ON E.jefe = J.numemp
WHERE E.cuota > J.cuota

-- 68. Listar los números de los empleados que son responsables de un pedido superior a 1.000 euros o que tengan una cuota inferior a 5.000 euros.
SELECT DISTINCT E.numemp
FROM Empleados AS E
LEFT JOIN Pedidos AS P ON E.numemp = P.resp
WHERE P.importe > 1000 OR E.cuota < 5000

-- 69. Mostrar las oficinas que no tienen director o que se encuentran en la región sur.
SELECT O.oficina, O.ciudad, O.region
FROM Oficinas AS O
LEFT JOIN Empleados AS E ON O.dir = E.numemp
WHERE O.dir IS NULL OR O.region = 'Sur'

-- 70. Listar las oficinas que no tienen director o en las que trabaja alguien.
SELECT O.oficina, O.ciudad
FROM Oficinas AS O
LEFT JOIN Empleados AS E ON O.oficina = E.oficina
WHERE O.dir IS NULL OR E.numemp IS NOT NULL

-- 72. Edad media de los empleados.
SELECT AVG(edad) AS 'edad_media'
FROM Empleados AS E

-- 73. Edad del empleado más joven y del mayor.
SELECT MIN(edad) AS 'edad_minima', MAX(edad) AS 'edad_maxima'
FROM Empleados AS E

-- 74. Hallar el importe medio de pedidos, el importe total de pedidos y el precio medio de venta (el precio de venta es el precio unitario en cada pedido).
SELECT AVG(P.importe) AS 'importe_medio', SUM(P.importe) AS 'importe_total', AVG(Pr.precio) AS 'precio_medio_venta'
FROM Pedidos AS P
INNER JOIN Productos AS Pr ON P.producto = Pr.idproducto

-- 75. Hallar el precio medio de los productos del fabricante ‘ACI’.
SELECT AVG(precio) AS 'precio_medio'
FROM Productos AS P
WHERE idfab = 'ACI'

-- 76. ¿Cuál es el importe total de los pedidos realizados por el empleado Vicente Vino?
SELECT SUM(P.importe) AS 'importe_total'
FROM Pedidos AS P
INNER JOIN Empleados AS E ON P.resp = E.numemp
WHERE E.nombre = 'Vicente Vino'

-- 77. Hallar en qué fecha se realizó el primer pedido.
SELECT MIN(fechapedido) AS 'fecha_primer_pedido' -- ¿No hay fechas?
FROM Pedidos AS P

-- 78. Hallar cuántos pedidos hay de más de 5.000 euros.
SELECT COUNT(*) AS 'pedidos_mas_5000'
FROM Pedidos AS P
WHERE P.importe > 5000

-- 79. Listar cuántos empleados están asignados a cada oficina, indicar el número de oficina.
SELECT E.oficina, COUNT(E.numemp) AS 'numero_empleados'
FROM Empleados AS E
GROUP BY E.oficina

-- 80. Mostrar el número de oficinas que existen en cada región.
SELECT O.region, COUNT(O.oficina) AS 'numero_oficinas'
FROM Oficinas AS O
GROUP BY O.region

-- 81. Saber cuántas oficinas tienen algún empleado con ventas superiores a su cuota, no queremos saber cuales sino cuántas hay.
-- NO FUNCIONA
SELECT COUNT(DISTINCT E.oficina) AS oficinas_con_ventas_mayores_cuota
FROM Empleados AS E
INNER JOIN Pedidos AS P ON E.numemp = P.resp
GROUP BY E.numemp
HAVING SUM(E.ventas) > E.cuota

-- 82. Para cada empleado, obtener su número, nombre, e importe vendido a cada cliente indicando el número de cliente.
SELECT E.numemp, E.nombre, P.clie, SUM(P.importe) AS importe_vendido
FROM Empleados AS E
INNER JOIN Pedidos AS P ON E.numemp = P.resp
GROUP BY E.numemp, E.nombre, P.clie

-- 83. Para cada empleado cuyos pedidos suman más de 3.000 euros, hallar su importe medio de pedidos. En el resultado indicar el número de empleado y su importe medio de pedidos.
SELECT E.numemp, AVG(P.importe) AS 'importe_medio_pedidos'
FROM Empleados AS E
INNER JOIN Pedidos AS P ON E.numemp = P.resp
GROUP BY E.numemp
HAVING SUM(P.importe) > 3000

-- 84. Listar de cada producto, su descripción, precio y cantidad total pedida, incluyendo sólo los productos cuya cantidad total pedida sea superior al 75% del stock; y ordenado por cantidad total pedida.
SELECT Pr.descripcion, Pr.precio, SUM(P.cant) AS 'cantidad_total_pedida'
FROM Productos AS Pr
INNER JOIN Pedidos AS P ON Pr.idproducto = P.producto
GROUP BY Pr.descripcion, Pr.precio, Pr.existencias
HAVING SUM(P.cant) > 0.75 * Pr.existencias
ORDER BY cantidad_total_pedida DESC

-- 85. Escribir una consulta SQL que indique el número de empleados que trabaja en cada oficina.
SELECT E.oficina, COUNT(E.numemp) AS 'numero_empleados'
FROM Empleados AS E
GROUP BY E.oficina

-- 86. Igual que el ejercicio anterior pero mostrando las oficinas donde trabajan 3 o más empleados.
SELECT E.oficina, COUNT(E.numemp) AS 'numero_empleados'
FROM Empleados AS E
GROUP BY E.oficina
HAVING COUNT(E.numemp) >= 3

-- 87. Listar los nombres de los clientes que tienen asignado como responsable a Alvaro Aluminio (suponiendo que no pueden haber empleados con el mismo nombre).
SELECT C.nombre
FROM Clientes AS C
INNER JOIN Empleados AS E ON C.resp = E.numemp
WHERE E.nombre = 'Alvaro Aluminio'

-- 88. Mostrar información de los productos cuyas existencias estén por debajo de la existencia media de los productos.
SELECT *
FROM Productos
WHERE existencias < (SELECT AVG(existencias) FROM Productos)

-- 89. Listar los empleados (numemp, nombre, y no de oficina) que trabajan en oficinas “buenas” (las que tienen ventas superiores a su objetivo).
SELECT E.numemp, E.nombre, E.oficina
FROM Empleados AS E
INNER JOIN Oficinas AS O ON E.oficina = O.oficina
WHERE (SELECT SUM(P.importe) FROM Pedidos AS P WHERE P.resp = E.numemp) > O.objetivo

-- 90. Listar los empleados que trabajan en una oficina de la región norte o de la región sur.
SELECT E.*
FROM Empleados AS E
INNER JOIN Oficinas AS O ON E.oficina = O.oficina
WHERE O.region IN ('Norte', 'Sur')

-- 91. Listar los empleados (numemp, nombre y oficina) que no trabajan en oficinas dirigidas por el empleado 108.
SELECT E.numemp, E.nombre, E.oficina
FROM Empleados AS E
INNER JOIN Oficinas AS O ON E.oficina = O.oficina
WHERE O.dir != 108

-- 92. Escribir una consulta que muestre los empleados cuyo nombre coincide con el de algún cliente. Hacer dos versiones: con subconsulta de tipo lista y de tipo tabla.
SELECT E.numemp, E.nombre
FROM Empleados AS E
WHERE E.nombre IN (SELECT C.nombre FROM Clientes AS C)

SELECT E.numemp, E.nombre
FROM Empleados AS E
INNER JOIN Clientes AS C ON E.nombre = C.nombre

-- 93. Escribir una consulta que muestre los empleados cuyo primer nombre coincide con el primer nombre de algún cliente.
-- ¿Cómo escoger ciertos caracteres?

-- 94. Mostrar los empleados que no son directores de ninguna oficina.
SELECT E.numemp, E.nombre
FROM Empleados AS E
WHERE E.numemp NOT IN (SELECT O.dir FROM Oficinas AS O WHERE O.dir IS NOT NULL)

-- 95. Listar los productos (idfab, idproducto y descripción) para los cuales no existe ningún pedido con importe igual o superior a 2.500 euros.
SELECT P.idfab, P.idproducto, P.descripcion
FROM Productos AS P
INNER JOIN Pedidos AS PE ON P.idproducto = PE.producto
GROUP BY P.idfab, P.idproducto, P.descripcion
HAVING MAX(PE.importe) < 2500

-- 96. Listar los clientes asignados a Ana Bustamante que no han hecho un pedido superior a 300 euros.
SELECT C.*
FROM Clientes AS C
INNER JOIN Empleados AS E ON C.resp = E.numemp
INNER JOIN Pedidos AS P ON P.clie = C.numclie
WHERE E.nombre = 'Ana Bustamante' AND P.importe < 300

-- 97. Listar las oficinas en donde al menos haya un empleado cuyas ventas representen más del 55% del objetivo de su oficina.
SELECT DISTINCT O.oficina
FROM Oficinas AS O
INNER JOIN Empleados AS E ON O.oficina = E.oficina
INNER JOIN Pedidos AS P ON E.numemp = P.resp
GROUP BY O.oficina, O.objetivo
HAVING SUM(P.importe) > 0.55 * O.objetivo

-- 98. Listar las oficinas donde todos los empleados tienen ventas que superan al 50% del objetivo de la oficina.
-- Preguntar a Antonio cómo se hace este

-- 99. Listar las oficinas que tengan un objetivo mayor que la suma de las cuotas de sus empleados.
SELECT O.oficina
FROM Oficinas AS O
LEFT JOIN Empleados AS E ON O.oficina = E.oficina
GROUP BY O.oficina, O.objetivo
HAVING O.objetivo > SUM(E.cuota)
