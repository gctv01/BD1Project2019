CREATE TABLE public."Cliente"
(
    id numeric NOT NULL,
    “nombre“ character varying COLLATE pg_catalog."default" NOT NULL,
    “pais” character varying COLLATE pg_catalog."default",
    CONSTRAINT "Cliente_pkey" PRIMARY KEY (id),
    CONSTRAINT "Check_Pais" CHECK (pais::text = ANY (ARRAY['VEN'::character varying, 'USA'::character varying, 'COL'::character varying, 'REPDOM'::character varying]::text[])) NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

CREATE TABLE public."Contrato"
(
    "numero" numeric NOT NULL,
    "descuento" character varying COLLATE pg_catalog."default" NOT NULL,
    "id_Cliente" numeric NOT NULL,
    CONSTRAINT "Contrato_pkey" PRIMARY KEY (numero),
	CONSTRAINT "FK_Cliente" FOREIGN KEY ("id_Cliente")
        REFERENCES public."Cliente" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
   
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

CREATE TABLE public."Pedido"
(
    "numero" numeric NOT NULL,
    "fecha_encargo" date NOT NULL,
    "fecha_entrega" date NOT NULL,
	"fecha_emision" date NOT NULL,
    CONSTRAINT "Pedido_pkey" PRIMARY KEY (numero)
	
   
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

CREATE TABLE public."Factura"
(
    
    id numeric NOT NULL,
    "Fk_Pedido" numeric NOT NULL,
	"monto_total" numeric NOT NULL,
    "fechaemision" date NOT NULL,
    CONSTRAINT "Factura_pkey" PRIMARY KEY (id),
    CONSTRAINT "FK_Pedido" FOREIGN KEY ("Fk_Pedido")
        REFERENCES public."Pedido" ("numero") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE public."Detalle"
(
    
    "cantidad" numeric NOT NULL,
    "id_Pieza" numeric NOT NULL,
	"id_Juego" numeric NOT NULL,
    CONSTRAINT "Detalle_pkey" PRIMARY KEY ("id_Pieza", "id_Juego"),
    CONSTRAINT "FK_Juego" FOREIGN KEY ("id_Juego")
        REFERENCES public."Juego" (id) MATCH SIMPLE
        ON UPDATE NO ACTION,
	CONSTRAINT "FK_Pieza" FOREIGN KEY ("id_Juego")
        REFERENCES public."Pieza" (id) MATCH SIMPLE
        ON UPDATE NO ACTION
)