CREATE DATABASE logistech;
USE logistech;

CREATE TABLE empresa(
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
cnpj CHAR(14),
telefone CHAR(9),
nomeFantasia VARCHAR(45),
dataCadastro DATETIME DEFAULT current_timestamp,
isAtivo TINYINT,
CONSTRAINT chk_ativo CHECK(isAtivo IN(0, 1))
);


CREATE TABLE usuario(
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
email VARCHAR(45),
senha VARCHAR(45),
telefone VARCHAR(45),
nivel INT default 0,
fkEmpresa INT,
CONSTRAINT fkUsuarioEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
ON DELETE CASCADE
);


CREATE TABLE endereco(
idEndereco INT PRIMARY KEY AUTO_INCREMENT,
cep CHAR(8),
logradouro VARCHAR(200),
cidade VARCHAR(90),
UF CHAR(2),
numero CHAR(5),
complemento VARCHAR(50),
fkEmpresa INT,
CONSTRAINT fkEnderecoEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
ON DELETE CASCADE

);

CREATE TABLE esteira(
idEsteira INT PRIMARY KEY AUTO_INCREMENT,
departamento VARCHAR(50),
localizacao VARCHAR(50),
distanciaEsperada INT,
fkEmpresa INT,
CONSTRAINT fkEsteiraEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
ON DELETE CASCADE
);

CREATE TABLE metrica (
idMetrica INT PRIMARY KEY AUTO_INCREMENT,
nomeMetrica VARCHAR(50),
valorMinimo DOUBLE,
valorMaximo DOUBLE,
dataCadastro DATE,
cor CHAR(6),
fkEsteira INT,
CONSTRAINT fkMetricaEsteira FOREIGN KEY (fkEsteira) REFERENCES esteira (idEsteira)
ON DELETE CASCADE
);

CREATE TABLE sensor(
idSensor INT PRIMARY KEY AUTO_INCREMENT,
dataInstalacao DATE,
ultimaManutencao DATE,
fkEsteira INT,
CONSTRAINT fkSensorEsteira FOREIGN KEY (fkEsteira) REFERENCES esteira(idEsteira)
ON DELETE CASCADE
);

CREATE TABLE registro(
idRegistro INT PRIMARY KEY AUTO_INCREMENT,
distancia DOUBLE,
dataRegistro DATETIME DEFAULT CURRENT_TIMESTAMP(),
isProdutoViavel TINYINT,
CONSTRAINT chkProduto CHECK(isProdutoViavel IN(0,1)),
fkSensor INT,
CONSTRAINT fkRegistroSensor FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor)
ON DELETE CASCADE
);

CREATE TABLE Alerta
(idAlerta INT AUTO_INCREMENT,
fkRegistro INT,
visto BIT DEFAULT 0,
PRIMARY KEY (IdAlerta, fkRegistro),
CONSTRAINT fkRegistroAlerta FOREIGN KEY (fkRegistro) REFERENCES registro (idRegistro)
ON DELETE CASCADE
);

-- Inserções na tabela 'empresa'
INSERT INTO empresa (cnpj, telefone, nomeFantasia, isAtivo) VALUES 
('12345678000195', '123456789', 'Empresa A', 1),
('98765432000185', '987654321', 'Empresa B', 1),
('19283746000172', '192837465', 'Empresa C', 0),
('45678912000156', '456789123', 'Empresa D', 1),
('32165498000123', '321654987', 'Empresa E', 0);

-- Inserções na tabela 'usuario'
INSERT INTO usuario (nome, email, senha, telefone, fkEmpresa) VALUES 
('João Silva', 'joao@empresaA.com', 'senha123', '999999999', 1),
('Maria Santos', 'maria@empresaB.com', 'senha456', '988888888', 2),
('Pedro Costa', 'pedro@empresaC.com', 'senha789', '977777777', 3),
('Ana Lima', 'ana@empresaD.com', 'senha321', '966666666', 4),
('Carlos Souza', 'carlos@empresaE.com', 'senha654', '955555555', 5);

-- Inserções na tabela 'endereco'
INSERT INTO endereco (cep, logradouro, cidade, UF, numero, complemento, fkEmpresa) VALUES 
('12345678', 'Rua A', 'São Paulo', 'SP', '123', 'Apt 1', 1),
('87654321', 'Rua B', 'Rio de Janeiro', 'RJ', '456', 'Casa 2', 2),
('56781234', 'Rua C', 'Belo Horizonte', 'MG', '789', 'Apt 3', 3),
('43218765', 'Rua D', 'Salvador', 'BA', '321', 'Casa 4', 4),
('23456781', 'Rua E', 'Fortaleza', 'CE', '654', 'Apt 5', 5);

-- Inserções na tabela 'esteira'
INSERT INTO esteira (departamento, localizacao, distanciaEsperada, fkEmpresa) VALUES 
('Logística', 'Depósito A', 100, 1),
('Produção', 'Depósito B', 200, 1),
('Expedição', 'Depósito C', 150, 2),
('Armazenagem', 'Depósito D', 250, 2),
('Distribuição', 'Depósito E', 300, 2);

