var database = require("../database/config")

function listarTodosRegistros(fkEmpresa) {
    var instrucaoSql = `
    SELECT esteira.departamento AS Esteira, registro.distancia AS AlturaDetectada, registro.dataRegistro AS DataRegistro 
    FROM esteira JOIN sensor ON sensor.fkEsteira = esteira.idEsteira JOIN registro ON registro.fkSensor = sensor.idSensor 
    JOIN empresa ON esteira.fkEmpresa = empresa.idEmpresa WHERE empresa.idEmpresa = ${fkEmpresa} ORDER BY registro.dataRegistro DESC;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarRegistrosPorData(dataInicial, dataFinal, fkEmpresa) {
    var instrucaoSql = `
    SELECT 
    esteira.departamento AS Esteira, registro.distancia AS AlturaDetectada, registro.dataRegistro AS DataRegistro FROM esteira JOIN sensor ON sensor.fkEsteira = esteira.idEsteira JOIN registro ON registro.fkSensor = sensor.idSensor JOIN empresa ON esteira.fkEmpresa = empresa.idEmpresa WHERE empresa.idEmpresa = ${fkEmpresa} AND registro.dataRegistro BETWEEN '${dataInicial}' AND '${dataFinal}' ORDER BY registro.dataRegistro;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql); 
}

function listarProdutosValidosInvalidosTotalEmpresa(fkEmpresa) {
    var instrucaoSql = `
    SELECT 
    COUNT(CASE WHEN r.distancia = e.distanciaEsperada THEN 1 END) AS "ProdutosValidos",
    COUNT(CASE WHEN r.distancia <> e.distanciaEsperada THEN 1 END) AS "ProdutosInvalidos"
    FROM registro AS r
    JOIN sensor AS s ON r.fkSensor = s.idSensor
    JOIN esteira AS e ON s.fkEsteira = e.idEsteira
    JOIN empresa AS emp ON e.fkEmpresa = emp.idEmpresa
    WHERE emp.idEmpresa = ${fkEmpresa};
`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql); 
}

function listarProdutosValidosInvalidosPorSemanaEmpresa(fkEmpresa) {
    var instrucaoSql = `
    SELECT 
    DATE(r.dataRegistro) AS 'data',
    SUM(CASE WHEN r.distancia = e.distanciaEsperada THEN 1 ELSE 0 END) AS ProdutosValidos,
    SUM(CASE WHEN r.distancia <> e.distanciaEsperada THEN 1 ELSE 0 END) AS ProdutosInvalidos
    FROM registro AS r JOIN sensor AS s ON r.fkSensor = s.idSensor JOIN esteira AS e ON s.fkEsteira = e.idEsteira 
    JOIN empresa AS emp ON e.fkEmpresa = emp.idEmpresa WHERE emp.idEmpresa = 1 
    AND DATE(r.dataRegistro) >= CURRENT_DATE() - INTERVAL 6 DAY AND DATE(r.dataRegistro) < CURDATE() + INTERVAL 1 DAY GROUP BY DATE(r.dataRegistro) ORDER BY DATE(r.dataRegistro);
`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql); 
}

module.exports = {
    listarTodosRegistros,
    listarRegistrosPorData,
    listarProdutosValidosInvalidosTotalEmpresa,
    listarProdutosValidosInvalidosPorSemanaEmpresa
};