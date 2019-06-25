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

insert into Contrato (numero, descuento, fk_cliente) values (1, 86, 1);
insert into Contrato (numero, descuento, fk_cliente) values (2, 78, 2);
insert into Contrato (numero, descuento, fk_cliente) values (3, 68, 3);
insert into Contrato (numero, descuento, fk_cliente) values (4, 83, 4);
insert into Contrato (numero, descuento, fk_cliente) values (5, 17, 5);
insert into Contrato (numero, descuento, fk_cliente) values (6, 64, 6);
insert into Contrato (numero, descuento, fk_cliente) values (7, 67, 7);
insert into Contrato (numero, descuento, fk_cliente) values (8, 70, 8);
insert into Contrato (numero, descuento, fk_cliente) values (9, 79, 9);
insert into Contrato (numero, descuento, fk_cliente) values (10, 15, 10);

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
