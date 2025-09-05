CREATE DATABASE GerenciamentoProjetos;
USE GerenciamentoProjetos;
-- select database (); 

CREATE TABLE Fornecedor (
    Fcodigo INT PRIMARY KEY,
    Fnome VARCHAR(255) NOT NULL,
    Status VARCHAR(50) not null default 'ativo',
    Cidade VARCHAR(100),
    primary key (Fcodigo)
);

CREATE TABLE Peca (
    Pcodigo INT PRIMARY KEY,
    Pnome VARCHAR(255) NOT NULL,
    Cor VARCHAR(50),
    Peso INT,
    Cidade VARCHAR(100),
    primary key (Pcodigo)
);

CREATE TABLE Instituicao (
    Icodigo INT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    primary key (Icodigo)
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

SHOW TABLES; 

show index from tbl_projeto;

create index idx_icodigo on tbl_projeto(icodigo);

SHOW TABLES; 
select Fnome from tbl_fornecedor;
select * from tbl_peca;

ALTER TABLE Fornecedor
ALTER COLUMN Status SET DEFAULT 'Ativo';

-- alter table tbl_fornecedor
-- add column ccod int not null;

-- alter table tbl_fornecedor
-- add constraint fk_ccod_fornecedor
-- foreign key (ccod) references tbl_cidade (ccod);

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

drop table tbl_instituicao;

ALTER TABLE Fornecimento
ADD COLUMN Quantidade INT;

insert into tbl_cidade values (11, 'Limeira', 'SP');
insert into tbl_cidade values (10, 'São Paulo', 'SP');
insert into tbl_cidade values (19, 'Campinas', 'SP');
insert into tbl_cidade values (15, 'Cordeiropolis', 'SP');

-- verificar ultimo valor inserido de id
 select last_insert_id();
 
 