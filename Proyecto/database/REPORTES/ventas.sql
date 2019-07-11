Select * from Contrato
where fecha_creacion > (current_date - 365) and fk_cliente = (secuencial, busco contrato por cliente)

Select f.id, f.fecha_emision, f.monto_total, p.numero, c.nombre
from Factura f, Cliente c, Pedido p
where f.fk_pedido = p.numero and c.id = p.fk_cliente

Select p.numero, p.fecha_encargo, p.fecha_entrega, j.nombre, c.nombre, i.id
from Detalle d, Cliente c, Pedido p, Pedido e, pieza i, juego j
where d.fk_pedido = p.numero and c.id = p.fk_cliente and j.id = d.fk_juego or i.id = fk_pieza


Select c.id, SUM(h.precio_bs) * SUM(h.inflacion) * COUNT(d.fk_pieza), h.fecha, c.linea
from coleccion c, pieza p, juego j, detalle d, hist_pieza h, pedido e
where h.id_pieza = p.id and d.fk_pieza = p.id and d.fk_pedido = e.numero and EXTRACT(YEAR FROM h.fecha) = EXTRACT(YEAR FROM e.fecha_encargo) and EXTRACT(MONTH FROM h.fecha) = EXTRACT(MONTH FROM e.fecha_encargo)
group by c.linea, EXTRACT(YEAR FROM h.fecha), EXTRACT(MONTH FROM h.fecha), c.id, h.fecha