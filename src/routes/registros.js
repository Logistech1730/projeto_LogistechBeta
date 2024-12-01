var express = require("express");
var router = express.Router();

var registroController = require("../controllers/registroController");

router.get("/listar/:fkEmpresa", function (req, res) {
    registroController.listarTodosRegistros(req, res);
})

router.get("/listarValidosInvalidosTotalEmpresa/:fkEmpresa", function (req, res) {
    registroController.listarProdutosValidosInvalidosTotalEmpresa(req, res);
})

router.post("/listarPorData/:fkEmpresa", function (req, res) {
    registroController.listarRegistrosPorData(req, res);
})


module.exports = router;