const {Client} = require("pg");

const client = new Client(require("./keys.js"));

client.connect((err) => {
  if (err) {
    console.error('connection error', err.stack);
  } else {
    console.log('db is connected');
  }
})

client.query('SELECT NOW() as now', (err, res) => {
  if (err) {
    console.log(err.stack)
  } else {
    console.log(res.rows[0])
  }
})

module.exports = client;
