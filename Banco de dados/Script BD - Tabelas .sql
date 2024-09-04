CREATE DATABASE logistech;
USE logistech;

CREATE TABLE Cadastro (
idCadastro INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(30),
cnpj_cpf VARCHAR(14),  -- Colocar como (essencial,  funcional) 
data_nasc date,
senha VARCHAR(20),
email VARCHAR(40),
genero char(1),
constraINT chkgenero check(genero in('F','M','O'))
);

insert INTo Cadastro values 
(default, 'atheus', '54667081867','1999-01-08','matheus123','matheus@gmail.com','F'),
(default, 'Robert', '52229087321' , '1999-02-21', 'matheus123', 'robert@gmail.com','M');

select * from Cadastro;
DESC Cadastro;

create table Arduino(
IdSensorChecagem INT primary key auto_increment,
distancia float,
tempo time,
datachecagem DATETIME
);

alter table arduino add column datachecagem date;

insert INTo Arduino values 
(default, 13, '3:29:21', '2024-08-29');

create table Estatistica(
idEstatistica INT PRIMARY KEY AUTO_INCREMENT,
data_horario DATETIME,
modelo VARCHAR (30),
quantidade INT
);

insert INTo Estatistica (data_horario, modelo, quantidade) value
("2010-05-21 20:25:50", "Micro-ATX", 10),
("2014-06-24 17:20:15", "Starndard-ATX", 30),
("2022-09-05 20:05:20", "Mini-ATX", 100),
("2019-08-23 13:45:21", "Nano-ITX", 15),
("2017-10-17 14:46:20", "Pico-ITX", 23);

select * from Estatistica;

alter table Estatistica 
	modify column modelo VARCHAR(20);
    
DESC Estatistica;