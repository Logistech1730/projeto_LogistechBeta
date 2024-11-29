var database = require("../database/config")

function listarTodosRegistros(fkEmpresa) {
    var instrucaoSql = `
    SELECT esteira.departamento AS Esteira, registro.distancia AS AlturaDetectada, registro.dataRegistro AS DataRegistro 
    FROM esteira JOIN sensor ON sensor.fkEsteira = esteira.idEsteira JOIN registro ON registro.fkSensor = sensor.idSensor 
    JOIN empresa ON esteira.fkEmpresa = empresa.idEmpresa WHERE empresa.idEmpresa = ${fkEmpresa} ORDER BY registro.dataRegistro;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    listarTodosRegistros
};