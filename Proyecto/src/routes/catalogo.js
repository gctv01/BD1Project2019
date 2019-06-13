const router = require("express").Router()
const bd = require("../db.js")

router.get("/catalogo/agregar/pieza", (req,res) => {
    res.render("catalogo/agregar/pieza")
})

module.exports = router