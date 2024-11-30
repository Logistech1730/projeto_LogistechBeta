var database = require("../database/config")

function listarTodosAlertas(fkEmpresa) {
    var instrucaoSql = `
   SELECT 
        esteira.departamento AS 'Esteira', 
        registro.distancia as 'distancia', 
        registro.dataRegistro AS 'Data',
        CASE 
            WHEN Alerta.visto = 1 THEN 'Sim'
            ELSE 'Não'
        END AS 'Visto',
        Alerta.idAlerta,  -- Adicionar o idAlerta aqui
        registro.idRegistro AS fkRegistro  -- Adicionar o fkRegistro aqui
        FROM Alerta 
        JOIN registro ON Alerta.fkRegistro = registro.idRegistro
        JOIN sensor ON registro.fkSensor = sensor.idSensor
        JOIN esteira ON sensor.fkEsteira = esteira.idEsteira
        JOIN empresa on esteira.fkEmpresa = empresa.idEmpresa
        WHERE empresa.idEmpresa = ${fkEmpresa}
ORDER BY registro.dataRegistro DESC;

    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function atualizarVisto(idAlerta, visto, fkRegistro) {
    var instrucaoSql = `
    UPDATE Alerta 
    SET visto = ${visto} 
    WHERE idAlerta = ${idAlerta} AND fkRegistro = ${fkRegistro};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);

    return database.executar(instrucaoSql);
}


module.exports = {
    listarTodosAlertas,
    atualizarVisto
};