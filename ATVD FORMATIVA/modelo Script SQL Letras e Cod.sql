-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.



CREATE TABLE LIVROS+VENDAS (
cod_livro int auto increment ,
titulo_livro varchar (255),
editora Texto(1),
autor varchar(255),
genero varchar(100),
preco decimal (5,2),
qtde_livro int not null,
data_venda datetime,

qtde_venda int,
valor_total decimal (5,2),
cod_venda int auto increment,
PRIMARY KEY(cod_livro,cod_venda)
)

CREATE TABLE AUTORES+EDITORAS (
cod_autor int auto increment ,
nome_autor varchar(255),
nacionalidade varchar(100),
data_nasc datetime,
cod_cnpj int auto increment,
nome_editora varchar(255),
endereco varchar (255),
contato varchar (100),
telefone varchar (20),
cidade varchar (100),
PRIMARY KEY(cod_autor,cod_cnpj)
)

CREATE TABLE CLIENTES (
nome_cliente int auto increment PRIMARY KEY,
cpf varchar (14),
email varchar (255),
telefone varchar (20),
data_nasc datetime
)

CREATE TABLE TEM (
cod_autor int auto increment ,
cod_livro int auto increment ,
FOREIGN KEY(cod_autor) REFERENCES AUTORES+EDITORAS (cod_autor,cod_cnpj),
FOREIGN KEY(cod_livro) REFERENCES LIVROS+VENDAS (cod_livro,cod_venda)
)

CREATE TABLE GERAM (
cod_venda int auto increment,
nome_cliente int auto increment,
FOREIGN KEY(cod_venda) REFERENCES LIVROS+VENDAS (cod_livro,cod_venda),
FOREIGN KEY(nome_cliente) REFERENCES CLIENTES (nome_cliente)
)

