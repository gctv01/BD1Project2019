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