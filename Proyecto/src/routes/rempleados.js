const router = require("express").Router()
const bd = require("../db.js")
const request = require("request")

router.get("/reportes/empleados", async (req, res) => {

  try {

    res.render("reportes/empleados")

  } catch (err) {
    console.error(err.stack)
  }
})

router.get("/reportes/empleados/exp", async (req, res) => {

  try {
    const resp = await bd.query("SELECT expediente, di, nombre FROM empleado")

    emp = resp.rows

    res.render("reportes/empleados/exp", { emp })

  } catch (err) {
    console.error(err.stack)
  }
})

router.post("/reportes/empleados/exp", async (req, res) => {

  try {
    const { expediente } = req.body

    let resp

    if (expediente == "Todos")
      resp = await bd.query("SELECT expediente,di,nombre,nombre2,apellido,apellido2,"
        + " TO_CHAR(fecha_nacimiento,'DD-MM-YYYY') fecha_nacimiento,"
        + " (CASE genero "
        + " WHEN 'M' THEN 'Masculino'"
        + " WHEN 'F' THEN 'Femenino'"
        + " WHEN 'T' THEN 'Transgenero'"
        + " END) genero,"
        + " tipo_sangre,"
        + " (CASE titulo"
        + " WHEN 'B' THEN 'Bachiller'"
        + " WHEN 'Q' THEN 'Ing.Quimico'"
        + " WHEN 'M' THEN 'Ing.Mecanico'"
        + " WHEN 'P' THEN 'Ing.Planta'"
        + " WHEN 'G' THEN 'Geologo'"
        + " WHEN 'I' THEN 'Ing.Industrial'"
        + " END) titulo,"
        + "(SELECT CONCAT(cod,num) FROM telefono"
        + " WHERE expediente = fk_empleado ORDER BY cod ASC LIMIT 1) telefono,"
        + " fk_supervisor"
        + " FROM empleado ORDER BY expediente")
    else
      resp = await bd.query("SELECT expediente,di,nombre,nombre2,apellido,apellido2,"
        + " TO_CHAR(fecha_nacimiento,'DD-MM-YYYY') fecha_nacimiento,"
        + " (CASE genero "
        + " WHEN 'M' THEN 'Masculino'"
        + " WHEN 'F' THEN 'Femenino'"
        + " WHEN 'T' THEN 'Transgenero'"
        + " END) genero,"
        + " tipo_sangre,"
        + " (CASE titulo"
        + " WHEN 'B' THEN 'Bachiller'"
        + " WHEN 'Q' THEN 'Ing.Quimico'"
        + " WHEN 'M' THEN 'Ing.Mecanico'"
        + " WHEN 'P' THEN 'Ing.Planta'"
        + " WHEN 'G' THEN 'Geologo'"
        + " WHEN 'I' THEN 'Ing.Industrial'"
        + " END) titulo,"
        + "(SELECT CONCAT(cod,num) FROM telefono"
        + " WHERE expediente = fk_empleado ORDER BY cod ASC LIMIT 1) telefono,"
        + " fk_supervisor"
        + " FROM empleado WHERE expediente = $1 ORDER BY expediente", [expediente])

    const info = resp.rows

    redata(info, "Hke5bRhGbB", res);

  } catch (err) {
    console.error(err.stack)
  }
})

router.get("/reportes/empleados/exp_det", async (req, res) => {

  try {
    const resp = await bd.query("SELECT expediente, di, nombre FROM empleado")

    emp = resp.rows

    res.render("reportes/empleados/exp_det", { emp })

  } catch (err) {
    console.error(err.stack)
  }
})

router.post("/reportes/empleados/exp_det", async (req, res) => {

  try {
    const { expediente } = req.body

    let resp

    if (expediente == "Todos")
      resp = await bd.query("SELECT id, TO_CHAR(fecha,'DD-MM-YYYY') fecha,"
        + " (CASE motivo WHEN 'IN' THEN 'Inasistencia'"
        + " WHEN 'BM' THEN 'Bono mensual'"
        + " WHEN 'BA' THEN 'Bono anual'"
        + " WHEN 'AM' THEN 'Amonestacion'"
        + " WHEN 'RE' THEN 'Minutos de retraso'"
        + " WHEN 'HE' THEN 'Horas extras' END) motivo,"
        + " fk_empleado,descripcion,monto_bono,horas_extras,retraso"
        + " FROM detalle_exp ORDER BY fk_empleado")
    else
      resp = await bd.query("SELECT id, TO_CHAR(fecha,'DD-MM-YYYY') fecha,"
        + " (CASE motivo WHEN 'IN' THEN 'Inasistencia'"
        + " WHEN 'BM' THEN 'Bono mensual'"
        + " WHEN 'BA' THEN 'Bono anual'"
        + " WHEN 'AM' THEN 'Amonestacion'"
        + " WHEN 'RE' THEN 'Minutos de retraso'"
        + " WHEN 'HE' THEN 'Horas extras' END) motivo,"
        + " fk_empleado,descripcion,monto_bono,horas_extras,retraso"
        + " FROM detalle_exp WHERE fk_empleado = $1 ORDER BY fk_empleado", [expediente])

    const info = resp.rows

    redata(info, "ByeYr6JQ-S", res);

  } catch (err) {
    console.error(err.stack)
  }
})

