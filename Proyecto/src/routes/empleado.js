const router = require("express").Router()
const bd = require("../db.js")

router.get("/empleado", async (req, res) => {
  try {
    const resp = await bd.query("select di,nombre,apellido,apellido2,"
      + "TO_CHAR(fecha_nacimiento,'DD/MM/YYYY') fecha_nacimiento,genero,tipo_sangre,"
      + "(CASE titulo"
      + " WHEN 'B' THEN 'Bachiller'"
      + " WHEN 'Q' THEN 'Ing.Quimico'"
      + " WHEN 'M' THEN 'Ing.Mecanico'"
      + " WHEN 'P' THEN 'Ing.Planta'"
      + " WHEN 'G' THEN 'Geologo'"
      + " WHEN 'I' THEN 'Ing.Industrial'"
      + " END) titulo,nombre2,"
      + "(select emps.di from empleado as emps where emp.fk_supervisor = emps.expediente) di_supervisor"
      + " FROM empleado emp")

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
    let { di, nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2, di_supervisor } = req.body;

    const text = "INSERT INTO EMPLEADO (di,nombre,apellido,apellido2,fecha_nacimiento,genero,tipo_sangre,titulo,nombre2,fk_supervisor)"
      + "VALUES ($1,UPPER($2),UPPER($3),UPPER($4),$5,$6,$7,$8,UPPER($9),(SELECT expediente FROM EMPLEADO WHERE di = $10));"
    const values = [di, nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2, di_supervisor]

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
    res.redirect("/empleado")
  }finally{
    
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

module.exports = router