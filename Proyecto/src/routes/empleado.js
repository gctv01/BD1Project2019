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
  res.render("empleado/agregar")
})

router.post("/empleado/agregar", async (req, res) => {
  try {
    let { di, nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2 } = req.body;

    let text = "INSERT INTO EMPLEADO (di,nombre,apellido,apellido2,fecha_nacimiento,genero,tipo_sangre,titulo,nombre2)"
      + "VALUES ($1,UPPER($2),UPPER($3),UPPER($4),$5,$6,$7,$8,UPPER($9))"

    let values = [di, nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2]

    await bd.query(text, values)

    req.flash("exito", "Se agrego el empleado")
  } catch (err) {
    req.flash("error", "Se deben llenar los campos necesarios")
    console.error(err.stack)
  } finally {
    res.redirect("/empleado/agregar")
  }
})

router.get("/empleado/eliminar:di", async (req, res) => {
  try {
    const di = req.params.di

    await bd.query("DELETE FROM EMPLEADO WHERE di = $1", [di])

    req.flash("exito", "Se elimino el empleado")
  } catch (err) {
    req.flash("error", "No se pudo eliminar un supervisor, elimine todas los empleados asociados")
    console.error(err.stack)
  } finally {
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
    let {di, sueldo, cargo, id_organigrama } = req.body

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

    let text = "UPDATE empleo SET"
    + " fecha_fin = NOW()"
    + " WHERE fk_empleado = (SELECT expediente FROM empleado WHERE di = $1) AND fecha_fin IS NULL"

    let values = [di]

    await bd.query(text, values)
    ///
    text = "INSERT INTO EMPLEO (fecha_inicio,sueldo,cargo,fk_empleado,fk_organigrama,fecha_fin)"
      + "VALUES (NOW(),$1,$2,(SELECT expediente FROM empleado WHERE di = $3),$4,null)"

    values = [sueldo, cargo, di, id_organigrama]

    await bd.query(text, values)

    req.flash("exito", "Se asigno el empleo")
  } catch (err) {
    req.flash("error", "No se pudo asignar el empleo")
    console.error(err.stack)
  } finally {
    res.redirect("/empleado/agregar/empleo")
  }
})

module.exports = router