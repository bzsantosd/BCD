-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.
CREATE DATABASE EMPRESA_SOLAR;
USE EMPRESA_SOLAR;
SELECT DATABASE();


CREATE TABLE Clientes (
ID_Cliente int auto_increment PRIMARY KEY,
Nome_Cliente varchar (100)
);

CREATE TABLE Produtos (
ID_Produto int auto_increment PRIMARY KEY,
Nome_Produto varchar (100)
);

CREATE TABLE Compra (
ID_Compra int auto_increment PRIMARY KEY not null,
ID_Produto int ,
ID_Cliente int ,
FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID_Produto),
FOREIGN KEY (ID_Cliente) REFERENCES Clientes (ID_Cliente)
);

CREATE TABLE VENDEDORES (
Id_Vendedor int auto_increment PRIMARY KEY,
Nome_Vendedor varchar (100),
Salario decimal (5,2),
fsalarial char(1)
);

DROP TABLE VENDENDOR;

INSERT INTO CLIENTES (Nome_Cliente) VALUES ('Beatriz');
INSERT INTO PRODUTOS VALUES (2, 'Teclado');
INSERT INTO VENDEDORES (Nome_Vendedor, Salario, fsalarial) VALUES ('Beatriz', '5.000', 1);
INSERT INTO VENDEDORES (Nome_Vendedor, Salario, fsalarial) VALUES ('Luiza', 5.000, 2);
INSERT INTO VENDEDORES (Nome_Vendedor, Salario, fsalarial) VALUES ('Bruno', '5.000', 1);

UPDATE PRODUTOS SET Nome_Produto = 'Mouse' 
WHERE ID_Produto = 2;

UPDATE VENDEDORES SET Salario = 3150
WHERE fsalarial = 1;

UPDATE VENDEDORES SET Salario = (Salario * 1.10)
WHERE fsalarial = 2;

UPDATE VENDEDORES SET Salario = 3500
WHERE fsalarial = 1;

UPDATE VENDEDORES SET Salario = 10000
WHERE Nome_Vendedor = 'Bruno';

SELECT * FROM PRODUTOS;
SELECT * FROM VENDEDORES;

DELETE FROM VENDEDORES WHERE Salario < 4000.00;

-- Autorizar update em forma de comando 
SET SQL_SAFE_UPDATES = 0;

DELETE FROM PRODUTOS WHERE ID_Produto = 1;
DELETE FROM CLIENTES WHERE Nome_Cliente = 'Bruno';
DELETE FROM VENDEDORES WHERE ID_Vendedor >=1 AND ID_Vendedor=10;
DELETE FROM VENDEDORES WHERE ID_Vendedor >=10 OR ID_Vendedor=20;

DELETE FROM CLIENTES;

TRUNCATE TABLE CLIENTES;

