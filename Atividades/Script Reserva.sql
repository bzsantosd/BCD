create database reserva_equipamento;
use reserva_equipamento;

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
foreign key (id_fornecedor) references Fornecedor (id_fornecedor)
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

create table if not exists Reserva (
Cod_Reserva int not null,
Tipo_Reserva varchar (100),
Agendamento datetime,
Valor_Reserva decimal not null,
Observacao varchar (255),
primary key (Cod_Reserva)
);