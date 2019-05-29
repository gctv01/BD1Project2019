CREATE TABLE EMPLEADO(expediente number(4) CONSTRAINT emp_pk Primary Key,
di number(4) not null,
nombre varchar(20) not null,
apellido varchar(20) not null,
apellido2 varchar(20) not null,
fecha_nacimiento date not null,
genero varchar(1) CHECK('M','F','T'))