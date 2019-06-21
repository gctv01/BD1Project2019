const router = require("express").Router()
const bd = require("../db.js")

router.get("/empleado", async (req, res) => {
  try {
    const resp = await bd.query("SELECT di,nombre,apellido,apellido2,"
      + "TO_CHAR(fecha_nacimiento,'DD/MM/YYYY') fecha_nacimiento,genero,tipo_sangre,"
      + "(CASE titulo"
      + " WHEN 'B' THEN 'Bachiller'"
      + " WHEN 'Q' THEN 'Ing.Quimico'"
      + " WHEN 'M' THEN 'Ing.Mecanico'"
      + " WHEN 'P' THEN 'Ing.Planta'"
      + " WHEN 'G' THEN 'Geologo'"
      + " WHEN 'I' THEN 'Ing.Industrial'"
      + " END) titulo,nombre2,"
      + "(SELECT emps.di from empleado as emps where emp.fk_supervisor = emps.expediente) di_supervisor,"
      + "(SELECT sueldo FROM empleo WHERE expediente = fk_empleado AND fecha_fin IS NULL) sueldo,"
      + "(CASE (SELECT cargo FROM empleo WHERE expediente = fk_empleado AND fecha_fin IS NULL)"
      + " WHEN 'S' THEN 'Secretaria'"
      + " WHEN 'G' THEN 'Gerente'"
      + " WHEN 'O' THEN 'Operador general'"
      + " WHEN 'E' THEN 'Electricista'"
      + " WHEN 'M' THEN 'Mecanico'"
      + " WHEN 'I' THEN 'Inspector'"
      + " END) cargo FROM empleado emp")

    const empleado = resp.rows

    res.render("empleado", { empleado })
  } catch (err) {
    console.error(err.stack)
    res.render("index")
  }
})

router.get("/empleado/agregar", async (req, res) => {
  try {

    const rest = await bd.query("SELECT id,nombre,alergia,descripcion FROM cond_salud")
    const salud = rest.rows

    res.render("empleado/agregar", { salud })
  } catch (err) {

  } finally {

  }

})

router.post("/empleado/agregar", async (req, res) => {
  try {
    let { salud, di, nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2 } = req.body;

    await bd.query("BEGIN")

    await bd.query("INSERT INTO EMPLEADO (di,nombre,apellido,apellido2,fecha_nacimiento,genero,tipo_sangre,titulo,nombre2)"
      + "VALUES ($1,UPPER($2),UPPER($3),UPPER($4),$5,$6,$7,$8,UPPER($9))", [di, nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2])

    if (salud != null)
      if (typeof (salud) == "object")
        salud.forEach(async id => {
          await bd.query("INSERT INTO e_c (fk_empleado, fk_cond)"
            + "VALUES ((SELECT expediente FROM empleado WHERE di = $1), $2)", [di, id])
        })
      else
        await bd.query("INSERT INTO e_c (fk_empleado, fk_cond)"
          + "VALUES ((SELECT expediente FROM empleado WHERE di = $1), $2)", [di, salud])

    req.flash("exito", "Se agrego el empleado")
  } catch (err) {
    await bd.query("ROLLBACK")
    req.flash("error", "Se deben llenar los campos necesarios")
    console.error(err.stack)
  } finally {
    await bd.query("COMMIT")
    res.redirect("/empleado/agregar")
  }
})

router.get("/empleado/eliminar:di", async (req, res) => {
  try {
    const di = req.params.di

    await bd.query("BEGIN")

    //ELIMINAR INASISTENCIAS
    await bd.query("DELETE FROM inasistencia"
      + " WHERE fk_empleado = (SELECT expediente FROM empleado WHERE di = $1) OR"
      + " fk_supervisor = (SELECT expediente FROM empleado WHERE di = $1)", [di])

    //ELIMINAR REUNION
    await bd.query("DELETE FROM reunion"
      + " WHERE fk_supervisor = (SELECT expediente FROM empleado WHERE di = $1)", [di])

    //ELIMINANDO E_C
    await bd.query("DELETE FROM e_c"
      + " WHERE fk_empleado = (SELECT expediente FROM empleado WHERE di = $1)", [di])

    //ELIMINANDO TURNOS
    await bd.query("DELETE FROM turnos_hist"
      + " WHERE fk_empleo = (SELECT fecha_inicio FROM empleo"
      + " WHERE fk_empleado = (SELECT expediente FROM empleado WHERE di = $1))", [di])

    //ELIMINANDO EMPLEOS
    await bd.query("DELETE FROM empleo"
      + " WHERE fk_empleado = (SELECT expediente FROM empleado WHERE di = $1)", [di])

    //ELIMINANDO EMPLEADO
    await bd.query("DELETE FROM empleado WHERE di = $1", [di])

    req.flash("exito", "Se elimino el empleado")
  } catch (err) {
    await bd.query("ROLLBACK")
    req.flash("error", "No se pudo eliminar un supervisor, elimine todas los empleados asociados")
    console.error(err.stack)
  } finally {
    await bd.query("COMMIT")
    res.redirect("/empleado")
  }
})

