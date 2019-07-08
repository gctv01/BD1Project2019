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
	fk_supervisor
	FROM empleado
