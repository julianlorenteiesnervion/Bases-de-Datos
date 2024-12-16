
/* 
Crear una BD con nombre Pleitos donde crearemos las siguientes tablas:

Abogados: ID(PK), nombre, apellidos

Pol�ticos: ID(PK), nombre, apellidos

Causas: numero(PK), nombre juzgado(PK)

Implica (tambi�n se podr�a poner Pol�ticosAbogadosCausas): ID Pol�ticos(FK Pol�ticos), ID Abogados (FK Abogados), numero(FK Causas), nombre juzgado(FK Causas), soborno

Los campos no permiten nulos.

Al existir una relaci�n entre las tablas, queremos que no permita el borrado o actualizaci�n de los registros relacionados.

*/

USE pleitos
GO
CREATE TABLE IMPLICA (
ID_POLITICO int,
Constraint FK_ID_POLITICO FOREIGN KEY (ID_POLITICO) REFERENCES POLITICOS (ID)
)