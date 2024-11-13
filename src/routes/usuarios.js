var express = require("express");
var router = express.Router();

// Aqui criamos uma referência à Controller de usuário (já que usamos um método que está nesse arquivo)
var usuarioController = require("../controllers/usuarioController");

//Aqui eu defino que minha rota /cadastrar receberá uma requisição do tipo "POST", que receberá 2 argumentos (req, res) 
// e que redirecionará esses argumentos para a função "cadastrar" da página usuarioController
router.post("/cadastrar", function (req, res) {
    usuarioController.cadastrar(req, res);
})

router.post("/autenticar", function (req, res) {
    usuarioController.autenticar(req, res);
});

module.exports = router;