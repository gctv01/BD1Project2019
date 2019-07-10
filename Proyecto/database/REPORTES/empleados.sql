/*exp*/
SELECT expediente,di,nombre,nombre2,apellido,apellido2,
TO_CHAR(fecha_nacimiento,'DD-MM-YYYY') fecha_nacimiento,
(CASE genero 
WHEN 'M' THEN 'Masculino'
WHEN 'F' THEN 'Femenino'
WHEN 'T' THEN 'Transgenero'
END) genero,
tipo_sangre,
(CASE titulo
WHEN 'B' THEN 'Bachiller'
WHEN 'Q' THEN 'Ing.Quimico'
WHEN 'M' THEN 'Ing.Mecanico'
WHEN 'P' THEN 'Ing.Planta'
WHEN 'G' THEN 'Geologo'
WHEN 'I' THEN 'Ing.Industrial'
END) titulo,
(SELECT CONCAT(cod,num) FROM telefono
WHERE expediente = fk_empleado ORDER BY cod ASC LIMIT 1) telefono,
fk_supervisor
FROM empleado ORDER BY expediente

/*exp_det*/
SELECT id, TO_CHAR(fecha,'DD-MM-YYYY') fecha,
(CASE motivo WHEN 'IN' THEN 'Inasistencia'
WHEN 'BM' THEN 'Bono mensual'
WHEN 'BA' THEN 'Bono anual'
WHEN 'AM' THEN 'Amonestacion'
WHEN 'RE' THEN 'Minutos de retraso'
WHEN 'HE' THEN 'Horas extras' END) motivo,
fk_empleado,descripcion,monto_bono,horas_extras,retraso
FROM detalle_exp ORDER BY fk_empleado

/*horneros*/
SELECT e.expediente, t.turno,EXTRACT(MONTH FROM d.fecha) mes,EXTRACT(YEAR FROM d.fecha) ano, d.retraso, d.horas_extras
FROM empleado e, empleo em, detalle_exp d, turnos_hist t
WHERE e.expediente = em.fk_empleado
AND  em.cargo LIKE ('O')
AND e.expediente = d.fk_empleado
AND (d.retraso IS NOT NULL OR d.horas_extras IS NOT NULL)
AND em.fecha_inicio = t.fk_empleo
AND em.fk_empleado = t.fk_empleado
AND d.fecha BETWEEN t.fecha_inicio AND t.fecha_fin