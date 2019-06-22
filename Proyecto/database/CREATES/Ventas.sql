CREATE TABLE EJGCliente
(
    id SERIAL NOT NULL,
    nombre character varying NOT NULL,
    pais character varying,
    CONSTRAINT Cliente_pkey PRIMARY KEY (id),
    CONSTRAINT Check_Pais CHECK (pais::text = ANY (ARRAY['VEN'::character varying, 'USA'::character varying, 'COL'::character varying, 'REPDOM'::character varying]::text[])) NOT VALID
)

CREATE TABLE EJGContrato
(
    numero SERIAL NOT NULL,
    descuento character varying NOT NULL,
    id_Cliente numeric NOT NULL,
    CONSTRAINT Contrato_pkey PRIMARY KEY (numero),
	CONSTRAINT FK_Cliente FOREIGN KEY (id_Cliente)
        REFERENCES Cliente (id) 
        
   
)


CREATE TABLE EJGPedido
(
    numero SERIAL NOT NULL,
    fecha_encargo date NOT NULL,
    echa_entrega date NOT NULL,
   fecha_emision date NOT NULL,
    CONSTRAINT Pedido_pkey PRIMARY KEY (numero)
	
   
)

CREATE TABLE EJGFactura
(
    
    id SERIAL NOT NULL,
    Fk_Pedido numeric NOT NULL,
	monto_total numeric NOT NULL,
    fechaemision date NOT NULL,
    CONSTRAINT Factura_pkey PRIMARY KEY (id),
    CONSTRAINT FK_Pedido FOREIGN KEY (Fk_Pedido)
        REFERENCES Pedido (numero) 

CREATE TABLE Detalle
(
    
    cantidad SERIAL NOT NULL,
    id_Pieza numeric NOT NULL,
	id_Juego integer NOT NULL,
    CONSTRAINT Detalle_pkey PRIMARY KEY (id_Pieza, id_Juego),
    CONSTRAINT FK_Juego FOREIGN KEY (id_Juego)
        REFERENCES Juego (id) 
	CONSTRAINT FK_Pieza FOREIGN KEY (id_Juego)
        REFERENCES Pieza (id)
        
)
