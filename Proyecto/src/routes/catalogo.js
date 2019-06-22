const router = require("express").Router()
const bd = require("../db.js")

router.get("/catalogo", (req,res) => {
    res.render("catalogo/catalogo")
})

router.get("/catalogo/agregarJ", (req,res) => {
    res.render("catalogo/juego/agregarJ")
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
      res.render("catalogo/juego/lista", { juego })
    } catch (err) {
      console.error(err.stack)
      res.render("catalogo/juego/lista")
    }
  })

  router.get("/catalogo/agregarP", async (req, res) => {
    try {
      const resp = await bd.query("select id,nombre,cant_personas,descr"
        + " from juego ")
      const juego = resp.rows
      res.render("catalogo/juego/agregarP", { juego })
    } catch (err) {
      console.error(err.stack)
      res.render("catalogo/juego/agregarP")
    }
  })

  router.get("/catalogo/agregarP2:id", async (req, res) => {
    try {
      const id = req.params.id
      const resp1 = await bd.query(" SELECT id, id_Coleccion, id_Col_Mot, id_Molde, descr FROM pieza")
      const pieza = resp1.rows
      const pid = pieza.id
      res.render("catalogo/juego/agregarP2", { id , pieza, pid})
    } catch (err) {
      console.error(err.stack)
      res.render("catalogo/juego/agregarP2")
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

  router.get("/catalogo/eliminar:id", async (req, res) => {
    try {
      const id = req.params.id
  
      await bd.query("DELETE FROM J_P"
    + " WHERE id_Juego = $1", [id])
      await bd.query("DELETE FROM Juego WHERE id = $1", [id])
      console.log(id)
  
      req.flash("exito", "Se elimino el juego")
    } catch (err) {
      req.flash("error", "No se pudo eliminar el juego")
      console.error(err.stack)
    } finally {
      res.redirect("/catalogo/lista")
    }
  }) 

  router.get("/catalogo/modificar:id", async (req, res) => {
    try {
      const id = req.params.id
  
      const resp = await bd.query("SELECT nombre,cant_personas,descr"
        + " FROM juego  WHERE id = $1", [id])
      const { nombre,cant_personas,descr } = resp.rows[0]
  
      res.render("catalogo/juego/modificar", { id, nombre,cant_personas,descr })
    } catch (err) {
      console.error(err.stack)
      res.render("catalogo/lista")
    } finally {
  
    }
  })

  router.post("/catalogo/modificar:id", async (req, res) => {
    try {
      const id = req.params.id
      const { nombre, cant_personas, descr} = req.body
  
      const resp = await bd.query("UPDATE Juego SET nombre = $1, cant_personas = $2, descr = $3"
        + " WHERE id = $4", [nombre, cant_personas, descr, id])
  
      req.flash("exito", "Juego modificado con exito")
  
    } catch (err) {
  
      req.flash("error", "No se pudo modificar el Juego")
      console.error(err.stack)
  
    } finally {
      res.redirect("/catalogo/lista")
    }
  })

  router.post("/catalogo/agregarP2:pid:id", async (req, res) => {
    try {
      const pid = req.params.pid
      const id = req.params.id
      const { cant } = req.body;     
      const resp1 = await bd.query("SELECT id FROM J_P ORDER BY id DESC")
      const cod = ((resp1.rowCount) + 1) 
      const resp = await bd.query( "INSERT INTO J_P (id, id_Pieza, id_Juego, Cantidad)"
        + "VALUES ($1,$2,$3,$4);", [cod,pid,id,cant])
  
      req.flash("exito", "Se agrego la pieza al juego")
    } catch (err) {
      req.flash("error", "No se pudo agregar")
      console.error(err.stack)
    } finally {
      res.redirect("/catalogo/agregarP")
    }
  })

  
module.exports = router