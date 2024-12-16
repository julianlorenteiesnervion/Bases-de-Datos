
/* 
Crear una BD con nombre Pleitos donde crearemos las siguientes tablas:

Abogados: ID(PK), nombre, apellidos

Políticos: ID(PK), nombre, apellidos

Causas: numero(PK), nombre juzgado(PK)

Implica (también se podría poner PolíticosAbogadosCausas): ID Políticos(FK Políticos), ID Abogados (FK Abogados), numero(FK Causas), nombre juzgado(FK Causas), soborno

Los campos no permiten nulos.

Al existir una relación entre las tablas, queremos que no permita el borrado o actualización de los registros relacionados.

*/

USE pleitos
GO
CREATE TABLE IMPLICA (
ID_POLITICO int,
Constraint FK_ID_POLITICO FOREIGN KEY (ID_POLITICO) REFERENCES POLITICOS (ID)
)