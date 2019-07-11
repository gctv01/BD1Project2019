/******************************************************************************************************/
/************************************************EMPLEADOS*********************************************/
/******************************************************************************************************/

/*******************************************EMPLEADOS*/

insert into empleado (expediente, di, nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2, fk_supervisor) values (1, 23659721, 'Amelia', 'Valdes', 'Schlagman', '12/31/1974', 'F', 'O+', 'M', 'Andriette', null);
insert into empleado (expediente, di, nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2, fk_supervisor) values (2, 21455630, 'Arvie', 'Burgher', 'Thay', '3/17/1979', 'M', 'A-', 'G', null, null);
insert into empleado (expediente, di, nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2, fk_supervisor) values (3, 22830453, 'Monah', 'Moyer', 'Goodsal', '3/5/1992', 'F', 'O+', 'B', 'Sharron', 2);
insert into empleado (expediente, di, nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2, fk_supervisor) values (4, 22889732, 'Rudie', 'McDade', 'Neubigin', '12/20/1972', 'M', 'A+', 'P', 'Tommy', null);
insert into empleado (expediente, di, nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2, fk_supervisor) values (5, 23427124, 'Rhody', 'Belcher', 'Wyrall', '6/7/1964', 'F', 'O+', 'I', 'Vale', null);
insert into empleado (expediente, di, nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2, fk_supervisor) values (6, 10715414, 'Leanna', 'McGeown', 'Mechi', '10/2/1973', 'F', 'AB-', 'P', null, null);
insert into empleado (expediente, di, nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2, fk_supervisor) values (7, 5016453, 'Ingrid', 'Mussalli', 'Balle', '7/2/1976', 'F', 'AB+', 'M', 'Jillana', null);
insert into empleado (expediente, di, nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2, fk_supervisor) values (8, 9922256, 'Stan', 'Robinette', 'Buist', '1/12/1977', 'M', 'A+', 'I', 'Ravid', null);
insert into empleado (expediente, di, nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2, fk_supervisor) values (9, 6225853, 'Shelden', 'Kerwood', 'Dederick', '3/22/1984', 'M', 'A+', 'Q', 'Wakefield', null);
insert into empleado (expediente, di, nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2, fk_supervisor) values (10, 14640126, 'Vi', 'Wink', 'Molen', '4/6/1984', 'F', 'A-', 'B', 'Victoria', 9);

ALTER SEQUENCE empleado_expediente_seq RESTART WITH 11 INCREMENT BY 1;

/*************************************************COND_SALUD*/

