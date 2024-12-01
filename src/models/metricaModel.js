var database = require("../database/config")


// Coloque os mesmos parâmetros aqui. Vá para a var instrucaoSql
function cadastrar(nome, valorMinimo, valorMaximo, cor, fkEsteira) {
    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucaoSql = `
        INSERT INTO metrica (nomeMetrica, valorMinimo, valorMaximo, cor, fkEsteira) VALUES ('${nome}', '${valorMinimo}', '${valorMaximo}', '${cor}', ${fkEsteira});`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function deletarMetrica(idMetrica) {
    var instrucaoSql = `delete from metrica where idMetrica = ${idMetrica}`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function verificarConflito(valorMinimo, valorMaximo, fkEsteira) {
    var instrucaoSql = `
        SELECT * 
        FROM metrica 
        WHERE fkEsteira = ${fkEsteira} 
          AND NOT (
              valorMaximo < ${valorMinimo} OR
              valorMinimo > ${valorMaximo}
          );
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function atualizar(nome, valorMaximo, valorMinimo, cor, idMetrica) {
    var instrucaoSql = `UPDATE metrica set nomeMetrica = '${nome}', valorMaximo = '${valorMaximo}', valorMinimo = '${valorMinimo}', cor = '${cor}' WHERE idMetrica = ${idMetrica};`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarMetricasPorEsteira(fkEsteira) {
    var instrucaoSql = `
   SELECT *
FROM metrica
WHERE fkEsteira = ${fkEsteira}
ORDER BY valorMinimo ASC, valorMaximo ASC;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarMetricasPorId(idMetrica) {
    var instrucaoSql = `
    SELECT * FROM metrica WHERE idMetrica = ${idMetrica};`;
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
    listarMetricasPorEsteira,
    deletarEsteira,
    verificarConflito,
    listarMetricasPorId,
    atualizar,
    deletarMetrica
};