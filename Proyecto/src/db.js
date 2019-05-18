const {Client} = require("pg");
const client = new Client({
    user: "postgres",
    password: "agente86",
    host: "localhost",
    port: 5432,
    database: "practica"
})

client.connect()
.then(() => console.log("Coneccion establesida con la base de datos"))
.then(() => client.query("select * from usuario"))
.then(results => console.table(results.rows))
.catch(e => console.log("error en la coneccion con la base de datos"))
.finally(() => client.end())

module.exports = client;
