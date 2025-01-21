CREATE DATABASE Criaturas Raras
GO
USE Criaturas Raras
GO

CREATE TABLE CriaturitasRaras(
	ID tinyint Not NULL,
	Nombre nvarchar(30) Not NULL,
	FechaNac Date NULL, 
	NumeroPie SmallInt NULL,
	NivelIngles NChar(2) NULL,
	Historieta VarChar(300) NULL,
	NumeroChico TinyInt NULL,
	NumeroGrande BigInt NULL,
	NumeroIntermedio SmallInt NULL,
	Temperatura Decimal(3,1) NULL,
	CONSTRAINT [PK_CriaturitasEx] PRIMARY KEY(ID),
	Constraint CK_NumeroPie Check (numeroPie BETWEEN 25 AND 60),
	Constraint CK_NumeroChico Check (NumeroChico < 1000),
	Constraint CK_NumeroGrande Check (NumeroGrande > (NumeroChico * 100)),
	Constraint CK_NumeroIntermedio Check ((NumeroIntermedio % 2 = 0) AND (NumeroIntermedio BETWEEN NumeroChico AND NumeroGrande)),
	Constraint CK_FechaNac Check (FechaNac < CURRENT_TIMESTAMP),
	Constraint CK_NivelIngles Check (NivelIngles IN ('A0', 'A1', 'A2', 'B1', 'B2', 'C1', 'C2')),
	Constraint CK_Historieta Check (Historieta NOT IN ('%oscuro%', '%apocalipsis%')),
	Constraint CK_Temperatura Check (Temperatura BETWEEN 32.5 AND 44),
	Constraint CK_Imaginacion Check (Historieta != ('Pecadores' + NumeroPie))
) 