router.get("/empleado/modificar:di", async (req, res) => {
  try {
    const di = req.params.di

    let resp = await bd.query("SELECT nombre,apellido,apellido2,fecha_nacimiento,genero,tipo_sangre,titulo,nombre2,"
      + " (SELECT emps.di FROM empleado emps WHERE emp.fk_supervisor = emps.expediente) di_supervisor"
      + " FROM empleado emp WHERE emp.di = $1", [di])
    const { nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2, di_supervisor } = resp.rows[0]

    resp = await bd.query("SELECT id,nombre,alergia,descripcion FROM cond_salud")
    const salud = resp.rows

    res.render("empleado/modificar", { di, nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2, di_supervisor, salud })
  } catch (err) {
    console.error(err.stack)
    res.redirect("/")
  } finally {

  }
})

router.post("/empleado/modificar:di", async (req, res) => {
  try {
    const di = req.params.di
    const { salud, nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2 } = req.body

    await bd.query("BEGIN")

    const resp = await bd.query("UPDATE empleado SET nombre = UPPER($1),apellido = UPPER($2),apellido2 = UPPER($3),fecha_nacimiento = $4,genero = $5,tipo_sangre = $6,titulo = $7,nombre2 = UPPER($8)"
      + " WHERE di = $9", [nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2, di])

    await bd.query("DELETE FROM e_c WHERE fk_empleado = (SELECT expediente FROM empleado WHERE di = $1)",[di])

    if (salud != null)
      if (typeof (salud) == "object")
        salud.forEach(async id => {
          await bd.query("INSERT INTO e_c (fk_empleado, fk_cond)"
            + "VALUES ((SELECT expediente FROM empleado WHERE di = $1), $2)", [di, id])
        })
      else
        await bd.query("INSERT INTO e_c (fk_empleado, fk_cond)"
          + "VALUES ((SELECT expediente FROM empleado WHERE di = $1), $2)", [di, salud])

    req.flash("exito", "Empleado modificado con exito")
  } catch (err) {
    await bd.query("ROLLBACK")
    req.flash("error", "No se pudo modificar el empleado")
    console.error(err.stack)

  } finally {
    await bd.query("COMMIT")
    res.redirect("/empleado")
  }
})

router.get("/empleado/agregar/empleo", async (req, res) => {
  try {
    const resp = await bd.query("SELECT di FROM EMPLEADO")
    const empleado = resp.rows

    res.render("empleado/empleo", { empleado })
  } catch (err) {
    console.error(err.stack)
    res.render("index")
  } finally {

  }
})

router.post("/empleado/agregar/empleo", async (req, res) => {
  try {
    let { di, sueldo, cargo, id_organigrama } = req.body

    if (cargo == 'G' && id_organigrama > 3)
      throw "error incompatibilidad en los cargos"
    if (cargo == 'O' && (id_organigrama < 4 || id_organigrama > 14 || id_organigrama == 6 || id_organigrama == 7))
      throw "error incompatibilidad en los cargos"
    if (cargo == 'S')
      id_organigrama = 2
    if (cargo == 'E' || cargo == 'M')
      id_organigrama = 7
    if (cargo == 'I')
      id_organigrama = 6

    await bd.query("BEGIN")

    //AJUSTANDO FECHA FIN PARA EMPLEO
    await bd.query("UPDATE empleo SET"
      + " fecha_fin = NOW()"
      + " WHERE fk_empleado = (SELECT expediente FROM empleado WHERE di = $1) AND fecha_fin IS NULL", [di])

    //INSERTANDO EMPLEO
    await bd.query("INSERT INTO EMPLEO (fecha_inicio,sueldo,cargo,fk_empleado,fk_organigrama,fecha_fin)"
      + "VALUES (NOW(),$1,$2,(SELECT expediente FROM empleado WHERE di = $3),$4,null)", [sueldo, cargo, di, id_organigrama])

    //ASIGNANDO SUPERVISOR AL EMPLEADO
    await bd.query("UPDATE empleado e SET fk_supervisor ="
      + " (SELECT s.expediente FROM empleado s, empleo eo "
      + " WHERE eo.fk_empleado = s.expediente AND"
      + " eo.fk_organigrama = $2 AND"
      + " eo.fecha_fin IS NULL AND"
      + " s.fk_supervisor IS NULL AND"
      + " s.expediente != e.expediente)"
      + " WHERE e.di = $1", [di, id_organigrama])

    req.flash("exito", "Se asigno el empleo")
  } catch (err) {
    await bd.query("ROLLBACK")
    req.flash("error", "No se pudo asignar el empleo")
    console.error(err.stack)
  } finally {
    await bd.query("COMMIT")
    res.redirect("/empleado/agregar/empleo")
  }
})

