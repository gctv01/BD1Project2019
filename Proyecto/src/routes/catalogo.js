const router = require("express").Router()
const bd = require("../db.js")

router.get("/catalogo", (req,res) => {
    res.render("catalogo/catalogo")
})

router.get("/catalogo/detalles", (req,res) => {
  res.render("catalogo/detalles/detalles")
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
router.get("/catalogo/agregarCM", async (req,res) => {
  try{

    const resp = await bd.query("SELECT * FROM Coleccion")
    const coleccion = resp.rows


    res.render("catalogo/detalles/agregarCM", {coleccion})
  }catch(err){

  }finally{

  }
})

router.post("/agregarCM", async (req, res) => {
  try {
    let {nombre, tipo, idc, descr } = req.body;
    const resp = await bd.query("INSERT INTO Col_Mot (nombre, tipo, descr)"
    + "VALUES ($1, $2, $3)", [nombre, tipo, descr])
    const resp1 = await bd.query("SELECT * FROM Col_Mot ORDER BY id DESC") 
    const colmot = resp1.rows[0]
    const id = colmot.id   
      await bd.query("INSERT INTO C_M (id_Col_Mot, id_Coleccion)"
    + "VALUES ($1, $2)", [id, idc])    
    
    req.flash("exito", "Se agrego el Color-Motivo")
  } catch (err) {
    req.flash("error", "Se deben llenar los campos necesarios")
    console.error(err.stack)
  } finally {
    res.redirect("/catalogo/agregarCM")
  }
})

router.get("/catalogo/listaCM", async (req, res) => {
  try {
    const resp = await bd.query("select *from Col_Mot ")
    const col_mot = resp.rows      
    res.render("catalogo/detalles/listaCM", { col_mot })
  } catch (err) {
    console.error(err.stack)
    res.render("catalogo/detalles/listaCM")
  }
})

router.get("/catalogo/listaM", async (req, res) => {
  try {
    const resp = await bd.query("select *from Molde ")
    const molde = resp.rows      
    res.render("catalogo/detalles/listaM", { molde })
  } catch (err) {
    console.error(err.stack)
    res.render("catalogo/detalles/listaM")
  }
})

router.get("/catalogo/listaC", async (req, res) => {
  try {
    const resp = await bd.query("select * from Coleccion ")
    const coleccion = resp.rows      
    res.render("catalogo/detalles/listaC", { coleccion })
  } catch (err) {
    console.error(err.stack)
    res.render("catalogo/detalles/listaC")
  }
})

router.get("/eliminarC:id", async (req, res) => {
  try{
    const id = req.params.id
    await bd.query("DELETE FROM Coleccion "
    + " WHERE id = $1", [id])
    req.flash("exito", "Se elimino la Coleccion")
  } catch (err) {
    req.flash("error", "No se pudo eliminar la Coleccion")
    console.error(err.stack)
  } finally {
    res.redirect("/catalogo/listaC")
  }
  })

  router.get("/modificarC:id", async (req,res) => {
    try{
      const id = req.params.id
      const resp = await bd.query("SELECT descr, categoria, linea FROM Coleccion WHERE id = $1", [id])
      const {descr, categoria, linea} = resp.rows[0]

      res.render("catalogo/detalles/modificarC", {descr, categoria, linea, id})
    }catch(err){

    }finally{

    }
})

router.post("/modificarC:id", async (req, res) => {
  try {
    const id = req.params.id
    let {descr, categoria, linea} = req.body
    await bd.query("UPDATE Coleccion SET descr = $1, categoria = $2, linea = $3"
    + "WHERE id = $4", [descr, categoria, linea, id])
    req.flash("exito", "Se modifico la Coleccion")
  } catch (err) {
    req.flash("error", "Se deben llenar los campos necesarios")
    console.error(err.stack)
  } finally {
    res.redirect("catalogo/listaC")
  }
})

router.get("/eliminarM:id", async (req, res) => {
  try{
    const id = req.params.id
    await bd.query("DELETE FROM Molde "
    + " WHERE id = $1", [id])
    req.flash("exito", "Se elimino el Molde")
  } catch (err) {
    req.flash("error", "No se pudo eliminar el Molde")
    console.error(err.stack)
  } finally {
    res.redirect("/catalogo/listaM")
  }
  })

  router.get("/modificarM:id", async (req,res) => {
    try{
      const id = req.params.id
      const resp = await bd.query("SELECT tipo, tipo_plato, forma, tamano, tipo_taza, volumen, cant_pers FROM Molde WHERE id = $1", [id])
      const {tipo, tipo_plato, forma, tamano, tipo_taza, volumen, cant_pers} = resp.rows[0]

      res.render("catalogo/detalles/modificarM", {tipo, tipo_plato, forma, tamano, tipo_taza, volumen, cant_pers, id})
    }catch(err){

    }finally{

    }
})

router.post("/modificarM:id", async (req, res) => {
  try {
    const id = req.params.id
    let {tipo, tipo_plato, forma, tamano, tipo_taza, volumen, cant_pers} = req.body
    await bd.query("UPDATE Molde SET tipo = $1, tipo_plato = $2, forma = $3, tamano = $4, tipo_taza = $5, volumen = $6, cant_pers = $7"
    + "WHERE id = $8", [tipo, tipo_plato, forma, tamano, tipo_taza, volumen, cant_pers, id])
    req.flash("exito", "Se modifico el Molde")
  } catch (err) {
    req.flash("error", "Se deben llenar los campos necesarios")
    console.error(err.stack)
  } finally {
    res.redirect("catalogo/listaM")
  }
})

router.get("/eliminarCM:id", async (req, res) => {
  try{
    const id = req.params.id
    await bd.query("DELETE FROM C_M "
    + " WHERE id_Col_Mot = $1", [id])
    await bd.query("DELETE FROM Col_Mot "
    + "WHERE id = $1", [id])
    req.flash("exito", "Se elimino el Color-Motivo")
  } catch (err) {
    req.flash("error", "No se pudo eliminar el Color-Motivo")
    console.error(err.stack)
  } finally {
    res.redirect("/catalogo/listaCM")
  }
  })

  router.get("/modificarCM:id", async (req,res) => {
    try{
      const id = req.params.id
      const resp = await bd.query("SELECT nombre, tipo, descr FROM Col_Mot WHERE id = $1", [id])
      const {nombre, tipo, descr} = resp.rows[0]
      const resp1 = await bd.query("SELECT * FROM Coleccion ")
      const coleccion = resp1.rows

      res.render("catalogo/detalles/modificarCM", {nombre, tipo, descr, coleccion, id})
    }catch(err){

    }finally{

    }
})

router.post("/modificarCM:id", async (req, res) => {
  try {
    const id = req.params.id
    let {descr, idc, nombre, tipo} = req.body
    await bd.query("UPDATE Col_Mot SET nombre = $1, descr = $2, tipo = $3"
    + "WHERE id = $4", [nombre, descr, tipo, id])
    await bd.query("DELETE FROM C_M WHERE id_Col_Mot = $1", [id])
    await bd.query("INSERT INTO C_M (id_Col_Mot, id_Coleccion)"
    + "VALUES ($1, $2)", [id, idc]) 
    req.flash("exito", "Se modifico el Color-Motivo")
  } catch (err) {
    req.flash("error", "Se deben llenar los campos necesarios")
    console.error(err.stack)
  } finally {
    res.redirect("catalogo/listaCM")
  }
})

router.get("/catalogo/agregarM", async (req,res) => {
  try{

    const resp = await bd.query("SELECT * FROM Molde")
    const molde = resp.rows

    res.render("catalogo/detalles/agregarM", {molde})
  }catch(err){

  }finally{

  }
})

router.post("/agregarM", async (req, res) => {
  try {
    let {tipo, tipo_plato, forma, tamano, tipo_taza, volumen, cant_pers } = req.body;
    await bd.query("INSERT INTO Molde (tipo, tipo_plato, forma, tamano, tipo_taza, volumen, cant_pers)"
    + "VALUES ($1, $2, $3, $4, $5, $6, $7)", [tipo, tipo_plato, forma, tamano, tipo_taza, volumen, cant_pers])  
    
    req.flash("exito", "Se agrego el Molde")
  } catch (err) {
    req.flash("error", "Se deben llenar los campos necesarios")
    console.error(err.stack)
  } finally {
    res.redirect("/catalogo/agregarM")
  }
})

router.post("/agregarC", async (req, res) => {
  try {
    let {descr, categoria, linea } = req.body;
    await bd.query("INSERT INTO Coleccion (descr, categoria, linea)"
    + "VALUES ($1, $2, $3)", [descr, categoria, linea])  
    
    req.flash("exito", "Se agrego el Coleccion")
  } catch (err) {
    req.flash("error", "Se deben llenar los campos necesarios")
    console.error(err.stack)
  } finally {
    res.redirect("/catalogo/agregarC")
  }
})

router.get("/catalogo/agregarC", async (req,res) => {
  try{

    const resp = await bd.query("SELECT * FROM Coleccion")
    const coleccion = resp.rows

    res.render("catalogo/detalles/agregarC", {coleccion})
  }catch(err){

  }finally{

  }
})

router.get("/catalogo/agregarP", async (req,res) => {
    try{

      const resp = await bd.query("SELECT * FROM Coleccion")
      const coleccion = resp.rows
      const resp1 = await bd.query("SELECT * FROM Col_Mot")
      const col_mot = resp1.rows
      const resp2 = await bd.query("SELECT * FROM Molde")
      const molde = resp2.rows

      res.render("catalogo/pieza/agregarP", {coleccion, col_mot, molde})
    }catch(err){

    }finally{

    }
})



router.post("/agregarP", async (req, res) => {
  try {
    let {idm, idc, idcm, descr } = req.body;
    await bd.query("INSERT INTO Pieza (id_Coleccion, id_Col_Mot, id_Molde, descr)"
    + "VALUES ($1, $2, $3, $4)", [idc, idcm, idm, descr])
    req.flash("exito", "Se agrego la pieza")
  } catch (err) {
    req.flash("error", "Se deben llenar los campos necesarios")
    console.error(err.stack)
  } finally {
    res.redirect("/catalogo/agregarP")
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

  router.get("/catalogo/listaH", async (req, res) => {
    try {
      const resp = await bd.query("select *"
        + " from Hist_Pieza ")
      const historial = resp.rows      
      res.render("catalogo/historial/listaH", { historial })
    } catch (err) {
      console.error(err.stack)
      res.render("catalogo/historial/listaH")
    }
  })

  router.get("/catalogo/agregarH", async (req,res) => {
    try{

      const resp = await bd.query("SELECT * FROM Hist_Pieza")
      const historial = resp.rows
      const resp1 = await bd.query("SELECT * FROM Pieza")
      const pieza = resp1.rows
      res.render("catalogo/historial/agregarH", {historial, pieza})
    }catch(err){

    }finally{

    }
})

  router.post("/agregarH", async (req, res) => {
    try {
      let {inflacion, precio_bs, id_pieza, fecha } = req.body;
      const resp = await bd.query("SELECT fecha_fin FROM Hist_Pieza WHERE fecha = $1 ", [fecha])
      const fechaf = resp.rows
      console.log(fechaf)
      //if (fechaf != null){
      await bd.query("INSERT INTO Hist_Pieza (inflacion, precio_bs, id_pieza, fecha_fin, fecha)"
      + "VALUES ($1, $2, $3, $4, $5)", [inflacion, precio_bs, id_pieza, fecha_fin, fecha])
      req.flash("exito", "Se agrego el historial")
      //}
    } catch (err) {
      req.flash("error", "Se deben llenar los campos necesarios")
      console.error(err.stack)
    } finally {
      res.redirect("/catalogo/agregarH")
    }
  })

  router.get("/catalogo/listaPF", async (req, res) => {
    try {
      const resp = await bd.query("select p.* from pieza p, Coleccion c  WHERE  (c.id = p.id_Coleccion) and (c.linea = 'F') ")
      const pieza = resp.rows
     /* const resp2 = await bd.query("select p.id from pieza p, Coleccion c  WHERE  (c.id = p.id_Coleccion) and (c.linea = 'F') ")
      const id = resp2.rows
      const resp1 = await bd.query("SELECT precio_bs FROM Hist_Pieza WHERE id_pieza = $1", [id])
      const precio_bs = resp1.rows
      console.log(precio_bs, id)*/
      res.render("catalogo/pieza/listaPF", { pieza})
    } catch (err) {
      console.error(err.stack)
      res.render("catalogo/pieza/listaPF")
    }
  })

  router.get("/catalogo/listaPI", async (req, res) => {
    try {
      const resp = await bd.query("select p.* from pieza p, Coleccion c  WHERE  (c.id = p.id_Coleccion) and (c.linea = 'I') ")
      const pieza = resp.rows
     /* const resp2 = await bd.query("select p.id from pieza p, Coleccion c  WHERE  (c.id = p.id_Coleccion) and (c.linea = 'I') ")
      const id = resp2.rows
      const resp1 = await bd.query("SELECT precio_bs FROM Hist_Pieza WHERE id_pieza = $1", [id])
      const precio_bs = resp1.rows
      console.log(precio_bs, id)*/
      res.render("catalogo/pieza/listaPI", { pieza })
    } catch (err) {
      console.error(err.stack)
      res.render("catalogo/pieza/listaPI")
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
          throw "se debe agregar por lo menos una pieza al juego"
  
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

  

  router.get("/eliminarPF:id", async (req, res) => {
    try{
      const id = req.params.id
      await bd.query("DELETE FROM J_P "
      + " WHERE id_Pieza = $1", [id])
      await bd.query("DELETE FROM Pieza "
      + "WHERE id = $1", [id])
      req.flash("exito", "Se elimino la pieza")
    } catch (err) {
      req.flash("error", "No se pudo eliminar la pieza")
      console.error(err.stack)
    } finally {
      res.redirect("/catalogo/listaPF")
    }
    })

    router.get("/eliminarPI:id", async (req, res) => {
      try{
        const id = req.params.id
        await bd.query("DELETE FROM J_P "
        + " WHERE id_Pieza = $1", [id])
        await bd.query("DELETE FROM Pieza "
        + "WHERE id = $1", [id])
        req.flash("exito", "Se elimino la pieza")
      } catch (err) {
        req.flash("error", "No se pudo eliminar la pieza")
        console.error(err.stack)
      } finally {
        res.redirect("/catalogo/listaPI")
      }
      })

    router.post("/modificarP:id", async (req, res) => {
      try {
        const id = req.params.id
        let {descr, idc, idcm, idm} = req.body
        const resp = await bd.query("UPDATE Pieza SET descr = $1, id_Col_Mot = $2, id_Molde = $3, id_Coleccion = $4"
        + "WHERE id = $5", [descr, idcm, idm, idc, id])
        req.flash("exito", "Se modifico la pieza")
      } catch (err) {
        req.flash("error", "Se deben llenar los campos necesarios")
        console.error(err.stack)
      } finally {
        res.redirect("/catalogo")
      }
    })

    

    router.get("/modificarP:id", async (req,res) => {
      try{
        const id = req.params.id
        const resp3 = await bd.query("SELECT descr FROM Pieza WHERE id = $1", [id])
        const {descr} = resp3.rows[0]
        const resp = await bd.query("SELECT * FROM Coleccion")
        const coleccion = resp.rows
        const resp1 = await bd.query("SELECT * FROM Col_Mot")
        const col_mot = resp1.rows
        const resp2 = await bd.query("SELECT * FROM Molde")
        const molde = resp2.rows
  
        res.render("catalogo/pieza/modificarP", {coleccion, col_mot, molde, id, descr})
      }catch(err){
  
      }finally{
  
      }
  })

  
  router.get("/catalogo/modificar:id", async (req, res) => {
    try {
      const id = req.params.id
  
      const resp = await bd.query("SELECT nombre,cant_personas,descr"
        + " FROM juego  WHERE id = $1", [id])
      const { nombre,cant_personas,descr } = resp.rows[0]
      const resp1 = await bd.query("SELECT * FROM Pieza WHERE ($1 in (SELECT id_Juego FROM  J_P))", [id])
      const pieza = resp1.rows
  
      res.render("catalogo/juego/modificar", { id, nombre,cant_personas,descr, pieza })
    } catch (err) {
      console.error(err.stack)
      res.render("catalogo/lista")
    } finally {
  
    }
  })

  router.post("/catalogo/modificar:id", async (req, res) => {
    try {
      id = req.params.id
      let { nombre, cant_personas, descr, cantidad, idp} = req.body;
  
      const resp = await bd.query("UPDATE Juego SET nombre = $1, cant_personas = $2, descr = $3"
        + " WHERE id = $4", [nombre, cant_personas, descr, id])

        let cant = new Array()
  
      cantidad.forEach(can => {
        if(can != "")
        cant.push(parseInt(can,10))
      })
      await bd.query("DELETE FROM J_P WHERE id_Juego = $1 ", [id])

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
          throw "se debe agregar por lo menos una pieza al juego"
  
      req.flash("exito", "Juego modificado con exito")
  
    } catch (err) {
  
      req.flash("error", "No se pudo modificar el Juego")
      console.error(err.stack)
  
    } finally {
      res.redirect("/catalogo/lista")
    }
  })


  
module.exports = router