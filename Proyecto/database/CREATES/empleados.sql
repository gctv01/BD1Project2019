CREATE TABLE EMPLEADO(
expediente NUMERIC(4) NOT NULL,
di NUMERIC(4) NOT NULL,
nombre VARCHAR(20) NOT NULL,
apellido VARCHAR(20) NOT NULL,
apellido2 VARCHAR(20) NOT NULL,
fecha_nacimiento date NOT NULL,
genero VARCHAR(1) NOT NULL CONSTRAINT check_genero check(genero in('M', 'F','T')),
tipo_sangre VARCHAR(3) NOT NULL CONSTRAINT check_sangre check(tipo_sangre in('O+','A+','B+','AB+','O-','A-','B-','AB-')),
titulo VARCHAR(1) NOT NULL CONSTRAINT check_titulo check(titulo in('B','Q','M','P','I','G')),
id_supervisor NUMERIC(4),
nombre2 VARCHAR(20),

PRIMARY KEY(expediente),
FOREIGN KEY(id_supervisor) REFERENCES EMPLEADO(expediente)
);

CREATE TABLE COND_SALUD(
id NUMERIC(4) NOT NULL,
nombre VARCHAR(20) NOT NULL,
alergia BOOLEAN NOT NULL,
descripcion VARCHAR(30),

PRIMARY KEY(id)
);

CREATE TABLE E_C(
id_empleado NUMERIC(4) NOT NULL,
id_cond NUMERIC(4) NOT NULL,

PRIMARY KEY(id_empleado,id_cond),
FOREIGN KEY(id_empleado) REFERENCES EMPLEADO(expediente),
FOREIGN KEY(id_cond) REFERENCES COND_SALUD(id)
);

/*CREATE TABLE TELEFONO(
cod NUMERIC(4) NOT NULL,
num NUMERIC(4) NOT NULL,
id_empleado NUMERIC(4),
id_cliente NUMERIC(4),

PRIMARY KEY(cod,num),
FOREIGN KEY(id_empleado) REFERENCES EMPLEADO(id),
FOREIGN KEY(id_cliente) REFERENCES CLIENTE(id)
);*/

CREATE TABLE DETALLE_EXP(
id NUMERIC(4) NOT NULL,
fecha DATE NOT NULL,
motivo VARCHAR(2) NOT NULL CONSTRAINT check_motivo check(motivo in('IN','BM','BA','AM','RE','HE')),
id_empleado NUMERIC(4) NOT NULL,
descripcion VARCHAR(30),
monto_bono NUMERIC(4,2),
horas_extras

PRIMARY KEY(id,id_empleado),
FOREIGN KEY(id_empleado) REFERENCES EMPLEADO(expediente),
);

