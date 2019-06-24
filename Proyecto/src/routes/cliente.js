const router = require("express").Router()
const bd = require("../db.js")

router.get("/cliente/agregar", (req,res) => {
    res.render("cliente/agregar")
})
router.post("/cliente/agregar", async (req, res) => {
    try {
      let {di, nombre, pais} = req.body;
  
      await bd.query("BEGIN")
  
      await bd.query("INSERT INTO CLIENTE (id,nombre,pais)"
        + "VALUES ($1,UPPER($2),UPPER($3))", [di, nombre, pais])
  
      
  
      req.flash("exito", "Se agrego el cliente")
    } catch (err) {
      await bd.query("ROLLBACK")
      req.flash("error", "Se deben llenar los campos necesarios")
      console.error(err.stack)
    } finally {
      await bd.query("COMMIT")
      res.redirect("/cliente/agregar")
    }
  })