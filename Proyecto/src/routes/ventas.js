const router = require("express").Router()
const bd = require("../db.js")

router.get("/ventas/agregar/cliente", async (req, res) => {
    try {
        res.render("ventas/agregar/cliente")
    } catch (err) {
        res.render("index")
    } finally {

    }
})

router.post("/ventas/agregar/cliente", async (req, res) => {
    try {
        const { nombre, pais } = req.body

        await bd.query("INSERT INTO cliente (nombre, pais) VALUES ($1,$2)", [nombre, pais])

        req.flash("exito", "Se registro el cliente")
    } catch (err) {
        req.flash("error", "No se registro el cliente")
        console.error(err.stack)
    } finally {
        res.redirect("/ventas/agregar/cliente")
    }
})

router.get("/ventas/agregar/contrato", async (req, res) => {
    try {
        const resp = await bd.query("SELECT id FROM cliente")
        cliente = resp.rows

        res.render("ventas/agregar/contrato", { cliente })
    } catch (err) {
        res.render("index")
    } finally {

    }
})

router.post("/ventas/agregar/contrato", async (req, res) => {
    try {
        const { id, descuento } = req.body

        await bd.query("INSERT INTO contrato (fk_cliente, descuento) VALUES ($1,$2)", [id, descuento])

        req.flash("exito", "Se agrego el contrato")
    } catch (err) {
        req.flash("error", "No se agrego el contrato")
        console.error(err.stack)
    } finally {
        res.redirect("/ventas/agregar/contrato")
    }
})

router.get("/ventas/agregar/pedido/inst", async (req, res) => {
    try {

        let resp = await bd.query("SELECT id FROM cliente")
        const cliente = resp.rows

        resp = await bd.query("SELECT p.id idp, p.descr dp FROM pieza p, coleccion c WHERE p.id_coleccion = c.id AND c.linea = 'I'")
        const pieza = resp.rows

        resp = await bd.query("SELECT j.id idj, j.nombre, j.cant_personas, j.descr dj FROM juego j, j_p jp, pieza p, coleccion c"
            + " WHERE jp.id_juego = j.id AND jp.id_pieza = p.id AND p.id_coleccion = c.id AND c.linea = 'I'"
            + " GROUP BY j.id")
        const juego = resp.rows

        res.render("ventas/agregar/pedidoinst", { cliente, pieza, juego })
    } catch (err) {
        res.render("index")
    } finally {

    }
})

router.post("/ventas/agregar/pedido/inst", async (req, res) => {
    try {
        const { id, idp, idj, cp, cj } = req.body

        let canp = new Array()

        cp.forEach(can => {
            if (can != "")
                canp.push(parseInt(can, 10))
        })

        let canj = new Array()

        cj.forEach(can => {
            if (can != "")
                canj.push(parseInt(can, 10))
        })

        await bd.query("BEGIN")

        await bd.query("INSERT INTO pedido(fecha_encargo,fecha_entrega,fk_cliente)"
            + " VALUES(current_date,current_date + 60,$1)", [id])

        if (!idp && !idj)
            throw "el pedido debe tener por lo menos un juego o una pieza"

        if (idp)
            if (typeof (idp) == "object") {
                idp.forEach(async idps => {
                    await bd.query("INSERT INTO detalle (cantidad,fk_pedido,fk_pieza)"
                        + " VALUES($1,(SELECT MAX(numero) FROM pedido),$2)", [canp[idp.indexOf(idps)], idps])
                })
            }
            else
                await bd.query("INSERT INTO detalle (cantidad,fk_pedido,fk_pieza)"
                    + " VALUES($1,(SELECT MAX(numero) FROM pedido),$2)", [canp[0], idp])

        if (idj)
            if (typeof (idj) == "object") {
                idj.forEach(async idjs => {
                    await bd.query("INSERT INTO detalle (cantidad,fk_pedido,fk_juego)"
                        + " VALUES($1,(SELECT MAX(numero) FROM pedido),$2)", [canj[idj.indexOf(idjs)], idjs])
                })
            }
            else
                await bd.query("INSERT INTO detalle (cantidad,fk_pedido,fk_juego)"
                    + " VALUES($1,(SELECT MAX(numero) FROM pedido),$2)", [canj[0], idj])

        req.flash("exito", "Se agrego el pedido")
    } catch (err) {
        await bd.query("ROLLBACK")
        req.flash("error", "No se agrego el pedido")
        console.error(err.stack)
    } finally {
        await bd.query("COMMIT")
        res.redirect("/ventas/agregar/pedido/inst")
    }
})

