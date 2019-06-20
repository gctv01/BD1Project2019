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

    const resp = await bd.query("SELECT nombre,apellido,apellido2,fecha_nacimiento,genero,tipo_sangre,titulo,nombre2,"
      + " (SELECT emps.di FROM empleado emps WHERE emp.fk_supervisor = emps.expediente) di_supervisor"
      + " FROM empleado emp WHERE emp.di = $1", [di])
    const { nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2, di_supervisor } = resp.rows[0]

    res.render("empleado/modificar", { di, nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2, di_supervisor })
  } catch (err) {
    console.error(err.stack)
    res.render("empleado")
  } finally {

  }
})

router.post("/empleado/modificar:di", async (req, res) => {
  try {
    const di = req.params.di
    const { nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2 } = req.body

    const resp = await bd.query("UPDATE empleado SET nombre = UPPER($1),apellido = UPPER($2),apellido2 = UPPER($3),fecha_nacimiento = $4,genero = $5,tipo_sangre = $6,titulo = $7,nombre2 = UPPER($8)"
      + " WHERE di = $9", [nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2, di])

    req.flash("exito", "Empleado modificado con exito")

  } catch (err) {

    req.flash("error", "No se pudo modificar el empleado")
    console.error(err.stack)

  } finally {
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
    const rest = await bd.query("SELECT nombre,(CASE alergia WHEN true THEN 'Si' ELSE 'No' END) alergia,"
    + " descripcion FROM cond_salud")
    const cond = rest.rows
    console.log(cond)

    res.render("empleado/reporte/salud", { cond })
  } catch (err) {
    console.error(err.stack)
    res.render("index")
  } finally {

  }
})

module.exports = router