var express = require("express");
var router = express.Router();

var registroController = require("../controllers/registroController");

router.get("/listar/:fkEmpresa", function (req, res) {
    registroController.listarTodosRegistros(req, res);
})

module.exports = router;