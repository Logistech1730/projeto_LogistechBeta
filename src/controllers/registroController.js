var esteiraModel = require("../models/esteiraModel");

function listarTodosRegistros(req, res) {
    var fkEmpresa = req.params.fkEmpresa;

    if (fkEmpresa == undefined) {
        res.status(400).send("ID da empresa indefinido");
     } else {
        esteiraModel.listarTodosRegistros(fkEmpresa)
        .then(
            function (resultado) {
                res.status(200).json(resultado);
            }
        )
        .catch(function (erro) {
            console.log(erro);
            console.log(
                "\nHouve um erro ao listar esteiras! Erro: ",
                erro.sqlMessage
            );
            res.status(500).json(erro.sqlMessage);
        })
     }


}
module.exports = {
    listarTodasEsteiras
}