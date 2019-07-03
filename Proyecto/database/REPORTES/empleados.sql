select di,nombre,apellido,apellido2,fecha_nacimiento,genero,tipo_sangre,titulo,nombre2,
(select emps.di from ejgempleado as emps where emp.fk_supervisor = emps.expediente) di_supervisor 
from ejgempleado as emp;
