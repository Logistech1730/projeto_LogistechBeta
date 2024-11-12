CREATE DATABASE logistech;
USE logistech;

CREATE TABLE empresa(
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
cnpj CHAR(14),
telefone CHAR(11),
nomeFantasia VARCHAR(45),
isAtivo TINYINT,
CONSTRAINT chk_ativo CHECK(isAtivo IN(0, 1))
);

CREATE TABLE usuario(
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
email VARCHAR(45),
senha VARCHAR(45),
telefone VARCHAR(45),
fkEmpresa INT,
CONSTRAINT fkUsuarioEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
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
);

CREATE TABLE esteira(
idEsteira INT PRIMARY KEY AUTO_INCREMENT,
departamento VARCHAR(50),
localizacao VARCHAR(50),
distanciaEsperada INT,
fkEmpresa INT,
CONSTRAINT fkEsteiraEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE sensor(
idSensor INT PRIMARY KEY AUTO_INCREMENT,
dataInstalacao DATE,
ultimaManutencao DATE,
fkEsteira INT,
CONSTRAINT fkSensorEsteira FOREIGN KEY (fkEsteira) REFERENCES esteira(idEsteira)
);

CREATE TABLE registro(
idRegistro INT PRIMARY KEY AUTO_INCREMENT,
distancia INT,
dataRegistro DATETIME DEFAULT CURRENT_TIMESTAMP(),
fkSensor INT,
CONSTRAINT fkRegistroSensor FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor)
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
('Produção', 'Depósito B', 200, 2),
('Expedição', 'Depósito C', 150, 3),
('Armazenagem', 'Depósito D', 250, 4),
('Distribuição', 'Depósito E', 300, 5);

-- Inserções na tabela 'sensor'
INSERT INTO sensor (dataInstalacao, ultimaManutencao, fkEsteira) VALUES 
('2024-01-01', '2024-07-01', 1),
('2023-05-15', '2024-05-15', 2),
('2022-11-20', '2023-11-20', 3),
('2024-06-10', '2024-09-10', 4),
('2023-03-30', '2024-03-30', 5);

-- Inserções na tabela 'registro' - Será feito pela API - Somente para Visualização
INSERT INTO registro (distancia, fkSensor) VALUES 
(120, 1),
(210, 2),
(140, 3),
(260, 4),
(320, 5);

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