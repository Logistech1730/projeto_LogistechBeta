CREATE DATABASE logistech;
USE logistech;

CREATE TABLE Cadastro (
idCadastro INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(30),
cpf CHAR(14),
cnpj CHAR(18),  -- Colocar como (essencial,  funcional)
data_nasc DATE,
senha CHAR(10),
email VARCHAR(50),
genero CHAR(1),
CONSTRAINT chkgenero CHECK(genero IN('F','M','O'))
);
DESCRIBE Cadastro;

INSERT INTO Cadastro VALUES 
(DEFAULT, 'Matheus', '54667081867', '18548317140001','1999-01-08','matheus123','matheus@gmail.com','M'),
(DEFAULT, 'Marta', '25887412251', '18548317140210','1987-02-18','marta123','marta@gmail.com','F'),
(DEFAULT, 'Guilherme', '12345678912', '25876541874202','1978-10-12','gui123','guilherme@gmail.com','M'),
(DEFAULT, 'Carmen', '32149874567', '65498210450002','1954-07-05','carmen123','carmen@gmail.com','F'),
(DEFAULT, 'Robert', '52229087321', '98743210987321', '1999-02-21', 'matheus123', 'robert@gmail.com','M');

SELECT * FROM Cadastro;

SELECT * FROM Cadastro ORDER BY nome;
SELECT * FROM Cadastro ORDER BY data_nasc;

CREATE TABLE Arduino(
IdSensorChecagem INT PRIMARY KEY AUTO_INCREMENT,
distancia FLOAT(8,3),
tempo TIME,
datachecagem DATE
);

INSERT INTO Arduino VALUES 
(DEFAULT, 13, '3:29:21', '2024-08-29'),
(DEFAULT, 15, '3:29:28', '2024-08-29'),
(DEFAULT, 17, '3:29:33', '2024-08-29'),
(DEFAULT, 21, '3:30:13', '2024-08-29');

SELECT * FROM Arduino;

SELECT * FROM Arduino ORDER BY tempo;

CREATE TABLE Estatistica(
idEstatistica INT PRIMARY KEY AUTO_INCREMENT,
data_horario DATETIME,
modelo VARCHAR (30),
quantidade INT
);

INSERT INTO Estatistica (data_horario, modelo, quantidade) VALUES
('2010-05-21 20:25:50', 'Micro-ATX', 10),
('2014-06-24 17:20:15', 'Starndard-ATX', 30),
('2022-09-05 20:05:20', 'Mini-ATX', 100),
('2019-08-23 13:45:21', 'Nano-ITX', 15),
('2017-10-17 14:46:20', 'Pico-ITX', 23);

SELECT * FROM Estatistica;

SELECT * FROM Estatistica ORDER BY data_horario;
