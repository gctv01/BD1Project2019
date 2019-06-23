CREATE TABLE EMPLEADO(
    expediente SERIAL NOT NULL,
    di NUMERIC(10) NOT NULL UNIQUE,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(20) NOT NULL,
    apellido2 VARCHAR(20) NOT NULL,
    fecha_nacimiento TIMESTAMP NOT NULL,
    genero VARCHAR(1) NOT NULL CONSTRAINT check_genero check(genero in('M', 'F','T')),
    tipo_sangre VARCHAR(3) NOT NULL CONSTRAINT check_sangre check(tipo_sangre in('O+','A+','B+','AB+','O-','A-','B-','AB-')),
    titulo VARCHAR(1) NOT NULL CONSTRAINT check_titulo check(titulo in('B','Q','M','P','I','G')),
    fk_supervisor INTEGER,
    nombre2 VARCHAR(20),

    PRIMARY KEY(expediente),
    FOREIGN KEY(fk_supervisor) REFERENCES EMPLEADO(expediente)
);

CREATE TABLE COND_SALUD(
    id SERIAL NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    alergia BOOLEAN NOT NULL,
    descripcion VARCHAR(100),

    PRIMARY KEY(id)
);

CREATE TABLE E_C(
    fk_empleado INTEGER NOT NULL,
    fk_cond INTEGER NOT NULL,

    PRIMARY KEY(fk_empleado,fk_cond),
    FOREIGN KEY(fk_empleado) REFERENCES EMPLEADO(expediente),
    FOREIGN KEY(fk_cond) REFERENCES COND_SALUD(id)
);

/*CREATE TABLE TELEFONO(
    cod NUMERIC(4) NOT NULL,
    num NUMERIC(4) NOT NULL,
    fk_empleado INTEGER,
    fk_cliente INTEGER,

    PRIMARY KEY(cod,num),
    FOREIGN KEY(fk_empleado) REFERENCES EMPLEADO(expediente),
    FOREIGN KEY(fk_cliente) REFERENCES CLIENTE(id)
);*/

CREATE TABLE DETALLE_EXP(
    id SERIAL NOT NULL,
    fecha TIMESTAMP NOT NULL,
    motivo VARCHAR(2) NOT NULL CONSTRAINT check_motivo check(motivo in('IN','BM','BA','AM','RE','HE')),
    fk_empleado INTEGER NOT NULL,
    descripcion VARCHAR(100),
    monto_bono NUMERIC(11,2),
    horas_extras NUMERIC(4),
    retraso NUMERIC(4),

    PRIMARY KEY(id,fk_empleado),
    FOREIGN KEY(fk_empleado) REFERENCES EMPLEADO(expediente)
);

CREATE TABLE ORGANIGRAMA(
    id SERIAL NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    tipo VARCHAR(1) NOT NULL CONSTRAINT check_tipo check(tipo in('G','S','D','A')),
    nivel NUMERIC(1) NOT NULL CONSTRAINT check_nivel check(nivel in(1,2,3,4)),
    fk_superior INTEGER,
    descripcion VARCHAR(100),

    PRIMARY KEY(id),
    FOREIGN KEY(fk_superior) REFERENCES ORGANIGRAMA(id)
);

CREATE TABLE EMPLEO(
    fecha_inicio TIMESTAMP NOT NULL,
    sueldo NUMERIC(11,2) NOT NULL,
    cargo VARCHAR(1) NOT NULL CONSTRAINT check_cargo check(cargo in('S','G','O','E','M','I')),
    fk_empleado INTEGER NOT NULL,
    fk_organigrama INTEGER NOT NULL,
    fecha_fin TIMESTAMP,

    PRIMARY KEY(fecha_inicio,fk_empleado),
    FOREIGN KEY(fk_empleado) REFERENCES EMPLEADO(expediente),
    FOREIGN KEY(fk_organigrama) REFERENCES ORGANIGRAMA(id)
);

CREATE TABLE TURNOS_HIST(
    fecha_inicio TIMESTAMP NOT NULL,
    turno NUMERIC(1) NOT NULL CONSTRAINT check_turno check(turno in(1,2,3)),
    fk_empleo TIMESTAMP NOT NULL,
    fk_empleado INTEGER NOT NULL,
    fecha_fin TIMESTAMP,

    PRIMARY KEY(fecha_inicio,fk_empleo,fk_empleado),
    FOREIGN KEY(fk_empleo,fk_empleado) REFERENCES EMPLEO(fecha_inicio,fk_empleado)
);

CREATE TABLE REUNION(
    id SERIAL NOT NULL,
    fecha TIMESTAMP NOT NULL,
    minuta VARCHAR(100) NOT NULL,
    fk_supervisor INTEGER NOT NULL,

    PRIMARY KEY(id,fk_supervisor),
    FOREIGN KEY(fk_supervisor) REFERENCES EMPLEADO(expediente)
);

CREATE TABLE INASISTENCIA(
    fk_empleo TIMESTAMP NOT NULL,
    fk_empleado INTEGER NOT NULL,
    fk_reunion INTEGER NOT NULL,
    fk_supervisor INTEGER NOT NULL,

    PRIMARY KEY(fk_empleo,fk_empleado,fk_reunion,fk_supervisor),
    FOREIGN KEY(fk_empleo,fk_empleado) REFERENCES EMPLEO(fecha_inicio,fk_empleado),
    FOREIGN KEY(fk_reunion,fk_supervisor) REFERENCES REUNION(id,fk_supervisor)
);
