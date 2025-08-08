create database empresa_de_limpeza;

use empresa_de_limpeza;

create table produtos(
cod_produto int,
nome_produto varchar (100),
preco_produto decimal,
fornecedor varchar (100),
descricao varchar (255), 
imagem_produto blob 
);

create table estoque(
cod_estoque int,
localizacao varchar (10),
qtde numeric,
nome_produto varchar (100),
observacao varchar (255)
);

create table funcionarios(
cod_funcionario int,
nome_funcionario varchar (100),
data_nascimento datetime,
CPF varchar (14),
salario decimal
);

create table clientes(
cod_cliente int,
nome_cliente varchar (100),
CPF varchar (14),
endereco varchar (255),
data_nascimento datetime
);

create table manutencao(
cod_manutencao int,
tipo_manutencao varchar (120),
data_retorno datetime,
valor_manutencao decimal,
observacao varchar (255)
);

create table venda(
cod_venda int,
nome_cliente varchar (100),
nome_produto varchar (100),
entrega varchar (10),
forma_pagamento varchar(10)
);