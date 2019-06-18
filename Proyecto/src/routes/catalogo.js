const router = require("express").Router()
const bd = require("../db.js")

router.get("/catalogo", (req,res) => {
    res.render("catalogo/catalogo")
})

router.get("/catalogo/agregarJ", (req,res) => {
    res.render("catalogo/juego/agregarJ")
})

router.get("/catalogo/lista", (req,res) => {
    res.render("catalogo/juego/lista")
})


router.get("/catalogo", async (req, res) => {
    try {
      const resp = await bd.query("select id,nombre,cant_personas,descr)"
        + " from juego as jue")
      const juego = resp.rows
      juego.forEach(jue => {
        switch (jue.cant_personas) {
          case "2": jue.cant_personas = 2
            break
          case "4": jue.cant_personas = 4
            break
          case "6": jue.cant_personas = 6
            break
        }
      });
      res.render("/catalogo/agregarJ", { juego })
    } catch (err) {
      console.error(err.stack)
      res.render("index")
    }
  })

  router.get("/catalogo/lista", async (req, res) => {
    try {
      const resp = await bd.query("select id,nombre,cant_personas,descr"
        + " from juego ")
      const juego = resp.rows
      console.log(juego)
      res.render("catalogo/lista", { juego })
    } catch (err) {
      console.error(err.stack)
      res.render("index")
    }
  })

router.post("/agregarJ", async (req, res) => {
    try {
      let { id, nombre, cant_personas, descr } = req.body;
      
      if (descr == "")
        descr = null
  
      const text = "INSERT INTO JUEGO (id,nombre,cant_personas,descr)"
        + "VALUES ($1,$2,$3,$4);"
      const values = [id,nombre,cant_personas,descr]
  
      await bd.query(text, values)
  
      req.flash("exito", "Se agrego el juego")
    } catch (err) {
      req.flash("error", "Se deben llenar los campos necesarios")
      console.error(err.stack)
    } finally {
      res.redirect("/catalogo/agregarJ")
    }
  })

module.exports = router