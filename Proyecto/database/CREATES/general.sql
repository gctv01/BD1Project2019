/******************************************************************************************************/
/************************************************EMPLEADOS*********************************************/
/******************************************************************************************************/

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

/******************************************************************************************************/
/************************************************CATALOGO**********************************************/
/******************************************************************************************************/

CREATE TABLE Molde(
    id SERIAL NOT NULL,
    tipo character varying NOT NULL,
    tipo_plato character varying,
    forma character varying,
    tipo_taza character varying  ,
    cant_pers numeric,
    tamano character varying ,
    volumen character varying ,
    CONSTRAINT Molde_pkey PRIMARY KEY (id),
    CONSTRAINT Check_TipoPlato CHECK (tipo_plato in ('Llano', 'Hondo', 'Postre', 'Presenta', 'TazaMoka', 'Pasta')),
    CONSTRAINT Check_Forma CHECK (forma in ('Redondo', 'Ovalado', 'Cuadrado', 'Rectangular')),
    CONSTRAINT Check_TipoTaza CHECK (tipo_taza in ('CafeSp', 'CafeCp', 'TeSp', 'TeCp', 'MokaSp', 'MokaCp')),
    CONSTRAINT CheckCant_Pers CHECK (cant_pers in(2, 6)),
    CONSTRAINT Check_TipoM CHECK (tipo in ('Jarra', 'Taza', 'Bandeja', 'Ensaladera', 'Plato', 'Tetera', 'Azucarero', 'Lechera', 'Cazuela')));

CREATE TABLE Coleccion(
    id SERIAL NOT NULL,
    categoria character varying   NOT NULL,
    linea character varying   NOT NULL,
    descr character varying,
    CONSTRAINT Coleccion_pkey PRIMARY KEY (id),
    CONSTRAINT Check_Categoria CHECK (categoria in ('Clas_ele', 'Moderna', 'Country')),
    CONSTRAINT Check_Linea CHECK (linea in ('F', 'I')));

CREATE TABLE Col_Mot(
    id SERIAL NOT NULL,
    nombre character varying   NOT NULL,
    tipo character varying   NOT NULL,
    descr character varying  ,
    CONSTRAINT Motivo_pkey PRIMARY KEY (id),
    CONSTRAINT Check_Tipo CHECK (tipo in('Color', 'Motivo')));

CREATE TABLE Juego(
    id SERIAL NOT NULL,
    cant_personas numeric NOT NULL,
    nombre character varying   NOT NULL,
    descr character varying  ,
    CONSTRAINT Juego_pkey PRIMARY KEY (id),
    CONSTRAINT Check_CantPers CHECK (cant_personas in (2, 4, 6)));

CREATE TABLE Pieza(
    id SERIAL NOT NULL,
    id_Coleccion INTEGER NOT NULL,
    id_Col_Mot INTEGER NOT NULL,
    id_Molde INTEGER NOT NULL,
    descr character varying  ,
    CONSTRAINT Pieza_pkey PRIMARY KEY (id),
    CONSTRAINT FK_Col_Mot FOREIGN KEY (id_Col_Mot) REFERENCES Col_Mot (id),
    CONSTRAINT id_Coleccion FOREIGN KEY (id_Coleccion) REFERENCES Coleccion (id));

CREATE TABLE J_P
(
    id_Pieza INTEGER NOT NULL,
    id_Juego INTEGER NOT NULL,
    cantidad numeric NOT NULL,
    CONSTRAINT J_P_pkey PRIMARY KEY (id_Pieza, id_Juego),
    CONSTRAINT FK_Juego FOREIGN KEY (id_Juego) REFERENCES Juego (id),
    CONSTRAINT FK_Pieza FOREIGN KEY (id_Pieza) REFERENCES Pieza (id));

CREATE TABLE C_M
(
    id_Col_Mot INTEGER NOT NULL,
    id_Coleccion INTEGER NOT NULL,
    CONSTRAINT C_M_pkey PRIMARY KEY (id_Col_Mot, id_Coleccion),
    CONSTRAINT FK_Coleccion FOREIGN KEY (id_Coleccion) REFERENCES Coleccion (id), 
    CONSTRAINT FK_Motivo FOREIGN KEY (id_Col_Mot) REFERENCES Col_Mot (id)
);

CREATE TABLE Hist_Pieza
(
    fecha date NOT NULL,
    precio_Bs numeric NOT NULL,
    inflacion numeric NOT NULL,
    id_Pieza INTEGER NOT NULL,
    fecha_fin date,
    CONSTRAINT Hist_Pieza_pkey PRIMARY KEY (fecha, id_Pieza),
    CONSTRAINT FKPieza FOREIGN KEY (id_Pieza)  REFERENCES Pieza (id)
);

/******************************************************************************************************/
/**************************************************VENTAS**********************************************/
/******************************************************************************************************/

CREATE TABLE Cliente
(
    id SERIAL NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    pais VARCHAR(1) CONSTRAINT check_pais check(pais in('V','C','R','U')),
    
    PRIMARY KEY (id)
);

CREATE TABLE Contrato
(
    numero SERIAL NOT NULL,
    descuento NUMERIC(2) NOT NULL,
    fk_cliente INTEGER NOT NULL,

    PRIMARY KEY(numero),
    FOREIGN KEY(fk_cliente) REFERENCES cliente(id)
);


CREATE TABLE Pedido
(
    numero SERIAL NOT NULL,
    fecha_encargo DATE NOT NULL,
    fecha_entrega DATE NOT NULL,
    fk_cliente INTEGER NOT NULL,

    PRIMARY KEY(numero),
    FOREIGN KEY(fk_cliente) REFERENCES Cliente(id)
);

CREATE TABLE Factura
(
    id SERIAL NOT NULL,
    fecha_emision DATE NOT NULL,
    monto_total NUMERIC(11,2) NOT NULL,
    fk_pedido INTEGER NOT NULL,

    PRIMARY KEY(id),
    FOREIGN KEY(fk_pedido) REFERENCES Pedido(numero)
);

CREATE TABLE Detalle
(
    id SERIAL NOT NULL,
    cantidad NUMERIC NOT NULL,
    fk_pedido INTEGER NOT NULL,
    fk_pieza INTEGER,
    fk_juego INTEGER,

    PRIMARY KEY(id,fk_pedido),
    FOREIGN KEY(fk_pieza) REFERENCES pieza(id),
    FOREIGN KEY(fk_juego) REFERENCES juego(id)
);

CREATE TABLE TELEFONO(
    cod NUMERIC(7) NOT NULL,
    num NUMERIC(7) NOT NULL,
    fk_empleado INTEGER,
    fk_cliente INTEGER,

    PRIMARY KEY(cod,num),
    FOREIGN KEY(fk_empleado) REFERENCES EMPLEADO(expediente),
    FOREIGN KEY(fk_cliente) REFERENCES CLIENTE(id)
);