router.get("/ventas/agregar/pedido/fami", async (req, res) => {
    try {

        let resp = await bd.query("SELECT id FROM cliente WHERE pais = 'V'")
        const cliente = resp.rows

        resp = await bd.query("SELECT p.id idp, p.descr dp FROM pieza p, coleccion c WHERE p.id_coleccion = c.id AND c.linea = 'F'")
        const pieza = resp.rows

        resp = await bd.query("SELECT j.id idj, j.nombre, j.cant_personas, j.descr dj FROM juego j, j_p jp, pieza p, coleccion c"
            + " WHERE jp.id_juego = j.id AND jp.id_pieza = p.id AND p.id_coleccion = c.id AND c.linea = 'F'"
            + " GROUP BY j.id")
        const juego = resp.rows

        res.render("ventas/agregar/pedidofami", { cliente, pieza, juego })
    } catch (err) {
        res.render("index")
    } finally {

    }
})

router.post("/ventas/agregar/pedido/fami", async (req, res) => {
    try {
        const { id, idp, idj, cp, cj } = req.body

        let canp = new Array()

        cp.forEach(can => {
            if (can != "")
                canp.push(parseInt(can, 10))
        })

        let canj = new Array()

        cj.forEach(can => {
            if (can != "")
                canj.push(parseInt(can, 10))
        })

        await bd.query("BEGIN")

        await bd.query("INSERT INTO pedido(fecha_encargo,fecha_entrega,fk_cliente)"
            + " VALUES(current_date,current_date + 60,$1)", [id])

        if (!idp && !idj)
            throw "el pedido debe tener por lo menos un juego o una pieza"

        if (idp)
            if (typeof (idp) == "object") {
                idp.forEach(async idps => {
                    await bd.query("INSERT INTO detalle (cantidad,fk_pedido,fk_pieza)"
                        + " VALUES($1,(SELECT MAX(numero) FROM pedido),$2)", [canp[idp.indexOf(idps)], idps])
                })
            }
            else
                await bd.query("INSERT INTO detalle (cantidad,fk_pedido,fk_pieza)"
                    + " VALUES($1,(SELECT MAX(numero) FROM pedido),$2)", [canp[0], idp])

        if (idj)
            if (typeof (idj) == "object") {
                idj.forEach(async idjs => {
                    await bd.query("INSERT INTO detalle (cantidad,fk_pedido,fk_juego)"
                        + " VALUES($1,(SELECT MAX(numero) FROM pedido),$2)", [canj[idj.indexOf(idjs)], idjs])
                })
            }
            else
                await bd.query("INSERT INTO detalle (cantidad,fk_pedido,fk_juego)"
                    + " VALUES($1,(SELECT MAX(numero) FROM pedido),$2)", [canj[0], idj])

        let resp = bd.query("SELECT SUM(hp.precio) FROM detalle d, pieza p, hist_pieza hp"
        + " WHERE d.fk_pedido = (SELECT MAX(numero) FROM pedido) AND"
        + " d.fk_pieza = hp.id_pieza AND hp.fecha_fin IS NULL")

        const pp = resp.rows

        resp = bd.query("SELECT SUM(hp.precio*jp.cantidad*d.cantidad) FROM detalle d, pieza p,juego j,j_p jp, hist_pieza hp"
        + " WHERE d.fk_pedido = (SELECT MAX(numero) FROM pedido) AND"
        + " d.fk_juego = jp.id_juego AND jp.id_pieza = hp.id_pieza AND hp.fecha_fin IS NULL")

        const pj = resp.rows

        const t = pp + pj
            
        await bd.query("INSERT INTO factura(fecha_emision,fk_pedido,monto_total)"
        + " VALUES(current_date,(SELECT MAX(numero) FROM pedido),"
        + " $1)",[t])
        

        req.flash("exito", "Se agrego el pedido")
    } catch (err) {
        await bd.query("ROLLBACK")
        req.flash("error", "No se agrego el pedido")
        console.error(err.stack)
    } finally {
        await bd.query("COMMIT")
        res.redirect("/ventas/agregar/pedido/fami")
    }
})

module.exports = router