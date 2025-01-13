/* BASE DE DATOS EJERCICIO 2 */
CREATE DATABASE Ej2
GO
USE Ej2
GO

CREATE TABLE Empleados (
	DNI tinyInt,
	Constraint PK_DNI Primary Key (DNI)
)

CREATE TABLE Departamentos (
	NUMDPTO int,
	Constraint PK_NUMDPTO Primary Key (NUMDPTO)
)

CREATE TABLE Deptos_Empleados (
	DNI_EMPLEADO tinyInt,
	NUM_DPTO int,
	Constraint FK_DeptosEmpleados_Empleados_dniEmpleado FOREIGN KEY (DNI_EMPLEADO) REFERENCES Empleados (DNI),
	Constraint FK_DeptosEmpleados_Departamentos_numDpto FOREIGN KEY (NUM_DPTO) REFERENCES Departamentos (NUMDPTO)
)

/* BASE DE DATOS EJERCICIO 3 */
CREATE DATABASE Ej3
GO
USE Ej3
GO

CREATE TABLE FUTBOLISTAS (
	dni tinyInt,
	Constraint PK_FUTBOLISTAS Primary Key (dni)
)

CREATE TABLE PARTIDOS (
	id int,
	fecha date,
	Constraint PK_PARTIDOS Primary Key (id)
)

CREATE TABLE PARTIDOS_JUGADORES (
	id int,
	dni tinyInt,
	CONSTRAINT FK_PartidosJugadores_Partidos_id FOREIGN KEY (id) REFERENCES PARTIDOS (id),
	CONSTRAINT FK_PartidosJugadores_Futbolistas_dni FOREIGN KEY (dni) REFERENCES FUTBOLISTAS (dni)
)

/* BASE DE DATOS EJERCICIO 4 */
CREATE DATABASE Ej4
GO
USE Ej4
GO

CREATE TABLE CLIENTES (
	dni Int,
	Constraint PK_CLIENTES Primary Key (dni)
)

CREATE TABLE TRAJES (
	modelo Varchar(10),
	Constraint PK_TRAJES Primary Key (modelo)
)

CREATE TABLE COMPRAS (
	dni Int,
	modelo Varchar(10),
	fecha Date,
	unidades TinyInt,
	Constraint PK_COMPRAS Primary Key (dni, modelo, fecha),
	Constraint FK_Compras_Clientes_dni Foreign Key (dni) References CLIENTES (dni),
	Constraint FK_Compras_Trajes_modelo Foreign Key (modelo) References TRAJES (modelo)
)

/* BASE DE DATOS EJERCICIO 5 */
CREATE DATABASE Ej5
GO
USE Ej5
GO

CREATE TABLE PERSONAS (
	dni Int,
	Constraint PK_PERSONAS Primary Key (dni)
)

CREATE TABLE COCHES (
	matricula Int,
	color varchar(10),
	dueno Int,
	Constraint PK_COCHES Primary Key (matricula),
	Constraint FK_Coches_Personas_dueno Foreign Key (dueno) References PERSONAS (dni)
)

/* BASE DE DATOS EJERCICIO 6 */
CREATE DATABASE Ej6
GO
USE Ej6
GO

CREATE TABLE PERSONAS (
	dni Int,
	Constraint PK_PERSONAS Primary Key (dni)
)

CREATE TABLE COCHES (
	matricula Int,
	color Varchar(10),
	Constraint PK_COCHES Primary Key (matricula)
)

CREATE TABLE POSEEDORES (
	dni Int,
	matricula Int,
	fecha Date,
	Constraint PK_POSEEDORES Primary Key (dni, matricula, fecha),
	Constraint FK_Poseedores_Personas_dni Foreign Key (dni) References PERSONAS (dni),
	Constraint FK_Poseedores_Coches_matricula Foreign Key (matricula) References COCHES (matricula)
)

/* BASE DE DATOS EJERCICIO 8 */
CREATE DATABASE Ej8
GO
USE Ej8
GO

CREATE TABLE COCHES (
	matricula Int,
	Constraint PK_COCHES Primary Key (matricula)
)

CREATE TABLE COCHERAS (
	id Int,
	Constraint PK_COCHERAS Primary Key (id),
)