-- Inserções na tabela 'sensor'
INSERT INTO sensor (dataInstalacao, ultimaManutencao, fkEsteira) VALUES 
('2024-01-01', '2024-07-01', 1),
('2023-05-15', '2024-05-15', 2),
('2022-11-20', '2023-11-20', 3),
('2024-06-10', '2024-09-10', 4),
('2023-03-30', '2024-03-30', 5);

SELECT 
    esteira.departamento AS 'Esteira', registro.distancia as 'distancia', registro.dataRegistro AS 'Data',
    CASE 
        WHEN Alerta.visto = 1 THEN 'Sim'
        ELSE 'Não'
    END AS 'Visto' FROM Alerta 
    JOIN registro ON Alerta.fkRegistro = registro.idRegistro
	JOIN sensor ON registro.fkSensor = sensor.idSensor
	JOIN esteira ON sensor.fkEsteira = esteira.idEsteira
    JOIN empresa on esteira.fkEmpresa = empresa.idEmpresa
    WHERE empresa.idEmpresa = 1
    ORDER BY registro.dataRegistro DESC;
-- Inserções na tabela 'registro'
INSERT INTO registro (distancia, fkSensor) VALUES 
(10, 1),
(10, 1),
(10, 1),
(10, 1),
(10, 1),
(10, 1),
(10, 2),
(10, 2),
(10, 2),
(10, 2),
(12, 2),
(12, 2);

-- Inserções na tabela alertas
INSERT INTO Alerta (fkRegistro, visto) VALUES
(1, 1), 
(2, 0); 


-- 1. Listar todas as empresas ativas
SELECT idEmpresa, nomeFantasia, cnpj, telefone FROM empresa WHERE isAtivo = 1;

-- 2. Buscar usuários e as respectivas empresas
SELECT u.nome AS NomeUsuario, u.email, e.nomeFantasia AS Empresa FROM usuario u
	JOIN empresa e ON u.fkEmpresa = e.idEmpresa;

-- 3. Listar todos os sensores instalados em uma empresa específica
SELECT s.idSensor, s.dataInstalacao, s.ultimaManutencao, e.nomeFantasia AS Empresa FROM sensor s
	JOIN esteira es ON s.fkEsteira = es.idEsteira
	JOIN empresa e ON es.fkEmpresa = e.idEmpresa
	WHERE e.idEmpresa = 1; 
    

-- 4. Exibir registros de sensores com data e hora
SELECT r.idRegistro, r.distancia, r.dataRegistro, s.idSensor FROM registro r
	JOIN sensor s ON r.fkSensor = s.idSensor
	ORDER BY r.dataRegistro DESC;

-- 5. Listar esteiras e seus sensores associados para uma empresa
SELECT es.idEsteira, es.departamento, es.localizacao, s.idSensor, s.dataInstalacao FROM esteira es
	LEFT JOIN sensor s ON es.idEsteira = s.fkEsteira
	WHERE es.fkEmpresa = 1;  
    
UPDATE registro SET isProdutoViavel = 1 WHERE distancia = 15;

SELECT idRegistro, distancia, dataRegistro, CASE WHEN isProdutoViavel = 1 THEN 'Produto Viável' ELSE 'Produto inViável' END AS 'Produto Válido' FROM registro;


SELECT * FROM Registro;
-- Select de quantidade de produtos válidos
SELECT COUNT(idRegistro) AS 'Produtos válidos' FROM registro WHERE distancia = 10;
-- Select de quantidade de produtos inválidos
SELECT COUNT(idRegistro) AS 'Produtos inválidos' FROM registro WHERE distancia != 10;

-- SELECT da porcentagem de produtos válidos VS inválidos
SELECT CONCAT(((SELECT COUNT(idRegistro) AS 'Produtos válidos' FROM registro WHERE distancia = 10) 
/
(SELECT COUNT(idRegistro) FROM registro)) * 100, '%')  AS 'Porcentagem de produtos válidos';

 -- select de porcentagem de produtos inválidos
 SELECT CONCAT(((SELECT COUNT(idRegistro) AS 'Produtos inválidos' FROM registro WHERE distancia != 10) 
/
(SELECT COUNT(idRegistro) FROM registro)) * 100, '%')  AS 'Porcentagem de produtos inválidos';

-- SELECT DE TOTAL DE Produtos por esteira
SELECT esteira.localizacao, COUNT(idRegistro) as 'Quantidade de produtos' FROM Registro 
JOIN Sensor on fkSensor = idSensor
JOIN Esteira on fkEsteira = idEsteira
WHERE fkEsteira = 1;

-- SELECT TOTAL DE PRODUTOS DE MAIS DE 1 ESTEIRA
SELECT COUNT(idRegistro) as 'Quantidade de produtos' FROM Registro 
JOIN Sensor on fkSensor = idSensor
JOIN Esteira on fkEsteira = idEsteira
WHERE fkEsteira = 1 OR fkEsteira = 2;

-- SELECT Alertas 
select * from Alerta;

-- SELECT Alertas não vistos
SELECT * FROM Alerta WHERE visto = 0;

-- Selecionar alertas não vistos e suas respectivas esteiras
SELECT idAlerta, visto, dataRegistro, esteira.localizacao FROM Alerta
JOIN Registro on fkRegistro = idRegistro
JOIN Sensor on fkSensor = idSensor
JOIN esteira ON fkEsteira = idEsteira
WHERE visto = 0;




