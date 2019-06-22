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
    CONSTRAINT FK_Motivo FOREIGN KEY (id_Col_Mot) REFERENCES Col_Mot (id));

CREATE TABLE Hist_Pieza
(
    fecha date NOT NULL,
    precio_Bs numeric NOT NULL,
    inflacion numeric NOT NULL,
    id_Pieza INTEGER NOT NULL,
    fecha_fin date,
    CONSTRAINT Hist_Pieza_pkey PRIMARY KEY (fecha, id_Pieza),
    CONSTRAINT FKPieza FOREIGN KEY (id_Pieza)  REFERENCES Pieza (id));

