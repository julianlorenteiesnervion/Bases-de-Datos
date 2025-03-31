USE Hospital
GO

-- 1) Sacar todos los empleados que se dieron de alta entre una determinada fecha inicial y fecha final y que pertenecen a un determinado departamento.
CREATE OR ALTER PROCEDURE EmpleadosInicioFinalDepartamento @fechaInicial DATE, @fechaFinal DATE, @departamento VARCHAR(30)
AS
	BEGIN
		SELECT * FROM Emp E
		INNER JOIN Dept D ON E.Dept_No = D.Dept_No
		WHERE (E.Fecha_Alt BETWEEN @fechaInicial AND @fechaFinal)
		AND D.DNombre = @departamento
	END

EXECUTE EmpleadosInicioFinalDepartamento '1983-10-10', '1983-12-22', 'INVESTIGACIÓN'

-- 2) Crear procedimiento que inserte un empleado.
CREATE OR ALTER PROCEDURE InsertarEmpleado @Emp_No INT, @Apellido VARCHAR(50), @Oficio VARCHAR(50), @Dir INT, @Fecha_Alt DATE, @Salario NUMERIC(9,2), @Comision NUMERIC(9,2), @Dept_No INT
AS
	BEGIN
		INSERT INTO Emp VALUES (@Emp_No, @Apellido, @Oficio, @Dir, @Fecha_Alt, @Salario, @Comision, @Dept_No)
	END

EXECUTE InsertarEmpleado 9138, 'LORENTE', 'DIRECTOR', 7782, '1981-11-14', 500000, 100000, 10

-- 3) Crear un procedimiento que recupere el nombre, número de departamento y número de personas a partir del número de departamento.
CREATE OR ALTER PROCEDURE NombreDeptNumero @numDept INT
AS
	BEGIN
		SELECT D.DNombre, D.Dept_No, COUNT(E.Emp_No) AS 'Nº Personas' FROM Dept D
		INNER JOIN Emp E ON D.Dept_No = E.Dept_No
		WHERE D.Dept_No = @numDept
		GROUP BY D.DNombre, D.Dept_No
	END

EXECUTE NombreDeptNumero 10

-- 4) Crear un procedimiento igual que el anterior, pero que recupere también las personas que trabajan en dicho departamento, pasándole como parámetro el nombre.
CREATE OR ALTER PROCEDURE PersonasTrabajan @nombreDept VARCHAR(50)
AS
	BEGIN
		SELECT E.Apellido, D.Dept_No, D.DNombre FROM Emp E
		INNER JOIN Dept D ON E.Dept_No = D.Dept_No
		WHERE D.DNombre = @nombreDept
	END

EXECUTE PersonasTrabajan 'CONTABILIDAD'

-- 5) Crear procedimiento para devolver salario, oficio y comisión, pasándole el apellido.
CREATE OR ALTER PROCEDURE ApellidoSalarioOficioComision @apellido VARCHAR(50)
AS
	BEGIN
		SELECT Salario, Oficio, Comision FROM Emp
		WHERE Apellido = @apellido
	END

EXECUTE ApellidoSalarioOficioComision 'LORENTE'

-- 6) Igual que el anterior, pero si no le pasamos ningún valor, mostrará los datos de todos los empleados.
CREATE OR ALTER PROCEDURE ApellidoSalarioOficioComisionNingunValor @apellido VARCHAR(50)
AS
	BEGIN
	IF (@apellido IS NOT NULL AND @apellido != '')
		BEGIN
			EXECUTE ApellidoSalarioOficioComision @apellido
		END
	ELSE
		BEGIN
			SELECT Salario, Oficio, Comision FROM Emp
		END
	END

EXECUTE ApellidoSalarioOficioComisionNingunValor ' '

-- 7) Crear un procedimiento para mostrar el salario, oficio, apellido y nombre del departamento de todos los empleados que contengan en su apellido el valor que le pasemos como parámetro.
CREATE OR ALTER PROCEDURE SalarioOficioApellidoNombreSegunApellido @valor VARCHAR(50)
AS
	BEGIN
		SELECT E.Salario, E.Oficio, E.Apellido, D.DNombre FROM Emp E
		INNER JOIN Dept D ON E.Dept_No = D.Dept_No
		WHERE E.Apellido LIKE '%' + @valor + '%'
	END

EXECUTE SalarioOficioApellidoNombreSegunApellido 'IN'

-- 8) Crear un procedimiento que recupere el número departamento, el nombre y número de empleados, dándole como valor el nombre del departamento, si el nombre introducido no es válido, mostraremos un mensaje informativo comunicándolo.
CREATE OR ALTER PROCEDURE NumDepartamentoNombreNumEmpleadoSegunNombre @nombreDept VARCHAR(50)
AS
	BEGIN
	IF (@nombreDept IN (SELECT DNombre FROM Dept))
		BEGIN
			SELECT D.Dept_No, D.DNombre, COUNT(E.Dept_No) FROM Dept D
			INNER JOIN Emp E ON D.Dept_No = E.Dept_No
			WHERE D.DNombre = @nombreDept
			GROUP BY D.Dept_No, D.DNombre
		END
	ELSE
		BEGIN
			PRINT('Nombre de departamento no válido.')
		END
	END