CREATE TABLE COCHES_COCHERAS (
	matricula Int,
	idCochera Int Not Null,
	Constraint PK_COCHES_COCHERAS Primary Key (matricula),
	Constraint FK_CochesCocheras_Cocheras_idCochera Foreign Key (idCochera) References COCHERAS (id),
	Constraint UQ_COCHES_COCHERAS Unique (idCochera)
)

/* BASE DE DATOS EJERCICIO 9 */
CREATE DATABASE Ej9
GO
USE Ej9
GO

CREATE TABLE AULAS (
	numero Int,
	Constraint PK_AULAS Primary Key (numero)
)

CREATE TABLE ORDENADORES (
	id Int,
	aula Int,
	Constraint PK_ORDENADORES Primary Key (id),
	Constraint FK_Ordenadores_Aulas_aula Foreign Key (aula) References AULAS (numero)
)

CREATE TABLE ALUMNOS (
	dni Int,
	ordenador Int,
	Constraint PK_ALUMNOS Primary Key (dni),
	Constraint FK_Alumnos_Ordenadores_ordenador Foreign Key (ordenador) References ORDENADORES (id)
)

/* BASE DE DATOS EJERCICIO 10 */
CREATE DATABASE Ej10
GO
USE Ej10
GO

CREATE TABLE ALUMNOS (
	dni Int,
	Constraint PK_ALUMNOS Primary Key (dni)
)

CREATE TABLE ORDENADORES (
	id Int,
	Constraint PK_ORDENADORES Primary Key (id)
)

CREATE TABLE AULAS (
	numero Int,
	Constraint PK_AULAS Primary Key (numero)
)

CREATE TABLE UTILIZA (
	dni Int,
	ordenador Int,
	curso Int,
	Constraint PK_UTILIZA Primary Key (dni, ordenador, curso),
	Constraint FK_Utiliza_Alumnos_dni Foreign Key (dni) References ALUMNOS (dni),
	Constraint FK_Utiliza_Ordenadores_ordenador Foreign Key (ordenador) References ORDENADORES (id)
)

CREATE TABLE ESTA (
	ordenador Int,
	aula Int,
	curso Int,
	Constraint PK_ESTA Primary Key (ordenador, aula, curso),
	Constraint FK_Esta_Ordenadores_ordenador Foreign Key (ordenador) References ORDENADORES (id),
	Constraint FK_Esta_Aulas_aula Foreign Key (aula) References AULAS (numero)
)

/* BASE DE DATOS EJERCICIO 11 */
CREATE DATABASE Ej11
GO
USE Ej11
GO

CREATE TABLE ALUMNOS (
	dni Int,
	Constraint PK_ALUMNOS Primary Key (dni)
)

CREATE TABLE ORDENADORES (
	id Int,
	Constraint PK_ORDENADORES Primary Key (id)
)

CREATE TABLE APLICACIONES (
	titulo Varchar(30),
	Constraint PK_APLICACIONES Primary Key (titulo)
)

CREATE TABLE UTILIZA (
	alumno Int,
	ordenador Int,
	aplicacion Varchar(30),
	tiempo Time,
	Constraint PK_UTILIZA Primary Key (alumno, aplicacion),
	Constraint FK_Utiliza_Alumnos_alumno Foreign Key (alumno) References ALUMNOS (dni),
	Constraint FK_Utiliza_Ordenadores_ordenador Foreign Key (ordenador) References ORDENADORES (id),
	Constraint FK_Utiliza_Aplicaciones_aplicacion Foreign Key (aplicacion) References APLICACIONES (titulo)
)

/* BASE DE DATOS EJERCICIO 12 */
CREATE DATABASE Ej12
GO
USE Ej12
GO

CREATE TABLE AUTOBUSES (
	matricula Int,
	Constraint PK_AUTOBUSES Primary Key (matricula)
)

CREATE TABLE LINEAS (
	numero Int,
	Constraint PK_LINEAS Primary Key (numero)
)

CREATE TABLE CALLES (
	nombre Varchar(100),
	Constraint PK_CALLES Primary Key (nombre)
)

CREATE TABLE CONDUCTORES (
	dni Int,
	calle Varchar(100),
	Constraint PK_CONDUCTORES Primary Key (dni),
	Constraint FK_Conductores_Calles_calle Foreign Key (calle) References CALLES (nombre)
)

