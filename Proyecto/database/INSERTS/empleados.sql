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

