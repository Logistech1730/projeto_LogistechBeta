CREATE DATABASE logistech;
USE logistech;

CREATE TABLE empresa(
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
cnpj CHAR(14),
telefone CHAR(12),
nomeFantasia VARCHAR(45),
dataCadastro DATETIME DEFAULT current_timestamp,
isAtivo TINYINT DEFAULT 0,
CONSTRAINT chk_ativo CHECK(isAtivo IN(0, 1))
);




CREATE TABLE usuario(
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
email VARCHAR(45),
senha VARCHAR(45),
nivel INT default 0,
dataCadastro DATETIME DEFAULT current_timestamp,
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
nome VARCHAR(50),
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
dataCadastro DATETIME DEFAULT (CURRENT_TIMESTAMP),
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
distancia INT,
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

-- criação do TRIGGER de geração de alerta
DELIMITER $$

CREATE TRIGGER after_insert_registro
AFTER INSERT ON registro
FOR EACH ROW
BEGIN
    -- Variável para armazenar a distância esperada da esteira
    DECLARE distancia_esperada INT;
    
    -- Buscar a distância esperada da esteira associada ao sensor
    SELECT e.distanciaEsperada
    INTO distancia_esperada
    FROM esteira e
    JOIN sensor s ON s.fkEsteira = e.idEsteira
    WHERE s.idSensor = NEW.fkSensor;
    
    -- Verificar se a distância registrada é diferente da distância esperada
    IF NEW.distancia != distancia_esperada THEN
        -- Inserir um alerta na tabela Alerta, caso as distâncias sejam diferentes
        INSERT INTO Alerta (fkRegistro, visto)
        VALUES (NEW.idRegistro, 0);
    END IF;
END $$

DELIMITER ;

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



-- INSERTS PARA A APRESENTAÇÃO

-- Inserir empresas
INSERT INTO empresa (cnpj, telefone, nomeFantasia, isAtivo) VALUES
('12345678000101', '11987654321', 'Tech Solutions Ltda', 1),
('98765432000101', '21976543210', 'Alpha Construtora', 1),
('11111111000111', '31965432109', 'Beta Consultoria', 1),
('22222222000222', '41954321098', 'Gamma Service', 1),
('33333333000333', '51943210987', 'Delta Logística', 1);

-- Inserir usuarios para cada empresa
INSERT INTO usuario (nome, email, senha, nivel, fkEmpresa) VALUES
('Carlos Silva', 'carlos.silva@techsolutions.com', 'senha123', 1, 1),
('Mariana Costa', 'mariana.costa@alphaconstrutora.com', 'senha123', 1, 2),
('João Almeida', 'joao.almeida@betaconsultoria.com', 'senha123', 1, 3),
('Ana Santos', 'ana.santos@gamma.com', 'senha123', '41954321099', 1, 4),
('Lucas Pereira', 'lucas.pereira@deltalogistica.com', 'senha123', 1, 5),
('Vitor Ameida', 'vitor.almeida@logistechsuporte.com', 'senha123', 1, 5);

-- Inserir endereços para cada empresa
INSERT INTO endereco (cep, logradouro, cidade, UF, numero, complemento, fkEmpresa) VALUES
('12345678', 'Rua das Inovações, 101', 'São Paulo', 'SP', '101', 'Prédio A', 1),
('87654321', 'Avenida dos Engenheiros, 202', 'Rio de Janeiro', 'RJ', '202', 'Bloco B', 2),
('11112222', 'Rua das Consultorias, 303', 'Belo Horizonte', 'MG', '303', 'Sala 12', 3),
('22223333', 'Estrada da Alimentação, 404', 'Curitiba', 'PR', '404', 'Galpão 7', 4),
('33334444', 'Avenida da Logística, 505', 'Porto Alegre', 'RS', '505', 'Andar 2', 5);


-- Inserir esteiras para a empresa 1
INSERT INTO esteira (nome, departamento, localizacao, distanciaEsperada, fkEmpresa) VALUES
('Esteira Mouse', 'Montagem', 'Bloco A1', 20, 1),
('Esteira Teclado', 'Montagem', 'Bloco A2', 25, 1),
('Esteira Monitor', 'Qualidade', 'Bloco A3', 30, 1),
('Esteira Placa Mãe', 'Produção', 'Bloco A4', 40, 1),
('Esteira Processador', 'Finalização', 'Bloco A5', 10, 1);

-- Inserir esteiras para a empresa 2
INSERT INTO esteira (nome, departamento, localizacao, distanciaEsperada, fkEmpresa) VALUES
('Esteira Cabos USB', 'Montagem', 'Bloco B1', 15, 2),
('Esteira HD Externo', 'Armazenamento', 'Bloco B2', 30, 2),
('Esteira SSD', 'Qualidade', 'Bloco B3', 20, 2),
('Esteira Fonte', 'Produção', 'Bloco B4', 35, 2),
('Esteira Memória RAM', 'Finalização', 'Bloco B5', 45, 2);

-- Inserir esteiras para a empresa 3
INSERT INTO esteira (nome, departamento, localizacao, distanciaEsperada, fkEmpresa) VALUES
('Esteira Impressora', 'Montagem', 'Bloco C1', 25, 3),
('Esteira Scanner', 'Qualidade', 'Bloco C2', 20, 3),
('Esteira Webcam', 'Produção', 'Bloco C3', 30, 3),
('Esteira Microfone', 'Finalização', 'Bloco C4', 35, 3),
('Esteira Caixa de Som', 'Montagem', 'Bloco C5', 50, 3);

-- Inserir esteiras para a empresa 4
INSERT INTO esteira (nome, departamento, localizacao, distanciaEsperada, fkEmpresa) VALUES
('Esteira Joystick', 'Montagem', 'Bloco D1', 15, 4),
('Esteira Controle', 'Produção', 'Bloco D2', 25, 4),
('Esteira Console', 'Qualidade', 'Bloco D3', 40, 4),
('Esteira Adaptador HDMI', 'Finalização', 'Bloco D4', 20, 4),
('Esteira Gamepad', 'Montagem', 'Bloco D5', 30, 4);

-- Inserir esteiras para a empresa 5
INSERT INTO esteira (nome, departamento, localizacao, distanciaEsperada, fkEmpresa) VALUES
('Esteira Projetor', 'Montagem', 'Bloco E1', 50, 5),
('Esteira Smart TV', 'Qualidade', 'Bloco E2', 60, 5),
('Esteira Chromecast', 'Produção', 'Bloco E3', 40, 5),
('Esteira Soundbar', 'Finalização', 'Bloco E4', 35, 5),
('Esteira Subwoofer', 'Montagem', 'Bloco E5', 45, 5);

-- Inserir métricas com intervalos aleatórios e não sobrepostos
INSERT INTO metrica (nomeMetrica, valorMinimo, valorMaximo, cor, fkEsteira) VALUES
-- Esteira 1
('Baixo', 0, 25, '00FF00', 1),
('Moderado', 26, 60, 'FFFF00', 1),
('Alto', 61, 100, 'FF0000', 1),

-- Esteira 2
('Normal', 0, 20, '00FF00', 2),
('Atenção', 21, 70, 'FFFF00', 2),
('Crítico', 71, 100, 'FF0000', 2),

-- Esteira 3
('Ideal', 0, 35, '00FF00', 3),
('Risco', 36, 85, 'FFFF00', 3),
('Emergência', 86, 100, 'FF0000', 3),

-- Esteira 4
('Estável', 0, 30, '00FF00', 4),
('Instável', 31, 75, 'FFFF00', 4),
('Perigoso', 76, 100, 'FF0000', 4),

-- Esteira 5
('Aceitável', 0, 40, '00FF00', 5),
('Atenção', 41, 80, 'FFFF00', 5),
('Problema', 81, 100, 'FF0000', 5),

-- Esteira 6
('Leve', 0, 20, '00FF00', 6),
('Moderado', 21, 65, 'FFFF00', 6),
('Severo', 66, 100, 'FF0000', 6),

-- Esteira 7
('Segura', 0, 30, '00FF00', 7),
('Instável', 31, 70, 'FFFF00', 7),
('Crítica', 71, 100, 'FF0000', 7),

-- Esteira 8
('Baixo Risco', 0, 15, '00FF00', 8),
('Risco Médio', 16, 70, 'FFFF00', 8),
('Risco Alto', 71, 100, 'FF0000', 8),

-- Esteira 9
('Nível 1', 0, 40, '00FF00', 9),
('Nível 2', 41, 85, 'FFFF00', 9),
('Nível 3', 86, 100, 'FF0000', 9),

-- Esteira 10
('Segura', 0, 33, '00FF00', 10),
('Alerta', 34, 70, 'FFFF00', 10),
('Crítica', 71, 100, 'FF0000', 10);


-- Inserir sensores para cada esteira
INSERT INTO sensor (dataInstalacao, ultimaManutencao, fkEsteira) VALUES
('2024-11-03', NULL, 1),
('2024-11-07', NULL, 2),
('2024-11-12', NULL, 3),
('2024-11-15', NULL, 4),
('2024-11-19', NULL, 5),
('2024-11-22', NULL, 6),
('2024-11-25', NULL, 7),
('2024-11-26', NULL, 8),
('2024-11-27', NULL, 9),
('2024-11-29', NULL, 10),
('2024-11-01', NULL, 11),
('2024-11-05', NULL, 12),
('2024-11-08', NULL, 13),
('2024-11-10', NULL, 14),
('2024-11-13', NULL, 15),
('2024-11-16', NULL, 16),
('2024-11-18', NULL, 17),
('2024-11-20', NULL, 18),
('2024-11-23', NULL, 19),
('2024-11-24', NULL, 20),
('2024-11-28', NULL, 21),
('2024-11-02', NULL, 22),
('2024-11-04', NULL, 23),
('2024-11-06', NULL, 24),
('2024-11-09', NULL, 25);



-- Gerar registros para cada sensor
INSERT INTO registro (distancia, isProdutoViavel, fkSensor) VALUES
-- Sensor 1
(20, 1, 1), (22, 1, 1), (18, 1, 1), (25, 0, 1), (30, 0, 1),
(19, 1, 1), (21, 1, 1), (35, 0, 1), (23, 1, 1), (40, 0, 1),

-- Sensor 2
(25, 1, 2), (26, 1, 2), (24, 1, 2), (20, 0, 2), (27, 0, 2),
(23, 1, 2), (25, 1, 2), (28, 0, 2), (30, 0, 2), (29, 0, 2),

-- Sensor 3
(30, 1, 3), (32, 1, 3), (28, 1, 3), (35, 0, 3), (40, 0, 3),
(29, 1, 3), (31, 1, 3), (38, 0, 3), (34, 0, 3), (33, 1, 3),

-- Sensor 4
(40, 1, 4), (38, 1, 4), (42, 1, 4), (45, 0, 4), (50, 0, 4),
(39, 1, 4), (41, 1, 4), (48, 0, 4), (43, 1, 4), (47, 0, 4),

-- Sensor 5
(50, 1, 5), (48, 1, 5), (52, 1, 5), (55, 0, 5), (60, 0, 5),
(49, 1, 5), (51, 1, 5), (58, 0, 5), (53, 1, 5), (57, 0, 5);
