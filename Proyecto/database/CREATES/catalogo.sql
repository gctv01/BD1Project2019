-- Database: ProyectoBases2019

-- DROP DATABASE "ProyectoBases2019";

CREATE DATABASE "ProyectoBases2019"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Venezuela.1252'
    LC_CTYPE = 'Spanish_Venezuela.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
-- Table: public."Juego"

-- DROP TABLE public."Juego";

CREATE TABLE public."Juego"
(
    id numeric NOT NULL,
    cant_personas numeric NOT NULL,
    nombre character varying COLLATE pg_catalog."default" NOT NULL,
    "desc" character varying COLLATE pg_catalog."default",
    CONSTRAINT "Juego_pkey" PRIMARY KEY (id),
    CONSTRAINT "Check_CantPers" CHECK (cant_personas = ANY (ARRAY[2::numeric, 4::numeric, 6::numeric])) NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."Juego"
    OWNER to postgres;

-- Table: public."Coleccion"

-- DROP TABLE public."Coleccion";

CREATE TABLE public."Coleccion"
(
    id numeric NOT NULL,
    categoria character varying COLLATE pg_catalog."default" NOT NULL,
    linea character varying COLLATE pg_catalog."default" NOT NULL,
    "desc" character varying COLLATE pg_catalog."default",
    CONSTRAINT "Coleccion_pkey" PRIMARY KEY (id),
    CONSTRAINT "Check_Categoria" CHECK (categoria::text = ANY (ARRAY['Clas_ele'::character varying, 'Moderna'::character varying, 'Country'::character varying]::text[])) NOT VALID,
    CONSTRAINT "Check_Linea" CHECK (linea::text = ANY (ARRAY['F'::character varying, 'I'::character varying]::text[])) NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."Coleccion"
    OWNER to postgres;

-- Table: public."Molde"

-- DROP TABLE public."Molde";

CREATE TABLE public."Molde"
(
    id numeric NOT NULL,
    tipo character varying COLLATE pg_catalog."default" NOT NULL,
    tipo_plato character varying COLLATE pg_catalog."default",
    forma character varying COLLATE pg_catalog."default",
    tamano numeric,
    tipo_taza character varying COLLATE pg_catalog."default",
    volumen numeric,
    cant_pers numeric,
    CONSTRAINT "Molde_pkey" PRIMARY KEY (id),
    CONSTRAINT "Check_TipoM" CHECK (tipo::text = ANY (ARRAY['Jarra'::character varying, 'Plata'::character varying, 'Tetera'::character varying, 'Azucarero'::character varying, 'Lechera'::character varying, 'Cazuela'::character varying]::text[])) NOT VALID,
    CONSTRAINT "Check_TipoPlato" CHECK (tipo_plato::text = ANY (ARRAY['Llano'::character varying, 'Hondo'::character varying, 'Postre'::character varying, 'Presenta'::character varying, 'TazaMoka'::character varying, 'Pasta'::character varying]::text[])) NOT VALID,
    CONSTRAINT "Check_Forma" CHECK (forma::text = ANY (ARRAY['Redondo'::character varying, 'Ovalado'::character varying, 'Cuadrado'::character varying, 'Rectangular'::character varying]::text[])) NOT VALID,
    CONSTRAINT "Check_TipoTaza" CHECK (tipo_taza::text = ANY (ARRAY['CafeSp'::character varying, 'CafeCP'::character varying, 'TeSp'::character varying, 'TeCp'::character varying, 'MpkaSp'::character varying, 'MokaCp'::character varying]::text[])) NOT VALID,
    CONSTRAINT "CheckCant_Pers" CHECK (cant_pers = ANY (ARRAY[2::numeric, 6::numeric])) NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."Molde"
    OWNER to postgres;

-- Table: public."Col_Mot"

-- DROP TABLE public."Col_Mot";

CREATE TABLE public."Col_Mot"
(
    id numeric NOT NULL,
    nombre character varying COLLATE pg_catalog."default" NOT NULL,
    tipo character varying COLLATE pg_catalog."default" NOT NULL,
    "desc" character varying COLLATE pg_catalog."default",
    CONSTRAINT "Motivo_pkey" PRIMARY KEY (id),
    CONSTRAINT "Check_Tipo" CHECK (tipo::text = ANY (ARRAY['Color'::character varying, 'Motivo'::character varying]::text[])) NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."Col_Mot"
    OWNER to postgres;

-- Table: public."Pieza"

-- DROP TABLE public."Pieza";

CREATE TABLE public."Pieza"
(
    id numeric NOT NULL,
    "id_Coleccion" numeric NOT NULL,
    "id_Motivo" numeric NOT NULL,
    "id_Molde" numeric NOT NULL,
    "desc" character varying COLLATE pg_catalog."default",
    CONSTRAINT "Pieza_pkey" PRIMARY KEY (id),
    CONSTRAINT "FK_Col_Mot" FOREIGN KEY ("id_Motivo")
        REFERENCES public."Col_Mot" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_Molde" FOREIGN KEY ("id_Molde")
        REFERENCES public."Molde" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "id_Coleccion" FOREIGN KEY ("id_Coleccion")
        REFERENCES public."Coleccion" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."Pieza"
    OWNER to postgres;

-- Index: fki_FKMotivo

-- DROP INDEX public."fki_FKMotivo";

CREATE INDEX "fki_FKMotivo"
    ON public."Pieza" USING btree
    ("id_Motivo")
    TABLESPACE pg_default;

-- Index: fki_FK_Molde

-- DROP INDEX public."fki_FK_Molde";

CREATE INDEX "fki_FK_Molde"
    ON public."Pieza" USING btree
    ("id_Molde")
    TABLESPACE pg_default;

-- Index: fki_id_Coleccion

-- DROP INDEX public."fki_id_Coleccion";

CREATE INDEX "fki_id_Coleccion"
    ON public."Pieza" USING btree
    ("id_Coleccion")
    TABLESPACE pg_default;

-- Table: public."J_P"

-- DROP TABLE public."J_P";

CREATE TABLE public."J_P"
(
    id numeric NOT NULL,
    "id_Pieza" numeric NOT NULL,
    "id_Juego" numeric NOT NULL,
    cantidad numeric NOT NULL,
    CONSTRAINT "J_P_pkey" PRIMARY KEY (id, "id_Pieza", "id_Juego"),
    CONSTRAINT "FK_Juego" FOREIGN KEY ("id_Juego")
        REFERENCES public."Juego" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_Pieza" FOREIGN KEY ("id_Pieza")
        REFERENCES public."Pieza" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."J_P"
    OWNER to postgres;

-- Index: fki_FK_Juego

-- DROP INDEX public."fki_FK_Juego";

CREATE INDEX "fki_FK_Juego"
    ON public."J_P" USING btree
    ("id_Juego")
    TABLESPACE pg_default;

-- Index: fki_FK_Pieza

-- DROP INDEX public."fki_FK_Pieza";

CREATE INDEX "fki_FK_Pieza"
    ON public."J_P" USING btree
    ("id_Pieza")
    TABLESPACE pg_default;

-- Table: public."C_M"

-- DROP TABLE public."C_M";

CREATE TABLE public."C_M"
(
    id numeric NOT NULL,
    "id_Motivo" numeric NOT NULL,
    "id_Coleccion" numeric NOT NULL,
    CONSTRAINT "C_M_pkey" PRIMARY KEY (id, "id_Motivo", "id_Coleccion"),
    CONSTRAINT "FK_Coleccion" FOREIGN KEY ("id_Coleccion")
        REFERENCES public."Coleccion" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT "FK_Motivo" FOREIGN KEY ("id_Motivo")
        REFERENCES public."Col_Mot" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."C_M"
    OWNER to postgres;

-- Index: fki_FK_Coleccion

-- DROP INDEX public."fki_FK_Coleccion";

CREATE INDEX "fki_FK_Coleccion"
    ON public."C_M" USING btree
    ("id_Coleccion")
    TABLESPACE pg_default;

-- Index: fki_FK_Motivo

-- DROP INDEX public."fki_FK_Motivo";

CREATE INDEX "fki_FK_Motivo"
    ON public."C_M" USING btree
    ("id_Motivo")
    TABLESPACE pg_default;

-- Table: public."Hist_Pieza"

-- DROP TABLE public."Hist_Pieza";

CREATE TABLE public."Hist_Pieza"
(
    fecha date NOT NULL,
    "precio_Bs" numeric NOT NULL,
    inflacion numeric NOT NULL,
    "id_Pieza" numeric NOT NULL,
    fecha_fin date,
    CONSTRAINT "Hist_Pieza_pkey" PRIMARY KEY (fecha, "id_Pieza"),
    CONSTRAINT "FKPieza" FOREIGN KEY ("id_Pieza")
        REFERENCES public."Pieza" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public."Hist_Pieza"
    OWNER to postgres;

-- Index: fki_FKPieza

-- DROP INDEX public."fki_FKPieza";

CREATE INDEX "fki_FKPieza"
    ON public."Hist_Pieza" USING btree
    ("id_Pieza")
    TABLESPACE pg_default;