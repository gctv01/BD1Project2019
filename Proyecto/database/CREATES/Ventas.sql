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
    fecha DATE NOT NULL,

    PRIMARY KEY(numero,fk_cliente),
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
