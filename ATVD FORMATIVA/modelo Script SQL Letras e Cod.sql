-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.

CREATE DATABASE Letras_Codigos;
USE Letras_Codigos;
SELECT DATABASE();

CREATE TABLE LIVROS_VENDAS (
cod_livro int auto_increment,
titulo_livro varchar (255),
editora varchar(100),
autor varchar(255),
genero varchar(100),
preco decimal (5,2),
qtde_livro int not null,
data_venda datetime,

qtde_venda int,
valor_total decimal (5,2),
cod_venda int auto_increment,
PRIMARY KEY(cod_livro,cod_venda)
)

CREATE TABLE AUTORES_EDITORAS (
cod_autor int auto_increment ,
nome_autor varchar(255),
nacionalidade varchar(100),
data_nasc datetime,
cod_cnpj int auto_increment,
nome_editora varchar(255),
endereco varchar (255),
contato varchar (100),
telefone varchar (20),
cidade varchar (100),
PRIMARY KEY(cod_autor,cod_cnpj)
)

CREATE TABLE CLIENTES (
nome_cliente int auto_increment PRIMARY KEY,
cpf varchar (14),
email varchar (255),
telefone varchar (20),
data_nasc datetime
)

CREATE TABLE TEM (
cod_autor int auto_increment ,
cod_livro int auto_increment ,
FOREIGN KEY(cod_autor) REFERENCES AUTORES_EDITORAS (cod_autor,cod_cnpj),
FOREIGN KEY(cod_livro) REFERENCES LIVROS_VENDAS (cod_livro,cod_venda)
)

CREATE TABLE GERAM (
cod_venda int auto_increment,
nome_cliente int auto_increment,
FOREIGN KEY(cod_venda) REFERENCES LIVROS_VENDAS (cod_livro,cod_venda),
FOREIGN KEY(nome_cliente) REFERENCES CLIENTES (nome_cliente)
)

CREATE TABLE LIVROS_VENDAS (
cod_livro int auto_increment,
titulo_livro varchar (255),
editora varchar(100),
autor varchar(255),
genero varchar(100),
preco decimal (5,2),
qtde_livro int not null,
data_venda datetime,

qtde_venda int,
valor_total decimal (5,2),
cod_venda int auto_increment,
PRIMARY KEY(cod_livro,cod_venda)
)

CREATE TABLE AUTORES_EDITORAS (
cod_autor int auto_increment ,
nome_autor varchar(255),
nacionalidade varchar(100),
data_nasc datetime,
cod_cnpj int auto_increment,
nome_editora varchar(255),
endereco varchar (255),
contato varchar (100),
telefone varchar (20),
cidade varchar (100),
PRIMARY KEY(cod_autor,cod_cnpj)
)

CREATE TABLE CLIENTES (
nome_cliente int auto_increment PRIMARY KEY,
cpf varchar (14),
email varchar (255),
telefone varchar (20),
data_nasc datetime
)

CREATE TABLE TEM (
cod_autor int auto_increment ,
cod_livro int auto_increment ,
FOREIGN KEY(cod_autor) REFERENCES AUTORES_EDITORAS (cod_autor,cod_cnpj),
FOREIGN KEY(cod_livro) REFERENCES LIVROS_VENDAS (cod_livro,cod_venda)
)

CREATE TABLE GERAM (
cod_venda int auto_increment,
nome_cliente int auto_increment,
FOREIGN KEY(cod_venda) REFERENCES LIVROS_VENDAS (cod_livro,cod_venda),
FOREIGN KEY(nome_cliente) REFERENCES CLIENTES (nome_cliente)
)

INSERT INTO Clientes (nome_cliente, cpf, data_nasc, email, telefone)
VALUES ('Ana Silva', '123.456.789-01', '1990-05-15', 'ana.silva@email.com', '(11) 98765-4321');

INSERT INTO Autores_Editoras (data_nasc, nacionalidade, nome_autor, cod_cnpj, telefone, nome_editora, contato, cidade, endereco)
VALUES ('1975-11-20', 'Brasileira', 'João Oliveira', 12345678901234, '(21) 91234-5678', 'Editora Saber', 'contato@saber.com.br', 'Rio de Janeiro', 'Rua das Palmeiras, 123');

INSERT INTO Livros_Vendas (editora, titulo_livro, preco, genero, autor, qtde_livro, valor_total, data_venda, qtde_venda)
VALUES ('Editora Saber', 'O Mistério da Montanha', 35.50, 'Ficção', 'João Oliveira', 500, 17750.00, '2025-09-19 10:30:00', 50);

select * from livros;

select titulo_livro, ano_publicação
from livros;

-- consultas por titulo, ano e publicacao > 2015
select titulo, ano_publicacao
from livros
where ano_publicacao < 2015;

-- consultas por titulo e ano em ordem crescente 
select titulo, ano_publicacao
from livros
order by ano_publicacao desc;

-- limitar consultas por valor de quantidade 
-- apresentadas
select titulo from livros 
limit 5;

-- renomear colunas com as
select titulo as nome, ano_publicacao as ano
from livros;

-- consultas agregadas
select count(*) as total_livros
from livros;

select *from autores;
-- consulta com joins
select livros.titulo, autores.nome from livros
join autores on livros.id_autor = autores.id_autor;

-- consulta por agruoamentos group by
select titulo, count(*) as quantidade
from livros
group by titulo;
