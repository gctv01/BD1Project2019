const router = require("express").Router()
const bd = require("../db.js")

router.get("/", async (req, res) => {
  try {
    const resp = await bd.query("select di,nombre,apellido,apellido2,fecha_nacimiento,genero,tipo_sangre,titulo,nombre2,"
      + " (select emps.di from empleado as emps where emp.fk_supervisor = emps.expediente) di_supervisor"
      + " from empleado as emp")
    const empleado = resp.rows
    empleado.forEach(emp => {
      emp.fecha_nacimiento = emp.fecha_nacimiento.toDateString()
      switch (emp.genero) {
        case "M": emp.genero = "Masculino"
          break
        case "F": emp.genero = "Femenino"
          break
        case "T": emp.genero = "Transgenero"
          break
      }
      switch (emp.titulo) {
        case "B": emp.titulo = "Bachiller"
          break
        case "Q": emp.titulo = "Ing.Quimico"
          break
        case "M": emp.titulo = "Ing.Mecanico"
          break
        case "P": emp.titulo = "Ing.Planta"
          break
        case "G": emp.titulo = "Geologo"
          break
        case "I": emp.titulo = "Ing.Industrial"
          break
      }
    });
    res.render("empleado", { empleado })
  } catch (err) {
    console.error(err.stack)
    res.render("index")
  }
})

router.get("/agregar", (req, res) => {
  res.render("empleado/agregar")
})

router.post("/agregar", async (req, res) => {
  try {
    let { di, nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2, di_supervisor } = req.body;
    
    if (di_supervisor == "")
      di_supervisor = null
      
    nombre = nombre.toUpperCase()
    apellido = apellido.toUpperCase()
    apellido2 = apellido2.toUpperCase()
    nombre2 = nombre2.toUpperCase()

    const text = "INSERT INTO EMPLEADO (di,nombre,apellido,apellido2,fecha_nacimiento,genero,tipo_sangre,titulo,nombre2,fk_supervisor)"
      + "VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,(SELECT expediente FROM EMPLEADO WHERE di = $10));"
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

router.get("/eliminar:di", async (req, res) => {
  try {
    const di = req.params.di

    console.log(di)

    await bd.query("DELETE FROM EMPLEADO WHERE di = $1", [di])

  } catch (err) {
    req.flash("error", "No se pudo eliminar un supervisor, elimine todas los empleados asociados")
    console.error(err.stack)
  } finally {
    res.redirect("/empleado")
  }
})

router.get("/modificar:di", async (req, res) => {
  try {
    const di = req.params.di

    /*const resp = await bd.query("select nombre,apellido,apellido2,fecha_nacimiento,genero,tipo_sangre,titulo,nombre2,"
      + " (select emps.di from empleado as emps where emp.fk_supervisor = emps.expediente) di_supervisor"
      + " from empleado as emp WHERE emp.di = $1",[di])
    const { nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2, di_supervisor } = resp.rows[0]
    const empleado = { di, nombre, apellido, apellido2, fecha_nacimiento, genero, tipo_sangre, titulo, nombre2, di_supervisor }
    
    console.log(empleado)*/

    res.render("empleado/modificar", {di})
  } catch (err) {
    req.flash("error", "error")
    console.error(err.stack)
  }
})

router.post("/modificar:di", async (req,res) => {
  try{
  const di = req.params.di
  const {nombre,apellido,apellido2,fecha_nacimiento,genero,tipo_sangre,titulo,nombre2,di_supervisor} = req.body

  const resp = await bd.query("UPDATE empleado SET nombre = $1,apellido = $2,apellido2 = $3,fecha_nacimiento = $4,genero = $5,tipo_sangre = $6,titulo = $7,nombre2 = $8"
      + " WHERE di = $9",[nombre,apellido,apellido2,fecha_nacimiento,genero,tipo_sangre,titulo,nombre2,di])
  }catch(err){
    req.flash("error", "Se deben llenar los campos necesarios")
    console.error(err.stack)
  }finally{
    res.redirect("/empleado")
  }

})

module.exports = router