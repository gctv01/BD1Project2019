const router = require("express").Router()
const bd = require("../db.js")

router.get("/", async (req, res) => {
    const resp = await bd.query("select di, nombre, apellido, fecha_nacimiento, genero, tipo_sangre from empleado")
    const {di, nombre, apellido, fecha_nacimiento, genero, tipo_sangre} = resp.rows
    const empleado = {di, nombre, apellido, fecha_nacimiento, genero, tipo_sangre}
    res.render("empleado",{empleado})
})

router.get("/agregar", (req, res) => {
    res.render("empleado/agregar")
})

router.post("/agregar", async (req, res) => {
    let {di, nombre, apellido, fecha_nacimiento, genero, tipo_sangre} = req.body;
    nombre = nombre.toUpperCase()
    apellido = apellido.toUpperCase()

    const text = 'INSERT INTO empleado(di, nombre, apellido, fecha_nacimiento, genero, tipo_sangre) VALUES($1, $2, $3, $4, $5, $6) RETURNING *'
    const values = [di, nombre, apellido, fecha_nacimiento, genero, tipo_sangre]
    
    await bd.query(text, values, (err, res) => {
      if (err) {
        console.log(err.stack)
      }
    })

    res.redirect("/empleado");
})

module.exports = router