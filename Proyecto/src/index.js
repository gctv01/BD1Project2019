const express = require("express");
const exphbs = require("express-handlebars");
const path = require("path");
const app = express();

require("./db");

app.set("port", process.env.PORT || 3000);
app.set("views", path.join(__dirname, "views"));
app.engine(".hbs", exphbs({
    defaultLayout: "main",
    layoutsDir: path.join(app.get("views"), "layouts"),
    partialsDir: path.join(app.get("views"), "partials"),
    extname: ".hbs"
}))
app.set("view engine", ".hbs")

app.use(require("./routes/index"))

app.listen(app.get("port"), () => {
    console.log("Server on port", app.get("port"))
})

