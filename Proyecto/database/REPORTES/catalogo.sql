/*Ficha_Pieza*/
SELECT m.Forma, cm.Nombre, m.Tamano, h.Precio_Bs, p.id, p.descr, m.volumen
FROM Molde m, Col_Mot cm, Hist_Pieza h, Pieza p
WHERE (m.id = p.id_molde) and (cm.id = p.id_Col_Mot) and (h.id_pieza = p.id) and (h.fecha_fin is NULL)
/*Catalogo_Pieza_Filtrada*/
SELECT p.id, p.descr
FROM Pieza p
WHERE p.id_Coleccion in (SELECT id FROM Coleccion  WHERE linea = $P{Linea})and
p.id_Coleccion in (SELECT id FROM Coleccion WHERE categoria = $P{Categoria}) and
p.id_Col_Mot in (SELECT id FROM Col_Mot WHERE nombre = $P{Color/Motivo})