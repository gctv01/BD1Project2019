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
    fk_supervisor NUMERIC(4),
    nombre2 VARCHAR(20),

    PRIMARY KEY(expediente),
    FOREIGN KEY(fk_supervisor) REFERENCES EMPLEADO(expediente)
);

CREATE TABLE COND_SALUD(
    id NUMERIC(4) NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    alergia BOOLEAN NOT NULL,
    descripcion VARCHAR(30),

    PRIMARY KEY(id)
);

CREATE TABLE E_C(
    fk_empleado NUMERIC(4) NOT NULL,
    fk_cond NUMERIC(4) NOT NULL,

    PRIMARY KEY(fk_empleado,fk_cond),
    FOREIGN KEY(fk_empleado) REFERENCES EMPLEADO(expediente),
    FOREIGN KEY(fk_cond) REFERENCES COND_SALUD(id)
);

/*CREATE TABLE TELEFONO(
    cod NUMERIC(4) NOT NULL,
    num NUMERIC(4) NOT NULL,
    fk_empleado NUMERIC(4),
    fk_cliente NUMERIC(4),

    PRIMARY KEY(cod,num),
    FOREIGN KEY(fk_empleado) REFERENCES EMPLEADO(expediente),
    FOREIGN KEY(fk_cliente) REFERENCES CLIENTE(id)
);*/

CREATE TABLE DETALLE_EXP(
    id NUMERIC(4) NOT NULL,
    fecha DATE NOT NULL,
    motivo VARCHAR(2) NOT NULL CONSTRAINT check_motivo check(motivo in('IN','BM','BA','AM','RE','HE')),
    fk_empleado NUMERIC(4) NOT NULL,
    descripcion VARCHAR(30),
    monto_bono NUMERIC(4,2),
    horas_extras NUMERIC(4),
    retraso NUMERIC(4),

    PRIMARY KEY(id,fk_empleado),
    FOREIGN KEY(fk_empleado) REFERENCES EMPLEADO(expediente)
);

CREATE TABLE ORGANIGRAMA(
    id NUMERIC(4) NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    tipo VARCHAR(1) NOT NULL CONSTRAINT check_tipo check(tipo in('G','S','D','A')),
    nivel NUMERIC(1) NOT NULL CONSTRAINT check_nivel check(nivel in(1,2,3,4)),
    fk_superior NUMERIC(4),
    descripcion VARCHAR(30),

    PRIMARY KEY(id),
    FOREIGN KEY(fk_superior) REFERENCES ORGANIGRAMA(id)
);

CREATE TABLE EMPLEO(
    fecha_inicio DATE NOT NULL,
    sueldo NUMERIC(4,2) NOT NULL,
    cargo VARCHAR(1) NOT NULL CONSTRAINT check_cargo check(cargo in('S','G','O','E','M','I')),
    fk_empleado NUMERIC(4) NOT NULL,
    fk_organigrama NUMERIC(4) NOT NULL,
    fecha_fin DATE,

    PRIMARY KEY(fecha_inicio,fk_empleado),
    FOREIGN KEY(fk_empleado) REFERENCES EMPLEADO(expediente),
    FOREIGN KEY(fk_organigrama) REFERENCES ORGANIGRAMA(id)
);

CREATE TABLE TURNOS_HIST(
    fecha_inicio DATE NOT NULL,
    turno NUMERIC(1) NOT NULL CONSTRAINT check_turno check(turno in(1,2,3)),
    fk_empleo DATE NOT NULL,
    fk_empleado NUMERIC(4) NOT NULL,
    fecha_fin DATE,

    PRIMARY KEY(fecha_inicio,fk_empleo,fk_empleado),
    FOREIGN KEY(fk_empleo,fk_empleado) REFERENCES EMPLEO(fecha_inicio,fk_empleado)
);

CREATE TABLE REUNION(
    id NUMERIC(4) NOT NULL,
    fecha DATE NOT NULL,
    minuta VARCHAR(30) NOT NULL,
    fk_supervisor NUMERIC(4) NOT NULL,

    PRIMARY KEY(id,fk_supervisor),
    FOREIGN KEY(fk_supervisor) REFERENCES EMPLEADO(expediente)
);

CREATE TABLE INASISTENCIA(
    fk_empleo DATE NOT NULL,
    fk_empleado NUMERIC(4) NOT NULL,
    fk_reunion NUMERIC(4) NOT NULL,
    fk_supervisor NUMERIC(4) NOT NULL,

    PRIMARY KEY(fk_empleo,fk_empleado,fk_reunion,fk_supervisor),
    FOREIGN KEY(fk_empleo,fk_empleado) REFERENCES EMPLEO(fecha_inicio,fk_empleado),
    FOREIGN KEY(fk_reunion,fk_supervisor) REFERENCES REUNION(id,fk_supervisor)
);
