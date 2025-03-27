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
CREATE OR ALTER PROCEDURE SalarioOficioApellidoNombreSegunApellido
AS
	BEGIN
		
	END