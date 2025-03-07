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
	Constraint PK_DEPTOSEMPLEADOS Primary Key (DNI_EMPLEADO, NUM_DPTO),
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
	color Varchar(10) Not Null,
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
	Constraint FK_Alumnos_Ordenadores_ordenador Foreign Key (ordenador) References ORDENADORES (id),
	Constraint UQ_ORDENADOR UNIQUE (ordenador)
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
	ordenador Int Not Null,
	aplicacion Varchar(30),
	tiempo Time Not Null,
	Constraint PK_UTILIZA Primary Key (alumno, aplicacion),
	Constraint FK_Utiliza_Alumnos_alumno Foreign Key (alumno) References ALUMNOS (dni) ON UPDATE NO ACTION ON DELETE NO ACTION,
	Constraint FK_Utiliza_Ordenadores_ordenador Foreign Key (ordenador) References ORDENADORES (id) ON UPDATE NO ACTION ON DELETE NO ACTION,
	Constraint FK_Utiliza_Aplicaciones_aplicacion Foreign Key (aplicacion) References APLICACIONES (titulo) ON UPDATE NO ACTION ON DELETE NO ACTION
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
	Constraint FK_Conductores_Calles_calle Foreign Key (calle) References CALLES (nombre) ON UPDATE NO ACTION ON DELETE NO ACTION
)

CREATE TABLE UTILIZA (
	conductor Int,
	autobus Int,
	linea Int,
	dia Date,
	Constraint PK_UTILIZA Primary Key (conductor, autobus, dia),
	Constraint FK_Utiliza_Conductores_conductor Foreign Key (conductor) References CONDUCTORES (dni) ON UPDATE NO ACTION ON DELETE NO ACTION,
	Constraint FK_Utiliza_Autobuses_autobus Foreign Key (autobus) References AUTOBUSES (matricula) ON UPDATE NO ACTION ON DELETE NO ACTION,
	Constraint FK_Utiliza_Lineas_linea Foreign Key (linea) References LINEAS (numero) ON UPDATE NO ACTION ON DELETE NO ACTION
)