router.get("/empleado/agregar/turno", async (req, res) => {
  try {
    const rest = await bd.query("SELECT di FROM empleado, empleo"
      + " WHERE expediente = fk_empleado AND fecha_fin IS NULL AND fk_organigrama = 10")
    const hornero = rest.rows
    res.render("empleado/agregar/turno", { hornero })
  } catch (err) {
    res.render("index")
    console.error(err.stack)
  } finally {

  }
})

router.post("/empleado/agregar/turno", async (req, res) => {
  try {
    const { di, turno } = req.body

    await bd.query("BEGIN")

    await bd.query("UPDATE turnos_hist SET"
      + " fecha_fin = NOW()"
      + " WHERE fk_empleado = (SELECT expediente FROM empleado WHERE di = $1) AND fecha_fin IS NULL", [di])

    await bd.query("INSERT INTO turnos_hist (fecha_inicio, turno, fk_empleo, fk_empleado, fecha_fin)"
      + " VALUES (NOW(),$2,"
      + " (SELECT fecha_inicio FROM empleo"
      + " WHERE fk_empleado = (SELECT expediente FROM empleado"
      + " WHERE di = $1) AND fecha_fin IS NULL),"
      + " (SELECT expediente FROM empleado"
      + " WHERE di = $1), null)", [di, turno])

    req.flash("exito", "Se asigno el turno")
  } catch (err) {
    await bd.query("ROLLBACK")
    req.flash("error", "No se pudo asignar el turno")
    console.error(err.stack)
  } finally {
    await bd.query("COMMIT")
    res.redirect("/empleado/agregar/turno")
  }
})

router.get("/empleado/agregar/salud", (req, res) => {
  res.render("empleado/agregar/salud")
})

router.post("/empleado/agregar/salud", async (req, res) => {
  try {
    const { nombre, alergia, descripcion } = req.body

    await bd.query("INSERT INTO cond_salud (nombre,alergia,descripcion)"
      + "VALUES (UPPER($1),$2,UPPER($3))", [nombre, alergia, descripcion])

    req.flash("exito", "Se agrego la consicion de salud")
  } catch (err) {
    req.flash("error", "No se agrego la condicion de salud")
  } finally {
    res.redirect("/empleado/agregar/salud")
  }
})

router.get("/empleado/salud", async (req, res) => {
  try {
    const rest = await bd.query("SELECT id, nombre,(CASE alergia WHEN true THEN 'Si' ELSE 'No' END) alergia,"
      + " descripcion FROM cond_salud")
    const cond = rest.rows

    res.render("empleado/reporte/salud", { cond })
  } catch (err) {
    console.error(err.stack)
    res.render("index")
  } finally {

  }
})

router.get("/empleado/salud/eliminar:id", async (req, res) => {
  try {
    const id = req.params.id

    await bd.query("BEGIN")

    await bd.query("DELETE FROM e_c WHERE fk_cond = $1", [id])

    await bd.query("DELETE FROM cond_salud WHERE id = $1", [id])

    req.flash("exito", "Se elimino la condicion de salud")
    res.redirect("/empleado/salud")
  } catch (err) {
    await bd.query("ROLLBACK")
    req.flash("error", "No se elimino la condicion de salud")
    console.error(err.stack)
    res.render("index")
  } finally {
    await bd.query("COMMIT")
  }
})

router.get("/empleado/salud/modificar:id", async (req, res) => {
  try {
    const id = req.params.id

    res.render("empleado/modificar/salud", { id })
  } catch (err) {
    console.error(err.stack)
    res.render("index")
  } finally {
  }
})

