CREATE TABLE Molde
(
    id SERIAL NOT NULL,
    tipo character varying COLLATE pg_catalog."default" NOT NULL,
    tipo_plato character varying COLLATE pg_catalog."default",
    forma character varying COLLATE pg_catalog."default",
    tipo_taza character varying COLLATE pg_catalog."default",
    cant_pers numeric,
    tamano character varying COLLATE pg_catalog."default",
    volumen character varying COLLATE pg_catalog."default",
    CONSTRAINT Molde_pkey PRIMARY KEY (id),
    CONSTRAINT Check_TipoPlato CHECK (tipo_plato::text = ANY (ARRAY['Llano'::character varying::text, 'Hondo'::character varying::text, 'Postre'::character varying::text, 'Presenta'::character varying::text, 'TazaMoka'::character varying::text, 'Pasta'::character varying::text])),
    CONSTRAINT Check_Forma CHECK (forma::text = ANY (ARRAY['Redondo'::character varying::text, 'Ovalado'::character varying::text, 'Cuadrado'::character varying::text, 'Rectangular'::character varying::text])),
    CONSTRAINT Check_TipoTaza CHECK (tipo_taza::text = ANY (ARRAY['CafeSp'::character varying::text, 'CafeCP'::character varying::text, 'TeSp'::character varying::text, 'TeCp'::character varying::text, 'MpkaSp'::character varying::text, 'MokaCp'::character varying::text])),
    CONSTRAINT CheckCant_Pers CHECK (cant_pers = ANY (ARRAY[2::numeric, 6::numeric])),
    CONSTRAINT Check_TipoM CHECK (tipo::text = ANY (ARRAY['Jarra'::character varying, 'Taza'::character varying, 'Bandeja'::character varying, 'Ensaladera'::character varying, 'Plato'::character varying, 'Tetera'::character varying, 'Azucarero'::character varying, 'Lechera'::character varying, 'Cazuela'::character varying]::text[])) NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

CREATE TABLE Coleccion
(
    id SERIAL NOT NULL,
    categoria character varying COLLATE pg_catalog."default" NOT NULL,
    linea character varying COLLATE pg_catalog."default" NOT NULL,
    descr character varying COLLATE pg_catalog."default",
    CONSTRAINT Coleccion_pkey PRIMARY KEY (id),
    CONSTRAINT Check_Categoria CHECK (categoria::text = ANY (ARRAY['Clas_ele'::character varying, 'Moderna'::character varying, 'Country'::character varying]::text[])) NOT VALID,
    CONSTRAINT Check_Linea CHECK (linea::text = ANY (ARRAY['F'::character varying, 'I'::character varying]::text[])) NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

CREATE TABLE Col_Mot
(
    id SERIAL NOT NULL,
    nombre character varying COLLATE pg_catalog."default" NOT NULL,
    tipo character varying COLLATE pg_catalog."default" NOT NULL,
    descr character varying COLLATE pg_catalog."default",
    CONSTRAINT Motivo_pkey PRIMARY KEY (id),
    CONSTRAINT Check_Tipo CHECK (tipo::text = ANY (ARRAY['Color'::character varying, 'Motivo'::character varying]::text[])) NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

-- Table: public."Juego"

-- DROP TABLE public."Juego";

CREATE TABLE Juego
(
    id SERIAL NOT NULL,
    cant_personas numeric NOT NULL,
    nombre character varying COLLATE pg_catalog."default" NOT NULL,
    descr character varying COLLATE pg_catalog."default",
    CONSTRAINT Juego_pkey PRIMARY KEY (id),
    CONSTRAINT Check_CantPers CHECK (cant_personas = ANY (ARRAY[2::numeric, 4::numeric, 6::numeric])) NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

-- Table: public."Pieza"

-- DROP TABLE public."Pieza";

CREATE TABLE Pieza
(
    id SERIAL NOT NULL,
    id_Coleccion INTEGER NOT NULL,
    id_Col_Mot INTEGER NOT NULL,
    id_Molde INTEGER NOT NULL,
    descr character varying COLLATE pg_catalog."default",
    CONSTRAINT Pieza_pkey PRIMARY KEY (id),
    CONSTRAINT FK_Col_Mot FOREIGN KEY (id_Col_Mot)
        REFERENCES public.Col_Mot (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT id_Coleccion FOREIGN KEY (id_Coleccion)
        REFERENCES public.Coleccion (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

-- Index: fki_FKMotivo

-- DROP INDEX public."fki_FKMotivo";

CREATE INDEX fki_FKMotivo
    ON public.Pieza USING btree
    (id_Col_Mot)
    TABLESPACE pg_default;

-- Index: fki_FK_Molde

-- DROP INDEX public."fki_FK_Molde";

CREATE INDEX fki_FK_Molde
    ON public.Pieza USING btree
    (id_Molde)
    TABLESPACE pg_default;

-- Index: fki_id_Coleccion

-- DROP INDEX public."fki_id_Coleccion";

CREATE INDEX fki_id_Coleccion
    ON public.Pieza USING btree
    (id_Coleccion)
    TABLESPACE pg_default;

-- Table: public."J_P"

-- DROP TABLE public."J_P";

CREATE TABLE J_P
(
    id SERIAL NOT NULL,
    id_Pieza INTEGER NOT NULL,
    id_Juego INTEGER NOT NULL,
    cantidad numeric NOT NULL,
    CONSTRAINT J_P_pkey PRIMARY KEY (id, id_Pieza, id_Juego),
    CONSTRAINT FK_Juego FOREIGN KEY (id_Juego)
        REFERENCES public.Juego (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_Pieza FOREIGN KEY (id_Pieza)
        REFERENCES public.Pieza (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

-- Index: fki_FK_Juego

-- DROP INDEX public."fki_FK_Juego";

CREATE INDEX fki_FK_Juego
    ON public.J_P USING btree
    (id_Juego)
    TABLESPACE pg_default;

-- Index: fki_FK_Pieza

-- DROP INDEX public."fki_FK_Pieza";

CREATE INDEX fki_FK_Pieza
    ON public.J_P USING btree
    (id_Pieza);

-- Table: public."C_M"

-- DROP TABLE public."C_M";

CREATE TABLE public.C_M
(
    id SERIAL NOT NULL,
    id_Col_Mot INTEGER NOT NULL,
    id_Coleccion INTEGER NOT NULL,
    CONSTRAINT C_M_pkey PRIMARY KEY (id, id_Col_Mot, id_Coleccion),
    CONSTRAINT FK_Coleccion FOREIGN KEY (id_Coleccion)
        REFERENCES public.Coleccion (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT FK_Motivo FOREIGN KEY (id_Col_Mot)
        REFERENCES public.Col_Mot (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

-- Index: fki_FK_Coleccion

-- DROP INDEX public."fki_FK_Coleccion";

CREATE INDEX fki_FK_Coleccion
    ON public.C_M USING btree
    (id_Coleccion)
    TABLESPACE pg_default;

-- Index: fki_FK_Motivo

-- DROP INDEX public."fki_FK_Motivo";

CREATE INDEX fki_FK_Motivo
    ON public.C_M USING btree
    (id_Col_Mot)
    TABLESPACE pg_default;

-- Table: public."Hist_Pieza"

-- DROP TABLE public."Hist_Pieza";

CREATE TABLE public.Hist_Pieza
(
    fecha date NOT NULL,
    precio_Bs numeric NOT NULL,
    inflacion numeric NOT NULL,
    id_Pieza INTEGER NOT NULL,
    fecha_fin date,
    CONSTRAINT Hist_Pieza_pkey PRIMARY KEY (fecha, id_Pieza),
    CONSTRAINT FKPieza FOREIGN KEY (id_Pieza)
        REFERENCES public.Pieza (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

-- Index: fki_FKPieza

-- DROP INDEX public."fki_FKPieza";

CREATE INDEX fki_FKPieza
    ON public.Hist_Pieza USING btree
    (id_Pieza)
    TABLESPACE pg_default;