CREATE TABLE PASA (
	linea Int,
	calle Varchar(100),
	Constraint PK_PASA Primary Key (linea, calle),
	Constraint FK_Pasa_Lineas_linea Foreign Key (linea) References LINEAS (numero) ON UPDATE NO ACTION ON DELETE NO ACTION,
	Constraint FK_Pasa_Calles_calle Foreign Key (calle) References CALLES (nombre) ON UPDATE NO ACTION ON DELETE NO ACTION
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
	Constraint PK_OFICINAS Primary Key (edificio, numero),
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
	Constraint FK_EmpleadosOficinistas_jefe Foreign Key (jefe) References EMPLEADOS_OFICINISTAS (dni)
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

-- Aqu� a�ado la foreign key de profesores a la tabla de seminarios
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

-- A�ado a tutorias la foreign key de alumnos
ALTER TABLE TUTORIAS
ADD Constraint FK_TUTORIAS_ALUMNOS_alumno Foreign Key (alumno) References ALUMNOS (dni)

-- A�ado a expedientes la foreign key de alumnos
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

/* BASE DE DATOS EJERCICIO 16 */
CREATE DATABASE Ej16
GO
USE Ej16
GO

CREATE TABLE EMPLEADOS (
	codEmpleado Int,
	nombre Varchar(50),
	apellidos Varchar(100),
	nif Int,
	direccion Varchar(100),
	telefono Varchar(9),
	salario Int,
	Constraint PK_EMPLEADOS Primary Key (codEmpleado)
)

CREATE TABLE CURSOS (
	codCurso Int,
	nombre Varchar(50),
	descripcion Varchar(100),
	Constraint PK_CURSOS Primary Key (codCurso)
)

CREATE TABLE EDICIONES (
	codCurso Int,
	fechaCurso date,
	lugar Varchar(100),
	horario time,
	capacidad Int,
	Constraint PK_EDICIONES Primary Key (codCurso, fechaCurso),
	Constraint FK_EDICIONES_CURSOS_codCurso Foreign Key (codCurso) References CURSOS (codCurso)
)

CREATE TABLE RECIBE (
	codEmpleado Int,
	codCurso Int,
	fechaCurso date,
	Constraint PK_RECIBE Primary Key (codEmpleado, codCurso, fechaCurso),
	Constraint FK_RECIBE_EMPLEADOS_codEmpleado Foreign Key (codEmpleado) References EMPLEADOS (codEmpleado),
	Constraint FK_RECIBE_EDICIONES_codCurso_fechaCurso Foreign Key (codCurso, fechaCurso) References EDICIONES (codCurso, fechaCurso)
)

CREATE TABLE CAPACITADOS (
	codEmpleado Int,
	Constraint PK_CAPACITADOS Primary Key (codEmpleado),
	Constraint FK_CAPACITADOS_EMPLEADOS_codEmpleado Foreign Key (codEmpleado) References EMPLEADOS (codEmpleado)
)

CREATE TABLE NOCAPACITADOS (
	codEmpleado Int,
	Constraint PK_NOCAPACITADOS Primary Key (codEmpleado),
	Constraint FK_NOCAPACITADOS_EMPLEADOS_codEmpleado Foreign Key (codEmpleado) References EMPLEADOS (codEmpleado)
)

/* BASE DE DATOS EJERCICIO 17 */
CREATE DATABASE Ej17
GO
USE Ej17
GO

CREATE TABLE MUNICIPIOS (
	cp Int,
	Constraint PK_MUNICIPIOS Primary Key (cp)
)

CREATE TABLE VIVIENDAS (
	calle Varchar(100),
	numero Int,
	cp Int,
	Constraint PK_VIVIENDAS Primary Key (calle, numero, cp),
	Constraint FK_VIVIENDAS_MUNICIPIOS_cp Foreign Key (cp) References MUNICIPIOS (cp)
)

CREATE TABLE PERSONAS (
	dni Int,
	empadronada Int,
	calle Varchar(100),
	numero Int,
	cp Int,
	cabezaFamilia Varchar(100),
	vive Varchar(100),
	Constraint PK_PERSONAS Primary Key (dni),
	Constraint FK_PERSONAS_MUNICIPIOS_empadronada Foreign Key (empadronada) References MUNICIPIOS (cp),
	Constraint FK_PERSONAS_VIVIENDAS_calle_numero_cp Foreign Key (calle, numero, cp) References VIVIENDAS (calle, numero, cp),
	Constraint FK_PERSONAS_PERSONAS_cabezaFamilia Foreign Key (cabezaFamilia) References PERSONAS (cabezaFamilia)
)

CREATE TABLE PROPIETARIAS (
	dni Int,
	calle Varchar(100),
	numero Int,
	cp Int,
	Constraint PK_PROPIETARIAS Primary Key (dni, calle, numero, cp),
	Constraint FK_PROPIETARIAS_PERSONAS_dni Foreign Key (dni) References PERSONAS (dni),
	Constraint FK_PROPIETARIAS_VIVIENDAS_calle_numero_cp Foreign Key (calle, numero, cp) References VIVIENDAS (calle, numero, cp)
)

/* BASE DE DATOS EJERCICIO 18 */
CREATE DATABASE Ej18
GO
USE Ej18
GO

CREATE TABLE AREAS (
	codArea Int,
	Constraint PK_AREAS Primary Key (codArea)
)

CREATE TABLE AREAPROFESOR (
	area Int,
	profesor Int,
	Constraint PK_AREAPROFESOR Primary Key (area, profesor)
)

CREATE TABLE SEDES (
	codSede Int,
	Constraint PK_SEDES Primary Key (codSede)
)

CREATE TABLE ALUMNOS (
	dni Int,
	Constraint PK_ALUMNOS Primary Key (dni)
)

CREATE TABLE COORDINADORES (
	dni Int,
	Constraint PK_COORDINADORES Primary Key (dni)
)

CREATE TABLE PROFESORES (
	dni Int,
	encarga Int,
	sede Int,
	Constraint PK_PROFESORES Primary Key (dni),
	Constraint FK_PROFESORES_AREAS_encarga Foreign Key (encarga) References AREAS (codArea),
	Constraint FK_PROFESORES_SEDES_sede Foreign Key (sede) References SEDES (codSede)
)

CREATE TABLE CURSOS (
	codCurso Int,
	area Int,
	coordinador Int,
	dirigido Int,
	Constraint PK_CURSOS Primary Key (codCurso),
	Constraint FK_CURSOS_AREAS_area Foreign Key (area) References AREAS (codArea),
	Constraint FK_CURSOS_COORDINADORES_coordinador_dirigido Foreign Key (coordinador, dirigido) References COORDINADORES (dni)
)

CREATE TABLE AREAS_SEDES (
	area Int,
	sede Int,
	Constraint PK_AREASSEDES Primary Key (area, sede),
	Constraint FK_AREASSEDES_AREAS_area Foreign Key (area) References AREAS (codArea),
	Constraint FK_AREASSEDES_SEDES_sede Foreign Key (sede) References SEDES (codSede)
)

CREATE TABLE MATRICULAS (
	curso Int,
	alumno Int,
	Constraint PK_MATRICULAS Primary Key (curso, alumno),
	Constraint FK_MATRICULAS_CURSOS_curso Foreign Key (curso) References CURSOS (codCurso),
	Constraint FK_MATRICULAS_ALUMNOS_alumno Foreign Key (alumno) References ALUMNOS (dni)
)

CREATE TABLE PROFESORES_CURSOS (
	profesor Int,
	curso Int,
	Constraint PK_PROFESORESCURSOS Primary Key (profesor, curso),
	Constraint FK_PROFESORESCURSOS_PROFESORES_profesor Foreign Key (profesor) References PROFESORES (dni),
	Constraint FK_PROFESORESCURSOS_CURSOS_curso Foreign Key (curso) References CURSOS (codCurso)
)