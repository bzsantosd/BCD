create database solar;
use solar;

create table if not exists clientes (
cod_cliente int not null,
nome_cliente varchar (100),
cpf varchar (14) not null,
endereco varchar (100),
celular varchar (19),
primary key (cod_cliente)
);

create table if not exists produtos (
cod_produto int auto_increment primary key not null,
nome_produto varchar (100) not null,
descricao varchar (100),
qtde int not null,
valor decimal (5,2) not null
);

create table venda (
cod_venda int primary key auto_increment not null,
cod_produto int not null,
id_fornecedor int not null,
foreign key (cod_produto) references produtos (cod_produto),
foreign key (id_fornecedor) references fornecedor (id_fornecedor)
);

create table if not exists Compra (
Cod_Compra int primary key auto_increment not null,
cod_cliente int not null,
cod_produto int not null,
foreign key (cod_produto) references produtos (cod_produto),
foreign key (cod_cliente) references clientes (cod_cliente)
);

create table if not exists fornecedor (
id_fornecedor int not null,
nome_fornecedor varchar (255),
celular varchar (14),
cnpj varchar (18) not null,
estado char (2) default 'SP' not null,
cidade varchar (100) not null,
endereco varchar (100) not null,
primary key (id_fornecedor)
);

create table Funcionarios (
cod_funcionario int auto_increment primary key not null,
nome_funcionario varchar(100) not null,
cpf_funcionario varchar(14) not null,
endereco_funcionario varchar(100) not null,
data_nascimento datetime not null,
data_admissao datetime not null,
data_recisao datetime not null,
salario decimal (7,2) not null,
cod_departamento int not null,
foreign key (cod_departamento) references Departamento (cod_departamento)
);

create table Departamento (
cod_departamento int auto_increment primary key not null,
nome_departamento varchar (20) not null,
responsavel varchar (100) not null,
setor varchar (50) not null
);

alter table funcionarios
add sexo char (1);

alter table funcionarios
drop column sexo;

alter table funcionarios 
rename to empregado;

alter table empregado
change cpf_funcionario cic_funcionario varchar (18);

alter table empregado 
modify column nome_funcionario varchar (200);

alter table fornecedor
modify column estado char(2) default 'MG';

alter table empregado
add primary key (cpf_funcionario);