var express = require("express");
var router = express.Router();

var alertaController = require("../controllers/alertaController");

router.get("/listar/:fkEmpresa", function (req, res) {
    alertaController.listarTodosAlertas(req, res);
})

module.exports = router;