var express = require("express");
var router = express.Router();

// Aqui criamos uma referência à Controller de Esteira (já que usamos um método que está nesse arquivo)
var esteiraController = require("../controllers/esteiraController");

//Aqui eu defino que minha rota /cadastrar receberá uma requisição do tipo "POST", que receberá 2 argumentos (req, res) 
// e que redirecionará esses argumentos para a função "cadastrar" da página esteiraController
router.post("/cadastrar", function (req, res) {
    esteiraController.cadastrar(req, res);
})

router.get("/listar/:fkEmpresa", function (req, res) {
    esteiraController.listarTodasEsteiras(req, res);
})

router.get("/deletarEsteira/:idEsteira", function (req, res) {
    esteiraController.deletarEsteira(req, res);
})

module.exports = router;