const router = require("express").Router()
const bd = require("../db.js")

router.get("/catalogo", (req, res) => {
  res.render("catalogo/catalogo")
})

router.get("/catalogo/agregarJ", async (req, res) => {
  try {

    const resp = await bd.query("SELECT id,descr FROM pieza")
    const pieza = resp.rows

    res.render("catalogo/juego/agregarJ", { pieza })
  } catch (err) {

  } finally {

  }
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

router.get("/catalogo/verPiezas:id", async (req, res) => {
  try {
    id = req.params.id
    const resp = await bd.query("select id_pieza, cantidad"
      + " from J_P where id_Juego = $1 ", [id])
    const piezas = resp.rows
    res.render("catalogo/juego/verPiezas", { piezas, id })
  } catch (err) {
    console.error(err.stack)
    res.render("catalogo/juego/lista")
  }
})


router.post("/agregarJ", async (req, res) => {
  try {
    let { nombre, cant_personas, descr, cantidad, idp } = req.body;

    console.log(nombre, cant_personas, descr, cantidad, idp)

    let cant = new Array()

    cantidad.forEach(can => {
      if(can != "")
      cant.push(parseInt(can,10))
    })

    console.log(cant)

    await bd.query("BEGIN")

    await bd.query("INSERT INTO juego (nombre,cant_personas,descr)"
      + " VALUES($1,$2,$3)", [nombre, cant_personas, descr])

    if (idp != null)
      if (typeof (idp) == "object")
        idp.forEach(async id => {
          await bd.query("INSERT INTO j_p (id_pieza,id_juego,cantidad)"
            + " VALUES($1,(SELECT MAX(id) FROM juego),$2)", [parseInt(id, 10), cant[parseInt(id - 1)]])
        })
      else
        await bd.query("INSERT INTO j_p (id_pieza,id_juego,cantidad)"
          + " VALUES($1,(SELECT MAX(id) FROM juego),$2)", [parseInt(idp, 10), cant[0]])
    else
        throw "se debe agregar polomenos una pieza al juego"

    req.flash("exito", "Se agrego el juego")
  } catch (err) {
    await bd.query("ROLLBACK")
    req.flash("error", "Se deben llenar los campos necesarios")
    console.error(err.stack)
  } finally {
    await bd.query("COMMIT")
    res.redirect("/catalogo/agregarJ")
  }
})

router.get("/catalogo/eliminar:id", async (req, res) => {
  try {
    const id = req.params.id

    await bd.query("DELETE FROM J_P"
      + " WHERE id_Juego = $1", [id])
    await bd.query("DELETE FROM Juego WHERE id = $1", [id])

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
    const { nombre, cant_personas, descr } = resp.rows[0]
    const resp1 = await bd.query("SELECT * FROM Pieza WHERE ($1 in (SELECT id_Juego FROM  J_P))", [id])
    const pieza = resp1.rows

    res.render("catalogo/juego/modificar", { id, nombre, cant_personas, descr, pieza })
  } catch (err) {
    console.error(err.stack)
    res.render("catalogo/lista")
  } finally {

  }
})

router.post("/catalogo/modificar:id", async (req, res) => {
  try {
    id = req.params.id
    let { nombre, cant_personas, descr, cantidad, idp } = req.body;

    const resp = await bd.query("UPDATE Juego SET nombre = $1, cant_personas = $2, descr = $3"
      + " WHERE id = $4", [nombre, cant_personas, descr, id])

    Array.from(idp).forEach(async idp => {
      Array.from(cantidad).forEach(async cantidad => {
        const resp1 = await bd.query("DELETE FROM J_P WHERE id_Juego = $1 ", [id])

        const resp2 = await bd.query("INSERT INTO J_P (id_juego, id_pieza, cantidad)"
          + "VALUES ($1,$2,$3);", [id, idp, cantidad])
      })
    })

    req.flash("exito", "Juego modificado con exito")

  } catch (err) {

    req.flash("error", "No se pudo modificar el Juego")
    console.error(err.stack)

  } finally {
    res.redirect("/catalogo/lista")
  }
})



module.exports = router