EXECUTE NumDepartamentoNombreNumEmpleadoSegunNombre 'Contabilidad' -- Éxito
EXECUTE NumDepartamentoNombreNumEmpleadoSegunNombre 'Conta' -- Error

-- 11) Crear procedimiento que borre un empleado que coincida con los parámetros indicados (los parámetros serán todos los campos de la tabla empleado).
CREATE OR ALTER PROCEDURE BorrarEmpleadoSegunParametros @Emp_No INT, @Apellido VARCHAR(50), @Oficio VARCHAR(50), @Dir INT, @Fecha_Alt DATE, @Salario NUMERIC(9,2), @Comision NUMERIC(9,2), @Dept_No INT
AS
	BEGIN
		DELETE FROM Emp
		WHERE (Emp_No = @Emp_No AND
		Apellido = @Apellido AND
		Oficio = @Oficio AND
		Dir = @Dir AND
		Fecha_Alt = @Fecha_Alt AND
		Salario = @Salario AND
		Comision = @Comision AND
		Dept_No = @Dept_No)
	END

EXECUTE BorrarEmpleadoSegunParametros 9138, 'LORENTE', 'DIRECTOR', 7782, '1981-11-14', 500000, 100000, 10

-- 12) Modificación del ejercicio anterior, si no se introducen datos correctamente, informar de ello con un mensaje y no realizar la baja:
-- Si el empleado introducido no existe en la base de datos, deberemos informarlo con un mensaje indicando ‘Empleado no existente en la BD, verifique los datos del señor ‘apellidoIntroducido’.
-- Si el empleado existe, pero los datos para eliminarlo son incorrectos, informaremos mostrando los datos reales del empleado junto con los datos introducidos por el usuario, para que se vea el fallo.
CREATE OR ALTER PROCEDURE BorrarEmpleadoSegunParametrosComprobacion @Emp_No INT, @Apellido VARCHAR(50), @Oficio VARCHAR(50), @Dir INT, @Fecha_Alt DATE, @Salario NUMERIC(9,2), @Comision NUMERIC(9,2), @Dept_No INT
AS
	BEGIN
		IF EXISTS (SELECT Emp_No FROM Emp WHERE Emp_No = @Emp_No AND Apellido = @Apellido AND Oficio = @Oficio AND Dir = @Dir AND Fecha_Alt = @Fecha_Alt AND Salario = @Salario AND Comision = @Comision AND Dept_No = @Dept_No)
			BEGIN
				DELETE FROM Emp
				WHERE Emp_No = @Emp_No

				PRINT('El empleado se ha eliminado correctamente.')
			END
		ELSE IF (@Emp_No NOT IN (SELECT Emp_No FROM Emp))
			BEGIN
				PRINT('Empleado no existente en la BD, verifique los datos del señor.')
			END
		ELSE
			BEGIN
				SELECT * FROM Emp
				WHERE Emp_No = @Emp_No
				PRINT('El empleado existe, pero los datos para eliminarlo son incorrectos')
			END
	END

EXECUTE BorrarEmpleadoSegunParametrosComprobacion 7322, 'GARCIA', 'EMPLEADO', 7119, '1982-10-12', 129000, 0, 20 -- Se elimina
EXECUTE BorrarEmpleadoSegunParametrosComprobacion 9138, 'LORENTE', 'DIRECTOR', 7782, '1981-11-14', 500000, 100000, 10 -- No existe
EXECUTE BorrarEmpleadoSegunParametrosComprobacion 7119, 'PEPA', 'DIRECTOR', 7782, '1983-11-19', 225000, 39000, 20 -- Existe pero los datos son erróneos

-- 13) Crear un procedimiento para insertar un empleado de la plantilla del Hospital.
-- Para poder insertar el empleado realizaremos restricciones:
-- No podrá estar repetido el número de empleado.
-- Para insertar, lo haremos por el nombre del hospital y por el nombre de sala, si no existe
-- la sala o el hospital, no insertaremos y lo informaremos.
-- Para insertar la función de la plantilla deberá estar entre los que hay en la base de datos, al igual que el Turno.
-- El salario no superará las 500.000 euros.
CREATE OR ALTER PROCEDURE InsertarEmpleadoHospital @numEmp INT, @nombreHospital VARCHAR(50), @salaCod INT, @salario NUMERIC(9, 2), @turno CHAR
AS
	BEGIN
		IF ((@numEmp NOT IN (SELECT @numEmp FROM Emp)) AND (@nombreHospital IN (SELECT Nombre FROM Hospital)) AND @salario < 500000)
			BEGIN
				INSERT INTO Plantilla VALUES (@numEmp, @salaCod, (SELECT Hospital_Cod FROM Hospital WHERE Nombre = @nombreHospital), (SELECT Apellido FROM Emp WHERE Emp_No = @numEmp), (SELECT Oficio FROM Emp WHERE Emp_No = @numEmp), @turno, @salario)
			END
		ELSE
			BEGIN
				PRINT('Los datos no cumplen las restricciones')
			END
	END

EXECUTE InsertarEmpleadoHospital 7839, 'General', 22, 120000, M
