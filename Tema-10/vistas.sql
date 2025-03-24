USE Instituto
GO

-- 1. Crear la vista Repetidores con los alumnos (nombre y dni) que repiten en alguna asignatura
CREATE VIEW Repetidores AS (
	SELECT A.nombre, A.dni
	FROM Alumno AS A
	INNER JOIN matriculado AS M ON A.dni = M.dni
	WHERE M.repe > 0
)

-- 2. Crear la vista AsignaturasRepetidores que muestre las asignaturas (cod como codigoAsig y nombre como asignatura) donde están matriculado algún alumno repetidor. Ordenar por código de asignatura.
CREATE VIEW AsignaturasRepetidores AS (
	SELECT TOP 100 PERCENT A.cod, A.nombre
	FROM Asignatura AS A
	INNER JOIN Matriculado AS M ON A.cod = M.cod
	WHERE M.dni IN (SELECT dni FROM Repetidores)
	GROUP BY A.cod, A.nombre
)

-- 3. Crear la vista ProfeRepetidores que muestre el dni de los profes que imparten clase a algún alumno repetidor.
CREATE VIEW ProfeRepetidores AS (
	SELECT DISTINCT I.dni FROM Imparte AS I
	INNER JOIN AsignaturasRepetidores AS A ON I.cod = A.cod
	WHERE I.dni IN (SELECT dni FROM AsignaturasRepetidores)
)

-- 4. Crear la vista ProfeSinAsignatura (nombre y dni) que muestre a los profesores que no imparten ninguna asignatura.
CREATE VIEW ProfeSinAsignatura AS (
	SELECT P.nombre, P.dni FROM Profesor AS P
	WHERE P.dni NOT IN (SELECT dni FROM Imparte)
)

-- 5. Crear la vista ProfeSinAlumnos que muestre a los profesores que imparten una 
-- asignatura donde no hay ningún alumno matriculado.
CREATE VIEW ProfeSinAlumnos AS (
	SELECT DISTINCT I.dni FROM Imparte AS I
	LEFT JOIN Matriculado AS M ON I.cod = M.cod
	WHERE M.cod IS NULL
)

-- 6. Crear la vista ProfeSinClase que muestra los profesores que no dan clase. Ya sea por no impartir
-- ninguna asignatura o por impartir una asignatura donde no hay ningún alumno matriculado.
CREATE VIEW ProfeSinClase AS (
	SELECT dni FROM ProfeSinAsignatura
	UNION
	SELECT * FROM ProfeSinAlumnos
)

-- 7. Modificar la vista Repetidores para que muestre la edad del alumno.
ALTER VIEW Repetidores AS (
	SELECT A.nombre, A.dni, YEAR(GETDATE()) - YEAR(A.fecNac) AS 'edad'
	FROM Alumno AS A
	INNER JOIN matriculado AS M ON A.dni = M.dni
	WHERE M.repe > 0
)

-- 8. Eliminar la vista ProfeSinClase.
DROP VIEW ProfeSinClase