insert into cond_salud (id, nombre, alergia, descripcion) values (1, 'et', true, 'Sed ante. Vivamus tortor. Duis mattis egestas metus.');
insert into cond_salud (id, nombre, alergia, descripcion) values (2, 'ultrices', true, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.');
insert into cond_salud (id, nombre, alergia, descripcion) values (3, 'tellus', false, null);
insert into cond_salud (id, nombre, alergia, descripcion) values (4, 'pretium', true, 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet.');
insert into cond_salud (id, nombre, alergia, descripcion) values (5, 'gravida', true, 'Nullam sit amet turpis elementum ligula vehicula consequat.');
insert into cond_salud (id, nombre, alergia, descripcion) values (6, 'id', false, 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy.');
insert into cond_salud (id, nombre, alergia, descripcion) values (7, 'lorem', false, 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.');
insert into cond_salud (id, nombre, alergia, descripcion) values (8, 'volutpat', false, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla.');
insert into cond_salud (id, nombre, alergia, descripcion) values (9, 'condimentum', true, 'Curabitur in libero ut massa volutpat convallis.');
insert into cond_salud (id, nombre, alergia, descripcion) values (10, 'massa', false, 'Aenean fermentum. Donec ut mauris eget massa tempor convallis.');

ALTER SEQUENCE cond_salud_id_seq RESTART WITH 11 INCREMENT BY 1;

/**************************************************E_C*/

insert into e_c (fk_empleado, fk_cond) values (7, 7);
insert into e_c (fk_empleado, fk_cond) values (4, 4);
insert into e_c (fk_empleado, fk_cond) values (7, 10);
insert into e_c (fk_empleado, fk_cond) values (3, 5);
insert into e_c (fk_empleado, fk_cond) values (9, 4);
insert into e_c (fk_empleado, fk_cond) values (10, 5);
insert into e_c (fk_empleado, fk_cond) values (9, 3);
insert into e_c (fk_empleado, fk_cond) values (8, 5);
insert into e_c (fk_empleado, fk_cond) values (4, 10);
insert into e_c (fk_empleado, fk_cond) values (4, 1);

/**************************************************DETALLE_EXP*/

insert into detalle_exp (id, fecha, motivo, fk_empleado, descripcion, monto_bono, horas_extras, retraso) values (1, '4/7/1995', 'IN', 7, 'In hac habitasse platea dictumst.', null, null, null);
insert into detalle_exp (id, fecha, motivo, fk_empleado, descripcion, monto_bono, horas_extras, retraso) values (2, '7/14/2011', 'AM', 6, 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', null, null, null);
insert into detalle_exp (id, fecha, motivo, fk_empleado, descripcion, monto_bono, horas_extras, retraso) values (3, '11/23/2018', 'RE', 1, 'Etiam vel augue. Vestibulum rutrum rutrum neque.', null, null, 20);
insert into detalle_exp (id, fecha, motivo, fk_empleado, descripcion, monto_bono, horas_extras, retraso) values (4, '2/16/2000', 'RE', 3, 'Proin eu mi.', null, null, 12);
insert into detalle_exp (id, fecha, motivo, fk_empleado, descripcion, monto_bono, horas_extras, retraso) values (5, '5/10/1991', 'HE', 1, 'In quis justo. Maecenas rhoncus aliquam lacus.', null, 10, null);
insert into detalle_exp (id, fecha, motivo, fk_empleado, descripcion, monto_bono, horas_extras, retraso) values (6, '11/13/1999', 'HE', 6, 'In sagittis dui vel nisl.', null, 7, null);
insert into detalle_exp (id, fecha, motivo, fk_empleado, descripcion, monto_bono, horas_extras, retraso) values (7, '6/2/2012', 'IN', 7, 'Maecenas ut massa quis augue luctus tincidunt.', null, null, null);
insert into detalle_exp (id, fecha, motivo, fk_empleado, descripcion, monto_bono, horas_extras, retraso) values (8, '10/14/1989', 'BM', 2, null, '7104521.79', null, null);
insert into detalle_exp (id, fecha, motivo, fk_empleado, descripcion, monto_bono, horas_extras, retraso) values (9, '4/8/2006', 'BA', 7, null, '6125607.68', null, null);
insert into detalle_exp (id, fecha, motivo, fk_empleado, descripcion, monto_bono, horas_extras, retraso) values (10, '3/25/1991', 'AM', 9, 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', null, null, null);

ALTER SEQUENCE detalle_exp_id_seq RESTART WITH 11 INCREMENT BY 1;

/************************************************ORGANIGRAMAS*/

/*gerencias*/
insert into organigrama (id,nombre,tipo,nivel,fk_superior,descripcion) values (1,'general','G',1,null,null);
insert into organigrama (id,nombre,tipo,nivel,fk_superior,descripcion) values (2,'planta','G',2,1,null);
insert into organigrama (id,nombre,tipo,nivel,fk_superior,descripcion) values (3,'tecnica','G',3,2,null);

/*almacenes*/

insert into organigrama (id,nombre,tipo,nivel,fk_superior,descripcion) values (4,'insumos','A',3,2,null);
insert into organigrama (id,nombre,tipo,nivel,fk_superior,descripcion) values (5,'producto terminado','A',3,2,null);

/*secciones*/

insert into organigrama (id,nombre,tipo,nivel,fk_superior,descripcion) values (6,'control de calidad','S',4,3,null);
insert into organigrama (id,nombre,tipo,nivel,fk_superior,descripcion) values (7,'mantenimiento','S',4,3,null);

/*departamentos*/

insert into organigrama (id,nombre,tipo,nivel,fk_superior,descripcion) values (8,'seleccion','D',4,3,null);
insert into organigrama (id,nombre,tipo,nivel,fk_superior,descripcion) values (9,'esmaltacion decoracion','D',4,3,null);
insert into organigrama (id,nombre,tipo,nivel,fk_superior,descripcion) values (10,'hornos','D',4,3,null);
insert into organigrama (id,nombre,tipo,nivel,fk_superior,descripcion) values (11,'colado refinado','D',4,3,null);
insert into organigrama (id,nombre,tipo,nivel,fk_superior,descripcion) values (12,'yeseria','D',4,3,null);
insert into organigrama (id,nombre,tipo,nivel,fk_superior,descripcion) values (13,'rotomoldeo','D',4,3,null);
insert into organigrama (id,nombre,tipo,nivel,fk_superior,descripcion) values (14,'preparacion pasta','D',4,3,null);

ALTER SEQUENCE organigrama_id_seq RESTART WITH 11 INCREMENT BY 1;

/********************************************EMPLEO*/

insert into empleo (fecha_inicio, sueldo, cargo, fk_empleado, fk_organigrama, fecha_fin) values ('6/28/2012', '2977400.31', 'G', 1, 1, null);
insert into empleo (fecha_inicio, sueldo, cargo, fk_empleado, fk_organigrama, fecha_fin) values ('12/2/2006', '5526298.97', 'G', 2, 2,  null);
insert into empleo (fecha_inicio, sueldo, cargo, fk_empleado, fk_organigrama, fecha_fin) values ('12/13/2009', '5892281.18', 'S', 3, 2, null);
insert into empleo (fecha_inicio, sueldo, cargo, fk_empleado, fk_organigrama, fecha_fin) values ('5/15/2003', '2036050.15', 'G', 4, 3, null);
insert into empleo (fecha_inicio, sueldo, cargo, fk_empleado, fk_organigrama, fecha_fin) values ('3/20/2015', '4524577.75', 'O', 5, 4, null);
insert into empleo (fecha_inicio, sueldo, cargo, fk_empleado, fk_organigrama, fecha_fin) values ('3/6/1997', '3141089.92', 'O', 6, 5, null);
insert into empleo (fecha_inicio, sueldo, cargo, fk_empleado, fk_organigrama, fecha_fin) values ('1/25/2010', '4145582.92', 'I', 7, 6, null);
insert into empleo (fecha_inicio, sueldo, cargo, fk_empleado, fk_organigrama, fecha_fin) values ('2/2/2000', '3522615.04', 'E', 8, 7, null);
insert into empleo (fecha_inicio, sueldo, cargo, fk_empleado, fk_organigrama, fecha_fin) values ('2/7/2005', '776010.81', 'O', 9, 10, null);
insert into empleo (fecha_inicio, sueldo, cargo, fk_empleado, fk_organigrama, fecha_fin) values ('7/3/2002', '3694151.79', 'O', 10, 10, null);

/********************************************TURNOS_HIST*/

insert into turnos_hist (fecha_inicio, turno, fk_empleo, fk_empleado, fecha_fin) values ('1/19/1990', 1, '2/7/2005', 9, '2/8/1992');
insert into turnos_hist (fecha_inicio, turno, fk_empleo, fk_empleado, fecha_fin) values ('2/8/1992', 2, '2/7/2005', 9, '2/25/1995');
insert into turnos_hist (fecha_inicio, turno, fk_empleo, fk_empleado, fecha_fin) values ('2/25/1995', 3, '2/7/2005', 9, '10/22/1998');
insert into turnos_hist (fecha_inicio, turno, fk_empleo, fk_empleado, fecha_fin) values ('10/22/1998', 1, '2/7/2005', 9, '9/28/2000');
insert into turnos_hist (fecha_inicio, turno, fk_empleo, fk_empleado, fecha_fin) values ('9/28/2000', 2, '2/7/2005', 9, null);
insert into turnos_hist (fecha_inicio, turno, fk_empleo, fk_empleado, fecha_fin) values ('2/20/1997', 1, '7/3/2002', 10, '8/15/2000');
insert into turnos_hist (fecha_inicio, turno, fk_empleo, fk_empleado, fecha_fin) values ('8/15/2000', 2, '7/3/2002', 10, '4/3/2002');
insert into turnos_hist (fecha_inicio, turno, fk_empleo, fk_empleado, fecha_fin) values ('4/3/2002', 3, '7/3/2002', 10, '6/21/2004');
insert into turnos_hist (fecha_inicio, turno, fk_empleo, fk_empleado, fecha_fin) values ('6/21/2004', 1, '7/3/2002', 10, '12/27/2010');
insert into turnos_hist (fecha_inicio, turno, fk_empleo, fk_empleado, fecha_fin) values ('12/27/2010', 2, '7/3/2002', 10, null);

/*********************************************REUNION*/

insert into reunion (id, fecha, minuta, fk_supervisor) values (1, '3/1/2019', 'Aliquam quis turpis eget elit sodales scelerisque.', 2);
insert into reunion (id, fecha, minuta, fk_supervisor) values (2, '3/8/2019', 'Curabitur gravida nisi at nibh.', 2);
insert into reunion (id, fecha, minuta, fk_supervisor) values (3, '3/15/2019', 'Curabitur in libero ut massa volutpat convallis.', 2);
insert into reunion (id, fecha, minuta, fk_supervisor) values (4, '3/22/2019', 'Suspendisse potenti.', 2);
insert into reunion (id, fecha, minuta, fk_supervisor) values (5, '3/29/2019', 'Vestibulum ac est lacinia nisi venenatis tristique.', 2);
insert into reunion (id, fecha, minuta, fk_supervisor) values (6, '3/1/2019', 'Phasellus in felis.', 9);
insert into reunion (id, fecha, minuta, fk_supervisor) values (7, '3/8/2019', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst.', 9);
insert into reunion (id, fecha, minuta, fk_supervisor) values (8, '3/15/2019', 'Curabitur gravida nisi at nibh.', 9);
insert into reunion (id, fecha, minuta, fk_supervisor) values (9, '3/22/2019', 'Pellentesque at nulla.', 9);
insert into reunion (id, fecha, minuta, fk_supervisor) values (10, '3/29/2019', 'Integer ac leo.', 9);

ALTER SEQUENCE reunion_id_seq RESTART WITH 11 INCREMENT BY 1;

/*********************************************INASISTENCIA*/

insert into inasistencia (fk_empleo, fk_empleado, fk_reunion, fk_supervisor) values ('12/13/2009', 3, 1, 2);
insert into inasistencia (fk_empleo, fk_empleado, fk_reunion, fk_supervisor) values ('12/13/2009', 3, 2, 2);
insert into inasistencia (fk_empleo, fk_empleado, fk_reunion, fk_supervisor) values ('12/13/2009', 3, 3, 2);
insert into inasistencia (fk_empleo, fk_empleado, fk_reunion, fk_supervisor) values ('12/13/2009', 3, 4, 2);
insert into inasistencia (fk_empleo, fk_empleado, fk_reunion, fk_supervisor) values ('12/13/2009', 3, 5, 2);
insert into inasistencia (fk_empleo, fk_empleado, fk_reunion, fk_supervisor) values ('7/3/2002', 10, 6, 9);
insert into inasistencia (fk_empleo, fk_empleado, fk_reunion, fk_supervisor) values ('7/3/2002', 10, 7, 9);
insert into inasistencia (fk_empleo, fk_empleado, fk_reunion, fk_supervisor) values ('7/3/2002', 10, 8, 9);
insert into inasistencia (fk_empleo, fk_empleado, fk_reunion, fk_supervisor) values ('7/3/2002', 10, 9, 9);
insert into inasistencia (fk_empleo, fk_empleado, fk_reunion, fk_supervisor) values ('7/3/2002', 10, 10, 9);

/******************************************************************************************************/
/************************************************CATALOGO**********************************************/
/******************************************************************************************************/

insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (1, 'Bandeja', null, 'Rectangular', null, null, '44x22cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (2, 'Plato', 'Llano', 'Cuadrado', null, null, '27x27cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (3, 'Tetera', null, null, null, 6, null, null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (4, 'Taza', null, null, 'MokaSp', null, null, null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (5, 'Azucarero', null, null, null, 6, null, null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (6, 'Taza', null, null, 'CafeSp', null, null, null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (7, 'Bandeja', null, 'Ovalado', null, null, '44x22cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (8, 'Tetera', null, null, null, 2, null, null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (9, 'Taza', null, null, 'TeCp', null, null, null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (10, 'Ensaladera', null, null, null, null, '30x18cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (11, 'Azucarero', null, null, null, 6, null, null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (12, 'Lechera', null, null, null, 6, null, null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (13, 'Plato', 'Llano', 'Rectangular', null, null, '27x27cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (14, 'Taza', null, null, 'MokaSp', null, null, null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (15, 'Bandeja', null, 'Ovalado', null, null  , '35x18cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (16, 'Plato', 'Presenta', 'Redondo', null, null, '14x1cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (17, 'Plato', 'Hondo', 'Cuadrado', null, null, '2x3cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (18, 'Taza', null, null, 'TeCp', null, null, null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (19, 'Bandeja', null, 'Ovalado', null, null, '20x20cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (20, 'Jarra', null, null, null, null, null, '1.5lt');
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (21, 'Cazuela', null, null, null, null, '19x12cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (22, 'Plato', 'Llano', 'Redondo', null, null, '24x12cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (23, 'Ensaladera', null, null, null, null, '22x22cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (24, 'Taza', null, null, 'MokaSp', null, null, null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (25, 'Cazuela', null, null, null, null, '7x6cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (26, 'Plato', 'Postre', 'Redondo', null, null, '24x24cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (27, 'Taza', null, null, 'CafeCp', null, null, null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (28, 'Jarra', null, null, null, null, null, '31lt');
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (29, 'Cazuela', null, null, null, null, '15x15cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (30, 'Ensaladera', null, null, null, null, '38x38cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (31, 'Jarra', null, null, null, null, null, '31lt');
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (32, 'Plato', 'Pasta', 'Cuadrado', null, null, '20x20cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (33, 'Plato', 'Postre', null, null, null, '23x33cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (34, 'Taza', null, null, 'MokaCp', null, null, null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (35, 'Azucarero', null, null, null, 2, null, null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (36, 'Bandeja', null, 'Rectangular', null, null, '20x20cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (37, 'Plato', 'Postre', null, null, null, '13x12cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (38, 'Taza', null, null, 'TeSp', null, null, null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (39, 'Plato', 'Hondo', 'Rectangular', null, null, '12x12cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (40, 'Plato', 'Llano', 'Cuadrado', null, null, '14x14cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (41, 'Cazuela', null, null, null, null, '19x19cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (42, 'Cazuela', null, null, null, null, '20x20cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (43, 'Ensaladera', null, null, null, null, '30x30cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (44, 'Cazuela', null, null, null, null, '15x15cm', null);
insert into Molde (id, tipo, tipo_plato, forma, tipo_taza, cant_pers, tamano, volumen) values (45, 'Lechera', null, null, null, 6, null, null);

ALTER SEQUENCE molde_id_seq RESTART WITH 46 INCREMENT BY 1;

Insert into Coleccion (id, categoria, linea, descr) values (1, 'Clas_ele', 'I', 'Coleccion Amanecer Institucional');
Insert into Coleccion (id, categoria, linea, descr) values (2, 'Country', 'F', 'Coleccion Tarde Familiar');
Insert into Coleccion (id, categoria, linea, descr) values (3, 'Moderna', 'F', 'Coleccion Noche Familiar');
Insert into Coleccion (id, categoria, linea, descr) values (4, 'Country', 'I', 'Coleccion Zen Institucional');
Insert into Coleccion (id, categoria, linea, descr) values (5, 'Moderna', 'I', 'Coleccion Tiempo Institucional');

ALTER SEQUENCE coleccion_id_seq RESTART WITH 6 INCREMENT BY 1;

Insert into Col_Mot (id, nombre, tipo, descr) values (1, 'Azul', 'Color','Color Azul' );
Insert into Col_Mot (id, nombre, tipo, descr) values (2, 'Rojo', 'Color','Color Rojo' );
Insert into Col_Mot (id, nombre, tipo, descr) values (3, 'Animales', 'Motivo','Motivo Animales' );
Insert into Col_Mot (id, nombre, tipo, descr) values (4, 'Arboles', 'Motivo','Motivo Arboles' );
Insert into Col_Mot (id, nombre, tipo, descr) values (5, 'Amarillo', 'Color','Color Amarillo' );

ALTER SEQUENCE col_mot_id_seq RESTART WITH 6 INCREMENT BY 1;

insert into Juego (id, cant_personas, nombre, descr) values (1, 2, 'Marron', 'Juego Marron 2 Personas');
insert into Juego (id, cant_personas, nombre, descr) values (2, 4, 'Mar', 'Juego Mar 4 personas');
insert into Juego (id, cant_personas, nombre, descr) values (3, 6, 'Llano', 'Juego Llano 6 personas');
insert into Juego (id, cant_personas, nombre, descr) values (4, 2, 'Rudo', 'Juego Rudo 2 personas');
insert into Juego (id, cant_personas, nombre, descr) values (5, 6, 'Fiesta', 'Juego Fiesta 6 personas');
insert into Juego (id, cant_personas, nombre, descr) values (6, 6, 'Rumba', 'Juego Rumba 6 personas');
insert into Juego (id, cant_personas, nombre, descr) values (7, 2, 'Dorado', 'Juego Dorado 2 personas');
insert into Juego (id, cant_personas, nombre, descr) values (8, 6, 'Postre', 'Juego Postre 6 personas');
insert into Juego (id, cant_personas, nombre, descr) values (9, 4, 'Sala', 'Juego Sala 4 personas');
insert into Juego (id, cant_personas, nombre, descr) values (10, 6, 'Cocina', 'Juego Cocina 6 personas');

ALTER SEQUENCE juego_id_seq RESTART WITH 11 INCREMENT BY 1;

insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (1, 1, 1, 1, 'Bandeja Rectangular 44x22cm Coleccion 1' );
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (2, 1, 1, 2, 'plato llano cuadrado 27x27cm Coleccion 1' );
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (3, 1, 1, 3, 'tetera 6pers Coleccion 1 ');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (4, 1, 1, 4, 'taza moka sin plato Coleccion 1 ');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (5, 1, 1, 5, 'azucarero 6pers Coleccion 1 ');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (6, 1, 1, 6, 'tazas cafe sin plato Coleccion 1 ');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (7, 1, 1, 7, '1 bandeja ovalada 44x22cm Coleccion 1 ');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (8, 1, 1, 8, '1 tetera 2pers Coleccion 1 ');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (9, 1, 1, 9, 'taza te con plato Coleccion 1 ');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (10, 1, 1, 10, '1 ensaladera 30x18cm Coleccion 1 ');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (11, 1, 1, 11, '1 azucarero 6pers Coleccion 1 ');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (12, 2, 2, 12, 'lechera 2pers');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (13, 2, 2, 13, 'plato llano rectangular 27x27cm');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (14, 2, 2, 14, 'taza moka sin plato');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (15, 2, 2, 15, 'bandeja ovalada 35x18cm');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (16, 2, 2, 16, 'plato presentacion redondo 14x1cm');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (17, 2, 2, 17, 'platos hondo cuadrado 2x3cm');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (18, 2, 2, 18, 'taza te con plato');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (19, 2, 2, 3, 'tetera 6pers');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (20, 2, 2, 19, 'bandeja ovalada 20x20cm');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (21, 2, 2, 20, 'jarra 1.5lts');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (22, 2, 2, 21, 'cazuela 19x12cm');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (23, 2, 2, 22, 'plastos llanos redondo 24x12cm');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (24, 3, 3, 23, 'ensaladera 22x22cm');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (26, 3, 3, 25, 'cazuela 7x6cm');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (27, 3, 3, 26, 'plato postre redondo 24x24cm');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (28, 3, 3, 27, 'taza cafe con plato');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (29, 3, 3, 28, 'jarra 3lts');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (30, 3, 3, 6, 'taza cafe si plato');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (31, 3, 3, 29, 'cazuela 15x15cm');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (32, 3, 3, 30, 'ensaladera 38x38cm');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (33, 4, 4, 9, 'taza te con plato');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (34, 4, 4, 31, 'jarra 1lts');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (35, 4, 4, 32, 'plato pasta cuadrado 12x12cm');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (36, 4, 4, 36, 'bandeja rectangular 20x20cm');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (37, 4, 4, 6, 'taza cafe sin plato');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (38, 4, 4, 33, 'plato postre 23x33cm');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (39, 4, 4, 5, 'azucarero 6pers');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (40, 4, 4, 34, 'tazas moka con plato');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (41, 4, 4, 8, 'tetera 2pers');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (42, 4, 4, 37, 'plato postre 13x12cm');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (43, 4, 4, 27, ' taza cafe con plato');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (44, 4, 4, 35, ' azucarera 2pers');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (45, 5, 5, 38, 'taza te sin plato');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (46, 5, 5, 39, 'plato hondo rectangular 12x12cm');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (47, 5, 5, 40, 'plato llano cuadrado 14x14cm');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (48, 5, 5, 45, 'lechera 6pers');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (49, 5, 5, 41, 'cazuela 19x19cm');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (50, 5, 5, 42, 'cazuela 20x20cm');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (51, 5, 5, 34, 'taza moka con plato');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (52, 5, 5, 43, 'ensaladeras 30x30cm');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (53, 5, 5, 44, 'cazuelas 15x15cm');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (54, 5, 5, 28, 'jarra 3lts');
insert into Pieza (id, id_Coleccion, id_Col_Mot, id_Molde, descr) values (55, 5, 5, 6, 'taza cafe sin plato');

ALTER SEQUENCE pieza_id_seq RESTART WITH 56 INCREMENT BY 1;

insert into J_P (id_Pieza, id_Juego, cantidad) values (6, 1, 0);
insert into J_P (id_Pieza, id_Juego, cantidad) values (7, 1, 1);
insert into J_P (id_Pieza, id_Juego, cantidad) values (8, 1, 1);
insert into J_P (id_Pieza, id_Juego, cantidad) values (9, 2, 0);
insert into J_P (id_Pieza, id_Juego, cantidad) values (10, 2, 1);
insert into J_P (id_Pieza, id_Juego, cantidad) values (11, 2, 1);
insert into J_P (id_Pieza, id_Juego, cantidad) values (17, 3, 0);
insert into J_P (id_Pieza, id_Juego, cantidad) values (18, 3, 0);
insert into J_P (id_Pieza, id_Juego, cantidad) values (19, 3, 2);
insert into J_P (id_Pieza, id_Juego, cantidad) values (20, 4, 1);
insert into J_P (id_Pieza, id_Juego, cantidad) values (21, 4, 1);
insert into J_P (id_Pieza, id_Juego, cantidad) values (22, 4, 2);
insert into J_P (id_Pieza, id_Juego, cantidad) values (23, 2, 0);
insert into J_P (id_Pieza, id_Juego, cantidad) values (28, 5, 1);
insert into J_P (id_Pieza, id_Juego, cantidad) values (29, 5, 0);
insert into J_P (id_Pieza, id_Juego, cantidad) values (30, 6, 2);
insert into J_P (id_Pieza, id_Juego, cantidad) values (31, 6, 2);
insert into J_P (id_Pieza, id_Juego, cantidad) values (32, 6, 2);
insert into J_P (id_Pieza, id_Juego, cantidad) values (38, 7, 0);
insert into J_P (id_Pieza, id_Juego, cantidad) values (39, 7, 1);
insert into J_P (id_Pieza, id_Juego, cantidad) values (40, 7, 0);
insert into J_P (id_Pieza, id_Juego, cantidad) values (41, 7, 1);
insert into J_P (id_Pieza, id_Juego, cantidad) values (42, 8, 0);
insert into J_P (id_Pieza, id_Juego, cantidad) values (43, 8, 0);
insert into J_P (id_Pieza, id_Juego, cantidad) values (44, 8, 1);
insert into J_P (id_Pieza, id_Juego, cantidad) values (30, 9, 3);
insert into J_P (id_Pieza, id_Juego, cantidad) values (31, 9, 0);
insert into J_P (id_Pieza, id_Juego, cantidad) values (32, 10, 4);
insert into J_P (id_Pieza, id_Juego, cantidad) values (28, 10, 2);
insert into J_P (id_Pieza, id_Juego, cantidad) values (29, 10, 2);
insert into J_P (id_Pieza, id_Juego, cantidad) values (30, 10, 0);

Insert into C_M (id_Col_Mot, id_Coleccion) values (1,1);
Insert into C_M (id_Col_Mot, id_Coleccion) values (2,2);
Insert into C_M (id_Col_Mot, id_Coleccion) values (3,3);
Insert into C_M (id_Col_Mot, id_Coleccion) values (4,4);
Insert into C_M (id_Col_Mot, id_Coleccion) values (5,5);

Insert into Hist_Pieza (fecha, precio_Bs, inflacion, id_Pieza, fecha_fin) values ('03-06-2019', 15000, 10, 1, null);
Insert into Hist_Pieza (fecha, precio_Bs, inflacion, id_Pieza, fecha_fin) values ('03-03-2019', 1500, 5, 2, '03-06-2019');
Insert into Hist_Pieza (fecha, precio_Bs, inflacion, id_Pieza, fecha_fin) values ('01-01-2017', 26000, 0, 3, '01-04-2017');
Insert into Hist_Pieza (fecha, precio_Bs, inflacion, id_Pieza, fecha_fin) values ('01-01-2016', 100, 25, 4, '01-04-2016');
Insert into Hist_Pieza (fecha, precio_Bs, inflacion, id_Pieza, fecha_fin) values ('01-01-2015', 6500, 60, 5, '01-01-2015');
Insert into Hist_Pieza (fecha, precio_Bs, inflacion, id_Pieza, fecha_fin) values ('09-05-2019', 7896, 3, 6, null);
Insert into Hist_Pieza (fecha, precio_Bs, inflacion, id_Pieza, fecha_fin) values ('01-01-2019', 11445, 18, 7, '01-04-2019');
Insert into Hist_Pieza (fecha, precio_Bs, inflacion, id_Pieza, fecha_fin) values ('05-07-2018', 65880, 1, 8, '05-10-2018');
Insert into Hist_Pieza (fecha, precio_Bs, inflacion, id_Pieza, fecha_fin) values ('01-09-2017', 1212, 9, 9, '01-12-2017');
Insert into Hist_Pieza (fecha, precio_Bs, inflacion, id_Pieza, fecha_fin) values ('03-04-2015', 14789, 23, 10, '03-07-2015');

/******************************************************************************************************/
/**************************************************VENTAS**********************************************/
/******************************************************************************************************/

insert into Cliente (id, nombre, pais) values (1, 'Arliene', 'V');
insert into Cliente (id, nombre, pais) values (2, 'Llewellyn', 'V');
insert into Cliente (id, nombre, pais) values (3, 'Melloney', 'V');
insert into Cliente (id, nombre, pais) values (4, 'Prue', 'U');
insert into Cliente (id, nombre, pais) values (5, 'Joseph', 'U');
insert into Cliente (id, nombre, pais) values (6, 'Constantine', 'U');
insert into Cliente (id, nombre, pais) values (7, 'Jo-ann', 'C');
insert into Cliente (id, nombre, pais) values (8, 'Morrie', 'C');
insert into Cliente (id, nombre, pais) values (9, 'Sherwood', 'C');
insert into Cliente (id, nombre, pais) values (10, 'Hilliary', 'R');

ALTER SEQUENCE cliente_id_seq RESTART WITH 11 INCREMENT BY 1;

insert into Contrato (numero, descuento, fk_cliente, fecha_creacion) values (1, 86, 1, '2018-05-19');
insert into Contrato (numero, descuento, fk_cliente, fecha_creacion) values (2, 78, 2, '2019-05-19');
insert into Contrato (numero, descuento, fk_cliente, fecha_creacion) values (3, 68, 3, '2019-05-19');
insert into Contrato (numero, descuento, fk_cliente, fecha_creacion) values (4, 83, 4, '2017-06-19');
insert into Contrato (numero, descuento, fk_cliente, fecha_creacion) values (5, 17, 5, '2019-02-19');
insert into Contrato (numero, descuento, fk_cliente, fecha_creacion) values (6, 64, 6, '2019-02-5');
insert into Contrato (numero, descuento, fk_cliente, fecha_creacion) values (7, 67, 7, '2019-01-23');
insert into Contrato (numero, descuento, fk_cliente, fecha_creacion) values (8, 70, 8, '2019-03-19');
insert into Contrato (numero, descuento, fk_cliente, fecha_creacion) values (9, 79, 9, '2019-04-19');
insert into Contrato (numero, descuento, fk_cliente, fecha_creacion) values (10, 15, 10, '2019-08-19');

ALTER SEQUENCE contrato_numero_seq RESTART WITH 11 INCREMENT BY 1;

insert into Pedido (numero, fecha_encargo, fecha_entrega, fk_cliente) values (1, '2019-05-23', '2019-08-13', 1);
insert into Pedido (numero, fecha_encargo, fecha_entrega, fk_cliente) values (2, '2019-05-03', '2019-06-26', 2);
insert into Pedido (numero, fecha_encargo, fecha_entrega, fk_cliente) values (3, '2019-05-03', '2019-08-16', 3);
insert into Pedido (numero, fecha_encargo, fecha_entrega, fk_cliente) values (4, '2019-06-16', '2019-08-19', 4);
insert into Pedido (numero, fecha_encargo, fecha_entrega, fk_cliente) values (5, '2019-06-13', '2019-07-20', 5);
insert into Pedido (numero, fecha_encargo, fecha_entrega, fk_cliente) values (6, '2019-04-24', '2019-06-27', 6);
insert into Pedido (numero, fecha_encargo, fecha_entrega, fk_cliente) values (7, '2019-05-05', '2019-07-21', 7);
insert into Pedido (numero, fecha_encargo, fecha_entrega, fk_cliente) values (8, '2019-05-29', '2019-07-04', 8);
insert into Pedido (numero, fecha_encargo, fecha_entrega, fk_cliente) values (9, '2019-06-06', '2019-08-18', 9);
insert into Pedido (numero, fecha_encargo, fecha_entrega, fk_cliente) values (10, '2019-04-30', '2019-08-22', 10);

ALTER SEQUENCE pedido_numero_seq RESTART WITH 11 INCREMENT BY 1;

insert into Factura (id, fecha_emision, monto_total, fk_pedido) values (1, '2019-06-02', 7347.01, 1);
insert into Factura (id, fecha_emision, monto_total, fk_pedido) values (2, '2019-05-05', 343.01, 2);
insert into Factura (id, fecha_emision, monto_total, fk_pedido) values (3, '2019-05-08', 1683.24, 3);
insert into Factura (id, fecha_emision, monto_total, fk_pedido) values (4, '2019-06-11', 9673.66, 4);
insert into Factura (id, fecha_emision, monto_total, fk_pedido) values (5, '2019-06-16', 3291.63, 5);
insert into Factura (id, fecha_emision, monto_total, fk_pedido) values (6, '2019-05-31', 2669.19, 6);
insert into Factura (id, fecha_emision, monto_total, fk_pedido) values (7, '2019-06-05', 2702.94, 7);
insert into Factura (id, fecha_emision, monto_total, fk_pedido) values (8, '2019-04-18', 1083.31, 8);
insert into Factura (id, fecha_emision, monto_total, fk_pedido) values (9, '2019-04-25', 8254.38, 9);
insert into Factura (id, fecha_emision, monto_total, fk_pedido) values (10, '2019-06-22', 4535.12, 10);

ALTER SEQUENCE factura_id_seq RESTART WITH 11 INCREMENT BY 1;

insert into Detalle (id, cantidad, fk_pedido, fk_pieza, fk_juego) values (1, 3, 1, NULL, 1);
insert into Detalle (id, cantidad, fk_pedido, fk_pieza, fk_juego) values (2, 16, 2, NULL, 2);
insert into Detalle (id, cantidad, fk_pedido, fk_pieza, fk_juego) values (3, 6, 3, NULL, 3);
insert into Detalle (id, cantidad, fk_pedido, fk_pieza, fk_juego) values (4, 7, 4, NULL, 4);
insert into Detalle (id, cantidad, fk_pedido, fk_pieza, fk_juego) values (5, 10, 5, NULL, 5);
insert into Detalle (id, cantidad, fk_pedido, fk_pieza, fk_juego) values (6, 14, 6, 6, NULL);
insert into Detalle (id, cantidad, fk_pedido, fk_pieza, fk_juego) values (7, 17, 7, 7, NULL);
insert into Detalle (id, cantidad, fk_pedido, fk_pieza, fk_juego) values (8, 14, 8, 8, NULL);
insert into Detalle (id, cantidad, fk_pedido, fk_pieza, fk_juego) values (9, 12, 9, 9, NULL);
insert into Detalle (id, cantidad, fk_pedido, fk_pieza, fk_juego) values (10, 13, 10, 10, NULL);

ALTER SEQUENCE detalle_id_seq RESTART WITH 11 INCREMENT BY 1;

/**********************************************TELEFONO*/

insert into telefono (cod, num, fk_empleado, fk_cliente) values (7153906, 3201312, 1, null);
insert into telefono (cod, num, fk_empleado, fk_cliente) values (7775389, 7170227, 2, null);
insert into telefono (cod, num, fk_empleado, fk_cliente) values (8205456, 5682538, 3, null);
insert into telefono (cod, num, fk_empleado, fk_cliente) values (1632164, 2286619, 4, null);
insert into telefono (cod, num, fk_empleado, fk_cliente) values (8996961, 8010326, 5, null);
insert into telefono (cod, num, fk_empleado, fk_cliente) values (3782521, 6703955, null, 1);
insert into telefono (cod, num, fk_empleado, fk_cliente) values (677607, 2111377, null, 2);
insert into telefono (cod, num, fk_empleado, fk_cliente) values (6510057, 327423, null, 3);
insert into telefono (cod, num, fk_empleado, fk_cliente) values (3440281, 9041321, null, 4);
insert into telefono (cod, num, fk_empleado, fk_cliente) values (5587822, 8559810, null, 5);