CREATE TABLE UTILIZA (
	conductor Int,
	autobus Int,
	linea Int,
	dia Date,
	Constraint PK_UTILIZA Primary Key (conductor, autobus, dia),
	Constraint FK_Utiliza_Conductores_conductor Foreign Key (conductor) References CONDUCTORES (dni),
	Constraint FK_Utiliza_Autobuses_autobus Foreign Key (autobus) References AUTOBUSES (matricula),
	Constraint FK_Utiliza_Lineas_linea Foreign Key (linea) References LINEAS (numero)
)

CREATE TABLE PASA (
	linea Int,
	calle Varchar(100),
	Constraint PK_PASA Primary Key (linea, calle),
	Constraint FK_Pasa_Lineas_linea Foreign Key (linea) References LINEAS (numero),
	Constraint FK_Pasa_Calles_calle Foreign Key (calle) References CALLES (nombre)
)

/* BASE DE DATOS EJERCICIO 13 */
CREATE DATABASE Ej13
GO
USE Ej13
GO

CREATE TABLE EDIFICIOS (
	nombre Varchar(50),
	direccion Varchar(100),
	Constraint PK_EDIFICIOS Primary Key (nombre)
)

CREATE TABLE EMPRESAS (
	cif Int,
	nombre Varchar(50),
	Constraint PK_EMPRESAS Primary Key (cif)
)

CREATE TABLE OFICINAS (
	edificio Varchar(50),
	numero Int,
	empresa Int,
	Constraint FK_Oficinas_Edificios_edificio Foreign Key (edificio) References EDIFICIOS (nombre),
	Constraint FK_Oficinas_Empresas_empresa Foreign Key (empresa) References EMPRESAS (cif)
)

/* BASE DE DATOS EJERCICIO 14 */
CREATE DATABASE Ej14
GO
USE Ej14
GO

CREATE TABLE EDIFICIOS (
	nombre Varchar(50),
	direccion Varchar(100),
	Constraint PK_EDIFICIOS Primary Key (nombre)
)

CREATE TABLE OBRAS (
	id Int,
	Constraint PK_OBRAS Primary Key (id)
)

CREATE TABLE OFICINAS (
	edificio Varchar(50),
	numero Int,
	Constraint PK_OFICINAS Primary Key (edificio, numero),
	Constraint FK_Oficinas_Edificios_edificio Foreign Key (edificio) References EDIFICIOS (nombre)
)

CREATE TABLE EMPLEADOS_OFICINISTAS (
	dni Int,
	nombre Varchar(30),
	sueldo Int,
	titulacion Varchar(100),
	edificio Varchar(50),
	oficina Int,
	jefe Int,
	Constraint PK_EMPLEADOS_OFICINISTAS Primary Key (dni),
	Constraint FK_EMPLEADOSOFICINISTA_OFICINAS_edificio_oficina Foreign Key (edificio, oficina) References OFICINAS (edificio, numero),
	Constraint FK_EmpleadosOficinistas_EmpleadosOficinistas_jefe Foreign Key (jefe) References EMPLEADOS_OFICINISTAS (dni)
)

CREATE TABLE EMPLEADOS_OBREROS (
	dni Int,
	nombre Varchar(30),
	sueldo Int,
	obra Int,
	fechaInicio date,
	jefe Int,
	Constraint PK_EMPLEADOS_OBREROS Primary Key (dni),
	Constraint FK_EmpleadosObreros_Obras_obra Foreign Key (obra) References OBRAS (id),
	Constraint FK_EmpleadosObreros_EmpleadosObreros_jefe Foreign Key (jefe) References EMPLEADOS_OBREROS (dni)
)

/* BASE DE DATOS EJERCICIO 15 */
CREATE DATABASE Ej15
GO
USE Ej15
GO

CREATE TABLE ASIGNATURAS (
	codAsig Int,
	Constraint PK_ASIGNATURAS Primary Key (codAsig)
)

CREATE TABLE ESTUDIOS (
	codEstud Int,
	Constraint PK_ESTUDIOS Primary Key (codEstud)
)

CREATE TABLE GRUPOS (
	codGrupo Int,
	Constraint PK_GRUPOS Primary Key (codGrupo)
)

CREATE TABLE TUTORESLEGALES (
	dni Int,
	Constraint PK_TUTORESLEGALES Primary Key (dni)
)

