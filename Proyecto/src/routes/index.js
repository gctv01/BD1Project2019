const router = require("express").Router()

router.get("/", (req, res) => {
    res.render("index", {nom: "eze"})
})

module.exports = router