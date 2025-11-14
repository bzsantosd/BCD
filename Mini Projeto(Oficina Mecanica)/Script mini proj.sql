-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.
CREATE DATABASE Oficina;
USE Oficina;


CREATE TABLE CLIENTE (
id_cliente int not null auto_increment PRIMARY KEY,
nome_cliente varchar(100),
cpf_cliente varchar(14),
contato_cliente varchar(10),
endereco_cliente varchar(100)
);

CREATE TABLE VEICULOS (
id_veiculo int not null auto_increment PRIMARY KEY,
marca_veiculo varchar(100),
modelo_veiculo varchar(100),
placa_veiculo varchar(7) not null,
descricao_veiculo varchar(256),
id_cliente int not null ,
FOREIGN KEY(id_cliente) REFERENCES CLIENTE (id_cliente)
);

CREATE TABLE MECANICOS (
id_mecanico int not null auto_increment PRIMARY KEY,
nome_mecanico varchar(100),
contato_mecanico varchar(10),
cpf_mecanico varchar(14),
salario_mecanico decimal(5,2)
);

CREATE TABLE SERVICOS (
id_servico int not null auto_increment PRIMARY KEY,
valor_servico decimal(5,2),
data_entrega_servico date,
nome_servico varchar(100),
tipo_veiculo varchar(100)
);

CREATE TABLE ESTOQUE (
id_peca int not null auto_increment PRIMARY KEY,
local_estoque varchar(10),
valor_peca decimal(5,2),
nome_peca varchar(100),
qtde_estoque int
);

CREATE TABLE REQUEREM (
id_peca int not null ,
id_servico int not null ,
FOREIGN KEY(id_peca) REFERENCES ESTOQUE (id_peca),
FOREIGN KEY(id_servico) REFERENCES SERVICOS (id_servico)
);

CREATE TABLE REALIZA (
id_servico int not null,
id_mecanico int not null ,
FOREIGN KEY(id_servico) REFERENCES SERVICOS (id_servico),
FOREIGN KEY(id_mecanico) REFERENCES MECANICOS (id_mecanico)
);

CREATE TABLE ORDEM_SERVICO (
id_servico int not null ,
id_veiculo int not null ,
FOREIGN KEY(id_servico) REFERENCES SERVICOS (id_servico)
);


SELECT * FROM CLIENTE;
