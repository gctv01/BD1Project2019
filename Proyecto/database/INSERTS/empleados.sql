INSERT INTO EMPLEADO (di,nombre,apellido,apellido2,fecha_nacimiento,genero,tipo_sangre,titulo,nombre2,fk_supervisor)
VALUES (111,'ezequiel','montero','pantano','05-29-1998','M','A-','B','jose',
(SELECT expediente FROM EMPLEADO WHERE di = null)
);

INSERT INTO EMPLEADO (di,nombre,apellido,apellido2,fecha_nacimiento,genero,tipo_sangre,titulo,nombre2,fk_supervisor)
VALUES (222,'laura','rodrigues','zambrano','05-29-1960','F','AB-','Q','maria',
(SELECT expediente FROM EMPLEADO WHERE di = 111)
);

INSERT INTO EMPLEADO (di,nombre,apellido,apellido2,fecha_nacimiento,genero,tipo_sangre,titulo,nombre2,fk_supervisor)
VALUES (333,'arturo','fraga','arteaga','06-25-1913','T','O-','P','miguel',
(SELECT expediente FROM EMPLEADO WHERE di = 111)
);

INSERT INTO EMPLEADO (di,nombre,apellido,apellido2,fecha_nacimiento,genero,tipo_sangre,titulo,nombre2,fk_supervisor)
VALUES (444,'maria','adueza','garcia','12-29-1980','M','A-','I','jose',
(SELECT expediente FROM EMPLEADO WHERE di = null)
);

INSERT INTO EMPLEADO (di,nombre,apellido,apellido2,fecha_nacimiento,genero,tipo_sangre,titulo,nombre2,fk_supervisor)
VALUES (555,'alex','landa','risuti','08-15-1955','M','O+','B','miguel',
(SELECT expediente FROM EMPLEADO WHERE di = 444)
);


/*ORGANIGRAMAS*/

/*gerencias*/
INSERT INTO ORGANIGRAMA (id,nombre,tipo,nivel,fk_superior,descripcion)
VALUES (1,'general','G',1,null,null);

INSERT INTO ORGANIGRAMA (id,nombre,tipo,nivel,fk_superior,descripcion)
VALUES (2,'planta','G',2,1,null);

INSERT INTO ORGANIGRAMA (id,nombre,tipo,nivel,fk_superior,descripcion)
VALUES (3,'tecnica','G',3,2,null);

/*almacenes*/

INSERT INTO ORGANIGRAMA (id,nombre,tipo,nivel,fk_superior,descripcion)
VALUES (4,'insumos','A',3,2,null);

INSERT INTO ORGANIGRAMA (id,nombre,tipo,nivel,fk_superior,descripcion)
VALUES (5,'producto terminado','A',3,2,null);

/*secciones*/

INSERT INTO ORGANIGRAMA (id,nombre,tipo,nivel,fk_superior,descripcion)
VALUES (6,'control de calidad','S',4,3,null);

INSERT INTO ORGANIGRAMA (id,nombre,tipo,nivel,fk_superior,descripcion)
VALUES (7,'mantenimiento','S',4,3,null);

/*departamentos*/

INSERT INTO ORGANIGRAMA (id,nombre,tipo,nivel,fk_superior,descripcion)
VALUES (8,'seleccion','D',4,3,null);

INSERT INTO ORGANIGRAMA (id,nombre,tipo,nivel,fk_superior,descripcion)
VALUES (9,'esmaltacion decoracion','D',4,3,null);

INSERT INTO ORGANIGRAMA (id,nombre,tipo,nivel,fk_superior,descripcion)
VALUES (10,'hornos','D',4,3,null);

INSERT INTO ORGANIGRAMA (id,nombre,tipo,nivel,fk_superior,descripcion)
VALUES (11,'colado refinado','D',4,3,null);

INSERT INTO ORGANIGRAMA (id,nombre,tipo,nivel,fk_superior,descripcion)
VALUES (12,'yeseria','D',4,3,null);

INSERT INTO ORGANIGRAMA (id,nombre,tipo,nivel,fk_superior,descripcion)
VALUES (13,'rotomoldeo','D',4,3,null);

INSERT INTO ORGANIGRAMA (id,nombre,tipo,nivel,fk_superior,descripcion)
VALUES (14,'preparacion pasta','D',4,3,null);