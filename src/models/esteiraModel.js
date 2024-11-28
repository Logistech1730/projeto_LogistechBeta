var database = require("../database/config")


// Coloque os mesmos parâmetros aqui. Vá para a var instrucaoSql
function cadastrar(departamento, localizacao, distanciaEsperada, fkEmpresa) {
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucaoSql = `
        INSERT INTO esteira (departamento, localizacao, distanciaEsperada, fkEmpresa) VALUES ('${departamento}', '${localizacao}', '${distanciaEsperada}', '${fkEmpresa}');`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarTodasEsteiras(fkEmpresa) {
    var instrucaoSql = `
    SELECT departamento, localizacao, distanciaEsperada, nomeFantasia FROM esteira JOIN empresa ON fkEmpresa = idEmpresa WHERE fkEmpresa = ${fkEmpresa};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function deletarEsteira(idEsteira) {
    var instrucaoSql = `
    DELETE FROM esteira WHERE idEsteira = ${idEsteira};
    `;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    cadastrar,
    listarTodasEsteiras,
    deletarEsteira,
};