USE Empresa
GO

-- 1. Añadir una nueva oficina para la ciudad de Madrid, con el número de oficina 30, con un objetivo de 10.000 euros y región ‘Centro’. Suponer que conocemos el orden de los campos en la tabla.
INSERT INTO Oficinas VALUES (30, 'Madrid', 'Centro', NULL, 10000, NULL)

-- 2. Igual que el ejercicio anterior suponiendo que no sabemos cual es el orden de los campos en la tabla Oficina.
INSERT INTO Oficinas (oficina, ciudad, region, objetivo) VALUES (30, 'Madrid', 'Centro', 10000)

-- 3. Insertar tus datos como nuevo empleado. Utilizar como numemp los tres últimos dígitos del dni, la oficina 23, el puesto “Programador”, sin jefe, con una cuota de 1000 y las ventas a 0. En el contrato la fecha de hoy.
INSERT INTO Empleados VALUES (932, 'Julián Lorente', 18, 23, 'Programador', GETDATE(), NULL, 1000, 0)

-- 4. Insertar un nuevo cliente con tu nombre y utilizar como numclie 999. Dejar el resto de campos a su valor por defecto.
INSERT INTO Clientes (numclie, nombre) VALUES (999, 'Julián Lorente')

-- 5. Insertar los empleados que no tienen jefes como clientes. Como número de clientes utilizaremos el mismo número de empleado, ellos mismo serán sus propios responsable y el límite de crédito será 0.
INSERT INTO Clientes SELECT numemp, nombre, numemp, 0 FROM Empleados
WHERE jefe IS NULL

-- 7. Subir un 5% el precio de todos los productos del fabricante ‘ACI’.
UPDATE Productos
SET precio = precio * 1.05
WHERE idfab = 'aci'

-- 8. Incrementar en uno la edad de los empleados.
UPDATE Empleados
SET edad = edad + 1

-- 9. Cambiar los empleados de la oficina 21 a la oficina 30.
UPDATE Empleados
SET oficina = 30
WHERE oficina = 21

-- 10. De los empleados que trabajan en Cádiz, disminuir su cuota en un 10%.
UPDATE Empleados
SET cuota = cuota * 0.90
FROM Empleados AS E
INNER JOIN Oficinas AS O ON O.oficina = E.oficina
WHERE O.ciudad = 'Cádiz'

-- 11. Bajar 100 euros el precio de los productos de los que no se han realizado ningún pedido. Hay que tener cuidado que no queden precios negativos.
UPDATE Productos
SET precio = precio - 100
FROM Productos AS P
LEFT JOIN Pedidos AS PE ON P.idproducto = PE.producto
WHERE PE.producto IS NULL AND P.precio >= 100

-- 12. Modificar el nombre de los empleados para eliminar el segundo nombre o apellido (apellidos) de su nombre.
SELECT * FROM Empleados
UPDATE Empleados
SET nombre = LEFT(nombre, CHARINDEX(' ', nombre) - 1)
WHERE CHARINDEX(' ', nombre) > 0

-- 13. Cambiar la cuota de todos los empleados a 1000 euros.
UPDATE Empleados
SET cuota = 1000

-- 14. Eliminar los pedidos cuyo responsable es el empleado 105.
DELETE FROM Pedidos
WHERE resp = 105

-- 15. Eliminar los tres clientes con menor límite de crédito.
DELETE FROM Clientes
WHERE numclie IN (
	SELECT TOP 3 numclie
	FROM Clientes
	ORDER BY limitecredito ASC
	)

-- 16. En un ejercicio anterior hemos insertado un nuevo empleado con nuestros datos. Eliminar dicho registro.
DELETE FROM Empleados
WHERE numemp = 932

-- 17. Eliminar las oficinas que no tengan empleados.
DELETE O FROM Oficinas AS O
LEFT JOIN Empleados AS E ON O.oficina = E.oficina
WHERE E.oficina IS NULL

-- 18. Elimiar cualquier rastro del cliente 2103 (datos y pedidos).
DELETE FROM Clientes
WHERE numclie = 2103

DELETE FROM Pedidos
WHERE clie = 2103

-- 19. Eliminar los empleado que han realizado al menos un pedido del fabricante ‘ACI’.
DELETE E FROM Empleados AS E
INNER JOIN Pedidos AS P ON E.numemp = P.resp
WHERE P.fab = 'ACI'