router.post("/empleado/salud/modificar:id", async (req, res) => {
  try {
    const id = req.params.id
    const { nombre, alergia, descripcion } = req.body

    await bd.query("UPDATE cond_salud SET nombre = UPPER($2), alergia = $3, descripcion = UPPER($4)"
      + " WHERE id = $1", [id, nombre, alergia, descripcion])

    req.flash("exito", "Se modifico la condicion de salud")
    res.redirect("/empleado/salud")
  } catch (err) {
    req.flash("error", "No se modifico la condicion de salud")
    console.error(err.stack)
    res.redirect("/empleado/salud")
  } finally {
  }
})

router.get("/empleado/reunion/agregar", async (req, res) => {
  try {
    const rest = await bd.query("SELECT di FROM empleado WHERE fk_supervisor IS NULL")
    const emps = rest.rows

    res.render("empleado/agregar/reunion", { emps })
  } catch (err) {
    console.error(err.stack)
    res.render("index")
  } finally {
  }
})

router.post("/empleado/reunion/agregar", async (req, res) => {
  try {
    const { di, minuta } = req.body
    const dis = di

    await bd.query("BEGIN")

    await bd.query("INSERT INTO reunion (fecha,minuta,fk_supervisor)"
      + " VALUES(NOW(),UPPER($2),(SELECT expediente FROM empleado e WHERE e.di = $1 AND e.fk_supervisor IS NULL))"
      , [dis, minuta])

    resp = await bd.query("SELECT e.expediente, e.di, e.nombre FROM empleado e"
      + " WHERE e.fk_supervisor = (SELECT s.expediente FROM empleado s WHERE s.di = $1)", [dis])
    emp = resp.rows

    req.flash("exito", "Se agrego la reunion")
    res.render("empleado/agregar/inasistencia", { dis, emp })
  } catch (err) {
    await bd.query("ROLLBACK")
    console.error(err.stack)
    req.flash("error", "No se agrego la reunion")
    res.redirect("/empleado/reunion/agregar")
  } finally {
    await bd.query("COMMIT")
  }
})

router.post("/empleado/inasistencia:dis", async (req, res) => {
  try {
    const dis = req.params.dis
    const { expediente } = req.body

    if (expediente != null)
      if (typeof (expediente) == "object")
        expediente.forEach(async exp => {
          await bd.query("INSERT INTO inasistencia (fk_empleo, fk_empleado, fk_reunion, fk_supervisor)"
            + "VALUES ((SELECT em.fecha_inicio FROM empleo em WHERE em.fk_empleado = $1 AND em.fecha_fin IS NULL),"
            + "$1,(SELECT r.id FROM reunion r WHERE r.fk_supervisor = "
            + "(SELECT emp.expediente FROM empleado emp WHERE emp.di = $2) AND r.fecha = "
            + "(SELECT MAX(re.fecha) FROM reunion re WHERE re.fk_supervisor = (SELECT e.expediente FROM empleado e WHERE e.di = $2))),"
            + "(SELECT s.expediente FROM empleado s WHERE s.di = $2))", [expediente, dis])
        })
      else
        await bd.query("INSERT INTO inasistencia (fk_empleo, fk_empleado, fk_reunion, fk_supervisor)"
          + "VALUES ((SELECT em.fecha_inicio FROM empleo em WHERE em.fk_empleado = $1 AND em.fecha_fin IS NULL),"
          + "$1,(SELECT r.id FROM reunion r WHERE r.fk_supervisor = "
          + "(SELECT emp.expediente FROM empleado emp WHERE emp.di = $2) AND r.fecha = "
          + "(SELECT MAX(re.fecha) FROM reunion re WHERE re.fk_supervisor = (SELECT e.expediente FROM empleado e WHERE e.di = $2))),"
          + "(SELECT s.expediente FROM empleado s WHERE s.di = $2))", [expediente, dis])

    req.flash("exito", "Se agrego la reunion con sus inasistencias")
  } catch (err) {
    req.flash("error", "No se agregaron las inasistencias")
    console.error(err.stack)
  } finally {
    res.redirect("/empleado/reunion/agregar")
  }
})

router.get("/empleado/detalle/agregar", async (req, res) => {
  di = req.params.di
  try {
    res.render("empleado/agregar/detalle")
  } catch (err) {
    console.error(err.stack)
    res.render("index")
  } finally {
  }
})

module.exports = router