router.get("/reportes/empleados/horneros", async (req, res) => {

  try {

    const resp = await bd.query("SELECT expediente, di, nombre FROM empleado, empleo"
    + " WHERE expediente = fk_empleado AND fecha_fin IS NULL AND fk_organigrama = 10")

    emp = resp.rows

    res.render("reportes/empleados/horneros", { emp })

  } catch (err) {
    console.error(err.stack)
  }
})

router.post("/reportes/empleados/horneros", async (req, res) => {

  try {
    const { expediente } = req.body

    let resp

    if (expediente == "Todos")
    resp = await bd.query("SELECT e.expediente, e.nombre, t.turno,EXTRACT(MONTH FROM d.fecha) mes,EXTRACT(YEAR FROM d.fecha) ano, d.retraso, d.horas_extras"
      + " FROM empleado e, empleo em, detalle_exp d, turnos_hist t"
      + " WHERE e.expediente = em.fk_empleado"
      + " AND  em.fk_organigrama = 10"
      + " AND e.expediente = d.fk_empleado"
      + " AND (d.retraso IS NOT NULL OR d.horas_extras IS NOT NULL)"
      + " AND em.fecha_inicio = t.fk_empleo"
      + " AND em.fk_empleado = t.fk_empleado"
      + " AND d.fecha BETWEEN t.fecha_inicio AND t.fecha_fin"
      + " ORDER BY expediente ASC, ano ASC, mes ASC")
      else
      resp = await bd.query("SELECT e.expediente, e.nombre, t.turno,EXTRACT(MONTH FROM d.fecha) mes,EXTRACT(YEAR FROM d.fecha) ano, d.retraso, d.horas_extras"
      + " FROM empleado e, empleo em, detalle_exp d, turnos_hist t"
      + " WHERE e.expediente = em.fk_empleado"
      + " AND  em.fk_organigrama = 10"
      + " AND e.expediente = d.fk_empleado"
      + " AND (d.retraso IS NOT NULL OR d.horas_extras IS NOT NULL)"
      + " AND em.fecha_inicio = t.fk_empleo"
      + " AND em.fk_empleado = t.fk_empleado"
      + " AND d.fecha BETWEEN t.fecha_inicio AND t.fecha_fin"
      + " AND e.expediente = $1"
      + " ORDER BY expediente ASC, ano ASC, mes ASC",[expediente])

    const info = resp.rows

    redata(info, "SJx9a8lXWr", res);

  } catch (err) {
    console.error(err.stack)
  }
})

router.get("/reportes/empleados/casis", async (req, res) => {

  try {

    const resp = await bd.query("SELECT s.expediente, s.di, s.nombre FROM empleado s"
      + " WHERE EXISTS(SELECT e.expediente FROM empleado e WHERE e.fk_supervisor = s.expediente)")

    sup = resp.rows

    res.render("reportes/empleados/supers", { sup })

  } catch (err) {
    console.error(err.stack)
  }
})

router.post("/reportes/empleados/casis", async (req, res) => {

  try {
    const { expediente } = req.body

    const resp = await bd.query("SELECT expediente, nombre, apellido FROM empleado"
      + " WHERE fk_supervisor = $1", [expediente])

    const info = resp.rows

    redata(info, "S15fX6QbH", res);

  } catch (err) {
    console.error(err.stack)
  }
})

router.get("/reportes/empleados/minuta", async (req, res) => {

  try {

    const resp = await bd.query("SELECT s.expediente, s.di, s.nombre FROM empleado s"
      + " WHERE EXISTS(SELECT e.expediente FROM empleado e WHERE e.fk_supervisor = s.expediente)")

    sup = resp.rows

    res.render("reportes/empleados/minuta", { sup })

  } catch (err) {
    console.error(err.stack)
  }
})

router.post("/reportes/empleados/minuta", async (req, res) => {

  try {
    const { expediente } = req.body

    const resp = await bd.query("SELECT e.expediente, e.nombre, r.id, TO_CHAR(r.fecha,'DD-MM-YYYY') fecha,"
    + " r.minuta FROM empleado e, reunion r"
      + " WHERE r.fk_supervisor = e.expediente AND e.expediente = $1 ORDER BY r.fecha desc", [expediente])

    const info = resp.rows

    redata(info, "S1xqxv6NbB", res);

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