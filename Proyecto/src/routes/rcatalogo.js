const router = require("express").Router()
const bd = require("../db.js")
const request = require("request")

router.get("/reportes/catalogo", async (req, res) => {

    try {
  
      res.render("reportes/catalogo")
  
    } catch (err) {
      console.error(err.stack)
    }
  })

router.get("/reportes/catalogo/fpieza", async (req, res) => {

    try {
        const resp = await bd.query("SELECT m.Forma, cm.Nombre, m.Tamano, h.Precio_Bs, p.id, p.descr, m.volumen"
        + " FROM Molde m, Col_Mot cm, Hist_Pieza h, Pieza p"
        + " WHERE (m.id = p.id_molde) and (cm.id = p.id_Col_Mot) and (h.id_pieza = p.id) and (h.fecha_fin is NULL)")

        const info = resp.rows

        redata(info, "ryeTeIkNbB", res);

    } catch (err) {
        console.error(err.stack)
    }
})

router.get("/reportes/catalogo/pieza", async (req, res) => {

    try {
        const resp = await bd.query("SELECT nombre FROM Col_Mot")

        const mot = resp.rows

        res.render("reportes/catalogo/pieza", {mot})

    } catch (err) {
        console.error(err.stack)
    }
})

router.post("/reportes/catalogo/pieza", async (req, res) => {

    try {
        const {linea,categoria,mot} = req.body

        const resp = await bd.query("SELECT p.id, p.descr"
        + " FROM Pieza p"
        + " WHERE p.id_Coleccion in (SELECT id FROM Coleccion  WHERE linea = $1)and"
        + " p.id_Coleccion in (SELECT id FROM Coleccion WHERE categoria = $2) and"
        + " p.id_Col_Mot in (SELECT id FROM Col_Mot WHERE nombre = $3)",[linea,categoria,mot])

        const info = resp.rows

        redata(info, "HkeUVVbEWH", res);

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