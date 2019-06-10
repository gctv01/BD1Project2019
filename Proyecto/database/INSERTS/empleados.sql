INSERT INTO EMPLEADO (di,nombre,apellido,apellido2,fecha_nacimiento,genero,tipo_sangre,titulo,nombre2,fk_supervisor)
VALUES (27107288,'ezequiel','montero','pantano','05-29-1998','M','A-','B','jose',
(SELECT expediente FROM EMPLEADO WHERE di = 27107288)
);