const router = require("express").Router()
const bd = require("../db.js")
const request = require("request")

router.get("/reportes/ventas", async (req, res) => {

    try {

        res.render("reportes/ventas")

    } catch (err) {
        console.error(err.stack)
    }
})

router.get("/reportes/ventas/contrato", async (req, res) => {

    try {

        const resp = await bd.query("SELECT id, nombre FROM cliente")

        cliente = resp.rows

        res.render("reportes/ventas/contrato", { cliente })

    } catch (err) {
        console.error(err.stack)
    }
})

router.post("/reportes/ventas/contrato", async (req, res) => {

    try {
        const { id } = req.body

        let resp

        if (id != "Todos")
            resp = await bd.query("Select numero, descuento, fk_cliente, TO_CHAR(fecha,'DD-MM-YYYY') fecha from Contrato"
                + " where EXTRACT(YEAR FROM fecha) = EXTRACT(YEAR FROM CURRENT_DATE)  and fk_cliente = $1", [id])
        else
            resp = await bd.query("Select numero, descuento, fk_cliente, TO_CHAR(fecha,'DD-MM-YYYY') fecha from Contrato"
                + " where EXTRACT(YEAR FROM fecha) = EXTRACT(YEAR FROM CURRENT_DATE)")

        const info = resp.rows

        redata(info, "S1elgk4VZS", res);

    } catch (err) {
        console.error(err.stack)
    }
})

router.get("/reportes/ventas/pedido", async (req, res) => {

    try {

        const resp = await bd.query("SELECT id, nombre FROM cliente")

        cliente = resp.rows

        res.render("reportes/ventas/pedido", { cliente })

    } catch (err) {
        console.error(err.stack)
    }
})

router.post("/reportes/ventas/pedido", async (req, res) => {

    try {
        const { id } = req.body

        let resp

        if (id != "Todos")
            resp = await bd.query("Select p.numero, TO_CHAR(p.fecha_encargo,'DD-MM-YYYY') fecha_encargo,"
            + " TO_CHAR(p.fecha_entrega,'DD-MM-YYYY') fecha_entrega, c.nombre, c.id"
            + " from Cliente c, Pedido p"
            + " where c.id = p.fk_cliente and c.id = $1", [id])
        else
            resp = await bd.query("Select p.numero, TO_CHAR(p.fecha_encargo,'DD-MM-YYYY') fecha_encargo, TO_CHAR(p.fecha_entrega,'DD-MM-YYYY') fecha_entrega,"
            + " c.nombre, c.id"
            + " from Cliente c, Pedido p"
            + " where c.id = p.fk_cliente")

        const info = resp.rows

        redata(info, "SylwUfBVbr", res);

    } catch (err) {
        console.error(err.stack)
    }
})

router.get("/reportes/ventas/factura", async (req, res) => {

    try {

        const resp = await bd.query("SELECT id, nombre FROM cliente")

        cliente = resp.rows

        res.render("reportes/ventas/factura", { cliente })

    } catch (err) {
        console.error(err.stack)
    }
})

router.post("/reportes/ventas/factura", async (req, res) => {

    try {
        const { id } = req.body

        let resp

        if (id != "Todos")
            resp = await bd.query("Select f.id a, TO_CHAR(f.fecha_emision,'DD-MM-YYYY') fecha_emision, f.monto_total, p.numero, c.nombre, c.id b"
            + " from Factura f, Cliente c, Pedido p"
            + " where f.fk_pedido = p.numero and c.id = p.fk_cliente AND c.id = $1", [id])
        else
            resp = await bd.query("Select f.id a, TO_CHAR(f.fecha_emision,'DD-MM-YYYY') fecha_emision, f.monto_total, p.numero, c.nombre, c.id b"
            + " from Factura f, Cliente c, Pedido p"
            + " where f.fk_pedido = p.numero and c.id = p.fk_cliente")

        const info = resp.rows

        redata(info, "SygP_trNbr", res);

    } catch (err) {
        console.error(err.stack)
    }
})

function redata(info, tem, res) {
    const data = {
        template: { "shortid": tem },
        data: {
            info
        },
        options: {
            preview: true
        }
    }
    const options = {
        url: 'http://localhost:5488/api/report',
        method: 'POST',
        json: data
    }
    request(options).pipe(res)
}

module.exports = router