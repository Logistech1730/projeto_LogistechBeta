CREATE DATABASE logistech;
USE logistech;

CREATE TABLE Cadastro (
idCadastro INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(30) NOT NULL,
cnpj_cpf VARCHAR(14) NOT NULL, 
data_nasc DATE,
senha VARCHAR(20),
email VARCHAR(40),
genero CHAR(1),
CONSTRAINT chkgenero CHECK(genero IN('F','M','O'))
);

INSERT INTO Cadastro VALUES 
(DEFAULT, 'atheus', '54667081867','1999-01-08','matheus123','matheus@gmail.com','F'),
(DEFAULT, 'Robert', '52229087321' , '1999-02-21', 'matheus123', 'robert@gmail.com','M');

SELECT * FROM Cadastro;
DESC Cadastro;

CREATE TABLE Arduino(
IdSensorChecagem INT PRIMARY KEY AUTO_INCREMENT,
distancia FLOAT,
tempo TIME,
datachecagem DATETIME
);

ALTER TABLE arduino ADD COLUMN datachecagem DATE;

INSERT INTO Arduino VALUES 
(DEFAULT, 13, '3:29:21', '2024-08-29');

CREATE TABLE Estatistica(
idEstatistica INT PRIMARY KEY AUTO_INCREMENT,
data_horario DATETIME,
modelo VARCHAR (30),
quantidade INT
);

INSERT INTO Estatistica (data_horario, modelo, quantidade) VALUES
("2010-05-21 20:25:50", "Micro-ATX", 10),
("2014-06-24 17:20:15", "Starndard-ATX", 30),
("2022-09-05 20:05:20", "Mini-ATX", 100),
("2019-08-23 13:45:21", "Nano-ITX", 15),
("2017-10-17 14:46:20", "Pico-ITX", 23);

SELECT * FROM Estatistica;

ALTER TABLE Estatistica 
	MODIFY COLUMN modelo VARCHAR(20);
    
DESC Estatistica;