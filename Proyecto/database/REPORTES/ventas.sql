/*contrato*/
Select numero, descuento, fk_cliente, TO_CHAR(fecha,'DD-MM-YYYY') fecha from Contrato
where EXTRACT(YEAR FROM fecha) = EXTRACT(YEAR FROM CURRENT_DATE)  and fk_cliente = $1

/*factura*/
Select f.id a, TO_CHAR(f.fecha_emision,'DD-MM-YYYY') fecha_emision, f.monto_total, p.numero, c.nombre, c.id b
from Factura f, Cliente c, Pedido p
where f.fk_pedido = p.numero and c.id = p.fk_cliente

/*pedido*/
Select p.numero, TO_CHAR(p.fecha_encargo,'DD-MM-YYYY') fecha_encargo, TO_CHAR(p.fecha_entrega,'DD-MM-YYYY') fecha_entrega,
c.nombre, c.id
from Cliente c, Pedido p
where c.id = p.fk_cliente

Select c.id, SUM(h.precio_bs) * SUM(h.inflacion) * COUNT(d.fk_pieza), h.fecha, c.linea
from coleccion c, pieza p, juego j, detalle d, hist_pieza h, pedido e
where h.id_pieza = p.id and d.fk_pieza = p.id and d.fk_pedido = e.numero and EXTRACT(YEAR FROM h.fecha) = EXTRACT(YEAR FROM e.fecha_encargo) and EXTRACT(MONTH FROM h.fecha) = EXTRACT(MONTH FROM e.fecha_encargo)
group by c.linea, EXTRACT(YEAR FROM h.fecha), EXTRACT(MONTH FROM h.fecha), c.id, h.fecha