CREATE TABLE ASIGNATURASESTUDIOS (
	codAsig Int,
	codEstud Int,
	Constraint PK_ASIGNATURASESTUDIOS Primary Key (codAsig, codEstud),
	Constraint FK_ASIGNATURASESTUDIOS_ASIGNATURAS_codAsig Foreign Key (codAsig) References ASIGNATURAS (codAsig),
	Constraint FK_ASIGNATURASESTUDIOS_ESTUDIOS_codEstud Foreign Key (codEstud) References ESTUDIOS (codEstud)
)

CREATE TABLE SEMINARIOS (
	codSemin Int,
	jefe Int,
	Constraint PK_SEMINARIOS Primary Key (codSemin)
)

CREATE TABLE PROFESORES (
	nrp Int,
	horaAlumn Time,
	horaPadres Time,
	seminario Int,
	Constraint PK_PROFESORES Primary Key (nrp),
	Constraint FK_PROFESORES_SEMINARIOS_seminario Foreign Key (seminario) References SEMINARIOS (codSemin)
)

-- Aquí añado la foreign key de profesores a la tabla de seminarios
ALTER TABLE SEMINARIOS
ADD Constraint FK_SEMINARIOS_PROFESORES_jefe Foreign Key (jefe) References PROFESORES (nrp)

CREATE TABLE IMPARTE (
	asignatura Int,
	profesor Int,
	grupo Int,
	Constraint PK_IMPARTE Primary Key (asignatura, profesor, grupo),
	Constraint FK_IMPARTE_ASIGNATURAS_asignatura Foreign Key (asignatura) References ASIGNATURAS (codAsig),
	Constraint FK_IMPARTE_PROFESORES_profesor Foreign Key (profesor) References PROFESORES (nrp),
	Constraint FK_IMPARTE_GRUPOS_grupo Foreign Key (grupo) References GRUPOS (codGrupo)
)

CREATE TABLE TUTORIAS (
	profesor Int,
	alumno Int,
	fecha date,
	Constraint PK_TUTORIAS Primary Key (profesor, alumno, fecha),
	Constraint FK_TUTORIAS_PROFESOR_profesor Foreign Key (profesor) References PROFESORES (nrp)
)

CREATE TABLE EXPEDIENTES (
	numReg Int,
	alumno Int,
	Constraint PK_EXPEDIENTES Primary Key (numReg)
)

CREATE TABLE ALUMNOS (
	dni Int,
	codEstudio Int,
	expediente Int,
	grupo Int,
	Constraint PK_ALUMNOS Primary Key (dni),
	Constraint FK_ALUMNOS_EXPEDIENTES_expediente Foreign Key (expediente) References EXPEDIENTES (numReg)
)

-- Añado a tutorias la foreign key de alumnos
ALTER TABLE TUTORIAS
ADD Constraint FK_TUTORIAS_ALUMNOS_alumno Foreign Key (alumno) References ALUMNOS (dni)

-- Añado a expedientes la foreign key de alumnos
ALTER TABLE EXPEDIENTES
ADD Constraint FK_EXPEDIENTES_ESTUDIOS_alumno Foreign Key (alumno) References ALUMNOS (dni)

CREATE TABLE FICHAS (
	numReg Int,
	codAsig Int,
	curso Int,
	junio Int,
	septiembre Int,
	Constraint PK_FICHAS Primary Key (numReg, codAsig, curso),
	Constraint FK_FICHAS_EXPEDIENTES_numReg Foreign Key (numReg) References EXPEDIENTES (numReg),
	Constraint FK_FICHAS_ASIGNATURAS_codAsig Foreign Key (codAsig) References ASIGNATURAS (codAsig)
)

CREATE TABLE ALUMNO_TUTOR_LEGAL (
	dniAlumn Int,
	dniTutor Int,
	Constraint PK_ALUMNOTUTORLEGAL Primary Key (dniAlumn, dniTutor),
	Constraint FK_ALUMNOTUTORLEGAL_ALUMNOS_dniAlumn Foreign Key (dniAlumn) References ALUMNOS (dni),
	Constraint FK_ALUMNOTUTORLEGAL_TUTORESLEGALES_dniTutor Foreign Key (dniTutor) References TUTORESLEGALES (dni)
)