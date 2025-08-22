CREATE DATABASE GerenciamentoProjetos;
USE GerenciamentoProjetos;

CREATE TABLE Fornecedor (
    Fcodigo INT PRIMARY KEY,
    Fnome VARCHAR(255) NOT NULL,
    Status VARCHAR(50),
    Cidade VARCHAR(100)
);

CREATE TABLE Peca (
    Pcodigo INT PRIMARY KEY,
    Pnome VARCHAR(255) NOT NULL,
    Cor VARCHAR(50),
    Peso INT,
    Cidade VARCHAR(100)
);

CREATE TABLE Instituicao (
    Icodigo INT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL
);

CREATE TABLE Projeto (
    PRcod INT PRIMARY KEY,
    PRnome VARCHAR(255) NOT NULL,
    Cidade VARCHAR(100),
    Icod INT,
    FOREIGN KEY (Icod) REFERENCES Instituicao(Icodigo)
);

CREATE TABLE Fornecimento (
    Fcod INT,
    Pcod INT,
    PRcod INT,
    Quantidade INT,
    PRIMARY KEY (Fcod, Pcod, PRcod),
    FOREIGN KEY (Fcod) REFERENCES Fornecedor(Fcodigo),
    FOREIGN KEY (Pcod) REFERENCES Peca(Pcodigo),
    FOREIGN KEY (PRcod) REFERENCES Projeto(PRcod)
);

ALTER TABLE Fornecedor
ALTER COLUMN Status SET DEFAULT 'Ativo';

ALTER TABLE Fornecedor
ADD Fone VARCHAR(20),
DROP COLUMN Cidade,
ADD Ccod INT,
ADD FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod);

ALTER TABLE Cidade
ADD COLUMN UF VARCHAR(2);

ALTER TABLE Peca
DROP COLUMN Cidade,
ADD Ccod INT,
ADD FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod);

ALTER TABLE Projeto
DROP COLUMN Icod,
ADD Ccod INT,
ADD FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod);

ALTER TABLE Fornecimento
ADD COLUMN Quantidade INT;