-- ====================================================================
-- 1. SETUP DO BANCO DE DADOS E DDL (Data Definition Language)
-- ====================================================================

-- Cria o Banco de Dados se não existir
CREATE DATABASE IF NOT EXISTS Oficina;
USE Oficina;

-- DROP de tabelas existentes (para garantir um ambiente limpo para o teste)
DROP TABLE IF EXISTS OS_PECAS;
DROP TABLE IF EXISTS OS_MECANICOS;
DROP TABLE IF EXISTS OS_SERVICOS;
DROP TABLE IF EXISTS ORDENS_SERVICO;
DROP TABLE IF EXISTS VEICULOS;
DROP TABLE IF EXISTS CLIENTE;
DROP TABLE IF EXISTS MECANICOS;
DROP TABLE IF EXISTS SERVICOS;
DROP TABLE IF EXISTS PECAS;

-- Criação das Tabelas Base (Ajustadas para as consultas)
CREATE TABLE CLIENTE (
    id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_cliente VARCHAR(100),
    cpf_cliente VARCHAR(14),
    contato_cliente VARCHAR(15),
    endereco_cliente VARCHAR(100)
);

CREATE TABLE VEICULOS (
    id_veiculo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    marca_veiculo VARCHAR(100),
    modelo_veiculo VARCHAR(100),
    placa_veiculo VARCHAR(7) NOT NULL UNIQUE,
    descricao_veiculo VARCHAR(256),
    id_cliente INT NOT NULL,
    FOREIGN KEY(id_cliente) REFERENCES CLIENTE (id_cliente) ON DELETE CASCADE
);

CREATE TABLE MECANICOS (
    id_mecanico INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_mecanico VARCHAR(100),
    contato_mecanico VARCHAR(15),
    cpf_mecanico VARCHAR(14),
    salario_mecanico DECIMAL(7,2)
    -- Coluna 'especialidade' será adicionada no ALTER TABLE (Tarefa 3.2)
);

CREATE TABLE SERVICOS (
    id_servico INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    valor_servico DECIMAL(7,2),
    data_entrega_servico DATE,
    nome_servico VARCHAR(100),
    tipo_veiculo VARCHAR(100)
    -- Coluna 'preco_mao_obra' será adicionada no ALTER TABLE
);

-- Tabela PECAS (Renomeada/Ajustada de ESTOQUE)
CREATE TABLE PECAS (
    id_peca INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    local_estoque VARCHAR(10),
    preco_venda DECIMAL(7,2), -- Antiga valor_peca
    nome_peca VARCHAR(100),
    qtde_estoque INT
    -- Colunas 'preco_custo' e 'fabricante' serão adicionadas no ALTER TABLE
);

-- Tabela principal da Ordem de Serviço (OS)
CREATE TABLE ORDENS_SERVICO (
    id_os INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    data_abertura DATE NOT NULL,
    data_conclusao DATE NULL,
    status ENUM('Aberto', 'Aguardando Peça', 'Em Execução', 'Concluído', 'Cancelado') NOT NULL DEFAULT 'Aberto',
    diagnostico_entrada TEXT, -- Coluna que será removida na Tarefa 3.3
    FOREIGN KEY(id_veiculo) REFERENCES VEICULOS (id_veiculo)
);

-- Tabela de ligação OS - Serviços
CREATE TABLE OS_SERVICOS (
    id_os INT NOT NULL,
    id_servico INT NOT NULL,
    preco_cobrado DECIMAL(7,2) NOT NULL,
    quantidade INT NOT NULL DEFAULT 1,
    PRIMARY KEY (id_os, id_servico),
    FOREIGN KEY(id_os) REFERENCES ORDENS_SERVICO (id_os),
    FOREIGN KEY(id_servico) REFERENCES SERVICOS (id_servico)
);

-- Tabela de ligação OS - Mecânicos
CREATE TABLE OS_MECANICOS (
    id_os INT NOT NULL,
    id_mecanico INT NOT NULL,
    PRIMARY KEY (id_os, id_mecanico),
    FOREIGN KEY(id_os) REFERENCES ORDENS_SERVICO (id_os),
    FOREIGN KEY(id_mecanico) REFERENCES MECANICOS (id_mecanico)
);

-- Tabela de ligação OS - Peças
CREATE TABLE OS_PECAS (
    id_os INT NOT NULL,
    id_peca INT NOT NULL,
    quantidade_usada INT NOT NULL,
    preco_unitario_cobrado DECIMAL(7,2) NOT NULL,
    PRIMARY KEY (id_os, id_peca),
    FOREIGN KEY(id_os) REFERENCES ORDENS_SERVICO (id_os),
    FOREIGN KEY(id_peca) REFERENCES PECAS (id_peca)
);


-- AJUSTES ESTRUTURAIS EXTRAS (Necessários para DML e Consultas)
ALTER TABLE MECANICOS ADD COLUMN especialidade VARCHAR(100);
ALTER TABLE PECAS ADD COLUMN preco_custo DECIMAL(7,2);
ALTER TABLE PECAS ADD COLUMN fabricante VARCHAR(100);
ALTER TABLE SERVICOS ADD COLUMN preco_mao_obra DECIMAL(7,2);

-- ====================================================================
-- 3. ALTER TABLE (Modificação da Estrutura - Tarefas 3.1, 3.2, 3.3 e 10.2)
-- ====================================================================

-- Tarefa 3.1: Adicione uma nova coluna email (tipo VARCHAR(100)) à tabela Clientes.
ALTER TABLE CLIENTE ADD COLUMN email VARCHAR(100);

-- Tarefa 3.2: Modifique o tipo de dados da coluna especialidade na tabela Mecanicos para VARCHAR(150).
ALTER TABLE MECANICOS MODIFY COLUMN especialidade VARCHAR(150);

-- Tarefa 3.3: Remova uma coluna (ex: diagnostico_entrada) da tabela Ordens_Servico.
ALTER TABLE ORDENS_SERVICO DROP COLUMN diagnostico_entrada;

-- Tarefa 10.2: Indexação da chave estrangeira id_veiculo na tabela ORDENS_SERVICO
CREATE INDEX idx_id_veiculo_os ON ORDENS_SERVICO (id_veiculo);

-- Tarefa 10.1: Indexação da coluna placa_veiculo na tabela VEICULOS (Já é UNIQUE)
CREATE UNIQUE INDEX idx_placa_veiculo ON VEICULOS (placa_veiculo);


-- ====================================================================
-- 2. DML (Data Manipulation Language - Inserção de Dados)
-- ====================================================================

-- DADOS DE CLIENTES
INSERT INTO CLIENTE (nome_cliente, cpf_cliente, contato_cliente, endereco_cliente, email) VALUES
('João Silva', '111.111.111-11', '98888-1111', 'Rua A, 100', 'joao.silva@email.com'), -- id_cliente 1
('Maria Oliveira', '222.222.222-22', '97777-2222', 'Av B, 200', 'maria.o@email.com'), -- id_cliente 2
('Carlos Pereira', '333.333.333-33', '96666-3333', 'Rua C, 300', 'carlos.p@email.com'), -- id_cliente 3
('Ana Souza', '444.444.444-44', '95555-4444', 'Rua D, 400', 'ana.s@email.com'), -- id_cliente 4
('Pedro Santos', '555.555.555-55', '94444-5555', 'Av E, 500', 'pedro.s@email.com'); -- id_cliente 5

-- DADOS DE VEICULOS (Com Ford e Volkswagen)
INSERT INTO VEICULOS (id_cliente, marca_veiculo, modelo_veiculo, placa_veiculo, descricao_veiculo) VALUES
(1, 'Ford', 'Fiesta', 'AB12345', 'Prata 2010'),    -- id_veiculo 1 (Ford)
(1, 'Chevrolet', 'Onix', 'DEF5678', 'Preto 2020'), -- id_veiculo 2
(2, 'Ford', 'Focus', 'GHI9012', 'Vermelho 2015'), -- id_veiculo 3 (Ford)
(3, 'Volkswagen', 'Golf', 'JKL3456', 'Azul 2018'), -- id_veiculo 4 (Volkswagen)
(4, 'Fiat', 'Uno', 'MNO7890', 'Branco 2005'),     -- id_veiculo 5 (Fiat)
(5, 'Honda', 'Civic', 'PQR1122', 'Cinza 2022'),   -- id_veiculo 6
(5, 'Honda', 'HR-V', 'STU3344', 'Preto 2023');    -- id_veiculo 7

-- DADOS DE MECANICOS (Com 'Injeção Eletrônica')
INSERT INTO MECANICOS (nome_mecanico, contato_mecanico, cpf_mecanico, salario_mecanico, especialidade) VALUES
('Mário Souza', '91111-1111', '121.121.121-12', 4500.00, 'Motor'), -- id_mecanico 1
('Fernanda Lima', '92222-2222', '232.232.232-23', 5200.00, 'Injeção Eletrônica'), -- id_mecanico 2
('Carlos Alberto', '93333-3333', '343.343.343-34', 3800.00, 'Freios'), -- id_mecanico 3 (Mecânico específico para tarefa 1.7)
('Júlia Rocha', '94444-4444', '454.454.454-45', 4900.00, 'Suspensão'); -- id_mecanico 4 (Mecânico 'Carlos' na tarefa 8.2)

-- DADOS DE SERVICOS (Com preco_mao_obra)
INSERT INTO SERVICOS (nome_servico, valor_servico, data_entrega_servico, tipo_veiculo, preco_mao_obra) VALUES
('Troca de Óleo', 80.00, DATE_ADD(CURDATE(), INTERVAL 1 DAY), 'Passeio', 40.00), -- id_servico 1
('Revisão Completa', 350.00, DATE_ADD(CURDATE(), INTERVAL 3 DAY), 'Passeio', 250.00), -- id_servico 2
('Diagnóstico de Motor', 150.00, DATE_ADD(CURDATE(), INTERVAL 1 DAY), 'Passeio', 150.00); -- id_servico 3

-- DADOS DE PEÇAS (Com estoque baixo, Bosch e preco_custo > R$ 200)
INSERT INTO PECAS (nome_peca, qtde_estoque, preco_venda, local_estoque, preco_custo, fabricante) VALUES
('Filtro de Óleo', 15, 25.00, 'A1', 15.00, 'Mahle'), -- id_peca 1
('Vela de Ignição', 3, 40.00, 'A2', 25.00, 'Bosch'), -- id_peca 2 (Estoque < 5, Bosch)
('Pastilha de Freio', 20, 120.00, 'B1', 70.00, 'Frasle'), -- id_peca 3
('Bateria 60Ah', 8, 450.00, 'C1', 350.00, 'Moura'), -- id_peca 4 (Custo > 200)
('Filtro de Ar', 1, 30.00, 'A1', 18.00, 'Mahle'); -- id_peca 5 (Estoque = 1, será dobrado na Tarefa 2.4)

-- DADOS DE ORDENS DE SERVIÇO (Simulando 6 meses de histórico)
INSERT INTO ORDENS_SERVICO (id_os, id_veiculo, data_abertura, data_conclusao, status) VALUES
(101, 1, DATE_SUB(CURDATE(), INTERVAL 7 MONTH), DATE_SUB(CURDATE(), INTERVAL 7 MONTH ), 'Concluído'), -- Mais de 6 meses
(102, 3, DATE_SUB(CURDATE(), INTERVAL 3 MONTH), DATE_SUB(CURDATE(), INTERVAL 3 MONTH ), 'Concluído'), -- Nos últimos 6 meses
(103, 4, DATE_SUB(CURDATE(), INTERVAL 1 MONTH), DATE_SUB(CURDATE(), INTERVAL 1 MONTH), 'Concluído'), -- Nos últimos 6 meses
(104, 1, DATE_SUB(CURDATE(), INTERVAL 2 MONTH), DATE_SUB(CURDATE(), INTERVAL 2 MONTH ), 'Concluído'), -- Veículo 1 retornou (>1 OS)
(105, 5, DATE_SUB(CURDATE(), INTERVAL 15 DAY), NULL, 'Em Execução'), -- id_os 105 (Será atualizada na Tarefa 2.2)
(106, 6, DATE_SUB(CURDATE(), INTERVAL 5 DAY), NULL, 'Aguardando Peça'), -- Status 'Aguardando Peça' (Tarefa 1.4)
(107, 7, DATE_SUB(CURDATE(), INTERVAL 40 DAY), NULL, 'Em Execução'); -- Aberta há mais de 30 dias (Será atualizada na Tarefa 2.3)

-- LIGAÇÃO OS_SERVICOS
INSERT INTO OS_SERVICOS (id_os, id_servico, preco_cobrado, quantidade) VALUES
(101, 1, 95.00, 1),
(102, 2, 350.00, 1),
(103, 1, 80.00, 1),
(104, 3, 150.00, 1),
(105, 1, 95.00, 1),
(106, 2, 400.00, 1),
(107, 3, 160.00, 1);

-- LIGAÇÃO OS_MECANICOS
INSERT INTO OS_MECANICOS (id_os, id_mecanico) VALUES
(101, 1),
(102, 2), -- Mecânico 2 (Fernanda Lima)
(103, 3), -- Mecânico 3 (Carlos Alberto) - Tarefa 1.7
(104, 4), -- Mecânico 4 (Júlia Rocha / "Carlos")
(105, 1),
(106, 2),
(107, 3); -- Mecânico 3 (Carlos Alberto) - Tarefa 1.7

-- LIGAÇÃO OS_PECAS
INSERT INTO OS_PECAS (id_os, id_peca, quantidade_usada, preco_unitario_cobrado) VALUES
(101, 1, 1, 25.00), -- Filtro de Óleo
(102, 3, 1, 120.00), -- Pastilha de Freio
(104, 2, 4, 40.00), -- Velas (4 unidades)
(104, 4, 1, 450.00), -- Bateria
(105, 1, 1, 25.00),
(107, 5, 1, 30.00); -- Filtro de Ar


-- ====================================================================
-- 3. EXECUÇÃO DAS TAREFAS (1 a 10)
-- ====================================================================

-- --------------------------------------------------
-- 1. SELECT (Consultas Básicas)
-- --------------------------------------------------
SELECT '--- 1.1 Veículos da marca Ford ---' AS CONSULTA;
SELECT * FROM VEICULOS WHERE marca_veiculo = 'Ford';

SELECT '--- 1.2 Clientes com OS nos últimos 6 meses ---' AS CONSULTA;
SELECT DISTINCT c.nome_cliente
FROM CLIENTE c
JOIN VEICULOS v ON c.id_cliente = v.id_cliente
JOIN ORDENS_SERVICO os ON v.id_veiculo = os.id_veiculo
WHERE os.data_abertura >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

SELECT '--- 1.3 Mecânicos com especialidade Injeção Eletrônica ---' AS CONSULTA;
SELECT * FROM MECANICOS WHERE especialidade = 'Injeção Eletrônica';

SELECT '--- 1.4 OS com status Aguardando Peça ---' AS CONSULTA;
SELECT * FROM ORDENS_SERVICO WHERE status = 'Aguardando Peça';

SELECT '--- 1.5 Peças com estoque abaixo de 5 unidades ---' AS CONSULTA;
SELECT nome_peca, qtde_estoque FROM PECAS WHERE qtde_estoque < 5;

SELECT '--- 1.6 Veículos com mais de uma OS (Subconsulta Correlacionada) ---' AS CONSULTA;
SELECT v.placa_veiculo, v.modelo_veiculo
FROM VEICULOS v
WHERE 1 < (SELECT COUNT(*) FROM ORDENS_SERVICO os WHERE os.id_veiculo = v.id_veiculo);

SELECT '--- 1.7 OS executadas pelo mecânico id_mecanico = 3 ---' AS CONSULTA;
SELECT os.id_os, os.data_abertura, os.status
FROM ORDENS_SERVICO os
JOIN OS_MECANICOS osm ON os.id_os = osm.id_os
WHERE osm.id_mecanico = 3;

SELECT '--- 1.8 (Desafio) Peças com preço_custo > R$ 200,00 ---' AS CONSULTA;
SELECT nome_peca, preco_venda
FROM PECAS
WHERE preco_custo > 200.00;

-- --------------------------------------------------
-- 2. UPDATE (Atualização de Dados)
-- --------------------------------------------------
SELECT '--- 2.1 UPDATE: Aumento de 5% no preco_venda das peças Bosch ---' AS UPDATE_INFO;
UPDATE PECAS
SET preco_venda = preco_venda * 1.05
WHERE fabricante = 'Bosch';
-- Verifica o resultado
SELECT * FROM PECAS WHERE fabricante = 'Bosch';

SELECT '--- 2.2 UPDATE: Modifica status da OS 105 para Concluída ---' AS UPDATE_INFO;
UPDATE ORDENS_SERVICO
SET status = 'Concluído', data_conclusao = CURDATE()
WHERE id_os = 105;
-- Verifica o resultado
SELECT id_os, status, data_conclusao FROM ORDENS_SERVICO WHERE id_os = 105;

SELECT '--- 2.3 UPDATE: Atualiza data_conclusao de OS "Em Execução" abertas há mais de 30 dias ---' AS UPDATE_INFO;
UPDATE ORDENS_SERVICO
SET data_conclusao = CURDATE(), status = 'Concluído'
WHERE status = 'Em Execução'
  AND data_abertura < DATE_SUB(CURDATE(), INTERVAL 30 DAY);
-- Verifica o resultado (OS 107 deve ser atualizada)
SELECT id_os, data_abertura, data_conclusao, status FROM ORDENS_SERVICO WHERE id_os = 107;

SELECT '--- 2.4 (Desafio) UPDATE: Dobra qtd_estoque da peça 5 (Filtro de Ar) ---' AS UPDATE_INFO;
UPDATE PECAS
SET qtde_estoque = qtde_estoque * 2
WHERE id_peca = 5;
-- Verifica o resultado
SELECT id_peca, nome_peca, qtde_estoque FROM PECAS WHERE id_peca = 5;


-- --------------------------------------------------
-- 3. ALTER TABLE (Modificação da Estrutura) - Tarefa 3.4
-- Nota: 3.1, 3.2 e 3.3 já foram executados no início.
-- --------------------------------------------------
SELECT '--- 3.4 (Desafio) ALTER TABLE: Adiciona restrição CHECK (preco_venda >= preco_custo) ---' AS DDL_INFO;
ALTER TABLE PECAS
ADD CONSTRAINT chk_preco_venda CHECK (preco_venda >= preco_custo);
-- Para testar (deve falhar): INSERT INTO PECAS (nome_peca, qtde_estoque, preco_venda, preco_custo) VALUES ('Peça Ruim', 1, 10.00, 15.00);


-- --------------------------------------------------
-- 4. JOIN (Consultas com Múltiplas Tabelas)
-- --------------------------------------------------
SELECT '--- 4.1 Lista OS, Cliente, Placa e Data de Abertura ---' AS CONSULTA;
SELECT
    os.id_os,
    c.nome_cliente,
    v.placa_veiculo,
    os.data_abertura
FROM ORDENS_SERVICO os
JOIN VEICULOS v ON os.id_veiculo = v.id_veiculo
JOIN CLIENTE c ON v.id_cliente = c.id_cliente;

SELECT '--- 4.2 Peças usadas na OS 104 (Nome e Quantidade) ---' AS CONSULTA;
SELECT
    p.nome_peca,
    osp.quantidade_usada
FROM OS_PECAS osp
JOIN PECAS p ON osp.id_peca = p.id_peca
WHERE osp.id_os = 104;

SELECT '--- 4.3 Mecânicos que trabalharam na OS 107 ---' AS CONSULTA;
SELECT m.nome_mecanico
FROM OS_MECANICOS osm
JOIN MECANICOS m ON osm.id_mecanico = m.id_mecanico
WHERE osm.id_os = 107;

SELECT '--- 4.4 (Desafio) Veículos e seus Proprietários ---' AS CONSULTA;
SELECT v.placa_veiculo, v.modelo_veiculo, c.nome_cliente AS proprietario
FROM VEICULOS v
JOIN CLIENTE c ON v.id_cliente = c.id_cliente;


-- --------------------------------------------------
-- 5. INNER JOIN (Apenas Interseções)
-- --------------------------------------------------
SELECT '--- 5.1 Veículos com OS Em Execução (INNER JOIN) ---' AS CONSULTA;
SELECT v.placa_veiculo, v.modelo_veiculo
FROM VEICULOS v
INNER JOIN ORDENS_SERVICO os ON v.id_veiculo = os.id_veiculo
WHERE os.status = 'Em Execução';

SELECT '--- 5.2 Clientes que possuem veículos Volkswagen (INNER JOIN) ---' AS CONSULTA;
SELECT DISTINCT c.nome_cliente
FROM CLIENTE c
INNER JOIN VEICULOS v ON c.id_cliente = v.id_cliente
WHERE v.marca_veiculo = 'Volkswagen';

SELECT '--- 5.3 Mecânicos que já trabalharam em pelo menos uma OS (INNER JOIN) ---' AS CONSULTA;
SELECT DISTINCT m.nome_mecanico
FROM MECANICOS m
INNER JOIN OS_MECANICOS osm ON m.id_mecanico = osm.id_mecanico;

SELECT '--- 5.4 (Desafio) Serviços que já foram executados (INNER JOIN) ---' AS CONSULTA;
SELECT DISTINCT s.nome_servico
FROM SERVICOS s
INNER JOIN OS_SERVICOS oss ON s.id_servico = oss.id_servico;


-- --------------------------------------------------
-- 6. LEFT JOIN (Priorizando a Esquerda)
-- --------------------------------------------------
SELECT '--- 6.1 Clientes e IDs de suas OS (LEFT JOIN) ---' AS CONSULTA;
SELECT c.nome_cliente, os.id_os
FROM CLIENTE c
LEFT JOIN VEICULOS v ON c.id_cliente = v.id_cliente
LEFT JOIN ORDENS_SERVICO os ON v.id_veiculo = os.id_veiculo
ORDER BY c.nome_cliente, os.id_os;

SELECT '--- 6.2 Mecânicos e Count de OS (LEFT JOIN para incluir os com 0) ---' AS CONSULTA;
SELECT
    m.nome_mecanico,
    COUNT(osm.id_os) AS total_os
FROM MECANICOS m
LEFT JOIN OS_MECANICOS osm ON m.id_mecanico = osm.id_mecanico
GROUP BY m.nome_mecanico
ORDER BY total_os DESC;

SELECT '--- 6.3 Peças e Quantidade Total Vendida (LEFT JOIN) ---' AS CONSULTA;
SELECT
    p.nome_peca,
    COALESCE(SUM(osp.quantidade_usada), 0) AS total_vendido
FROM PECAS p
LEFT JOIN OS_PECAS osp ON p.id_peca = osp.id_peca
GROUP BY p.nome_peca
ORDER BY total_vendido DESC;

SELECT '--- 6.4 (Desafio) Veículos e Data da Última OS (LEFT JOIN) ---' AS CONSULTA;
SELECT
    v.placa_veiculo,
    v.modelo_veiculo,
    MAX(os.data_abertura) AS data_ultima_os
FROM VEICULOS v
LEFT JOIN ORDENS_SERVICO os ON v.id_veiculo = os.id_veiculo
GROUP BY v.id_veiculo, v.placa_veiculo, v.modelo_veiculo;


-- --------------------------------------------------
-- 7. RIGHT JOIN (Priorizando a Direita)
-- --------------------------------------------------
SELECT '--- 7.1 OS e Nome do Cliente (RIGHT JOIN) ---' AS CONSULTA;
SELECT os.id_os, os.data_abertura, c.nome_cliente
FROM CLIENTE c
INNER JOIN VEICULOS v ON c.id_cliente = v.id_cliente
RIGHT JOIN ORDENS_SERVICO os ON v.id_veiculo = os.id_veiculo;

SELECT '--- 7.2 Serviços e IDs das OS (RIGHT JOIN para incluir serviços não executados) ---' AS CONSULTA;
SELECT s.nome_servico, oss.id_os
FROM OS_SERVICOS oss
RIGHT JOIN SERVICOS s ON oss.id_servico = s.id_servico; -- Neste caso, todos os serviços foram usados, mas a estrutura está correta

SELECT '--- 7.3 Itens de OS_Mecanicos e Nome do Mecânico (RIGHT JOIN) ---' AS CONSULTA;
SELECT osm.id_os, m.nome_mecanico
FROM MECANICOS m
RIGHT JOIN OS_MECANICOS osm ON m.id_mecanico = osm.id_mecanico;

SELECT '--- 7.4 (Desafio) Veículos e OS (RIGHT JOIN, Inverso do LEFT) ---' AS CONSULTA;
SELECT v.placa_veiculo, os.id_os
FROM ORDENS_SERVICO os
RIGHT JOIN VEICULOS v ON os.id_veiculo = v.id_veiculo;


-- --------------------------------------------------
-- 8. Subconsultas (Subqueries)
-- --------------------------------------------------
SELECT '--- 8.1 Clientes com mais de 3 OS ---' AS CONSULTA;
SELECT nome_cliente
FROM CLIENTE c
WHERE (
    SELECT COUNT(*)
    FROM VEICULOS v
    JOIN ORDENS_SERVICO os ON v.id_veiculo = os.id_veiculo
    WHERE v.id_cliente = c.id_cliente
) > 3;

SELECT '--- 8.2 Peças usadas na OS do mecânico ID 4 (Júlia Rocha) ---' AS CONSULTA;
SELECT DISTINCT p.nome_peca
FROM PECAS p
JOIN OS_PECAS osp ON p.id_peca = osp.id_peca
WHERE osp.id_os IN (
    SELECT id_os
    FROM OS_MECANICOS
    WHERE id_mecanico = 4
);

SELECT '--- 8.3 Veículos que nunca tiveram uma OS (NOT IN) ---' AS CONSULTA;
SELECT placa_veiculo, modelo_veiculo
FROM VEICULOS v
WHERE v.id_veiculo NOT IN (
    SELECT DISTINCT id_veiculo
    FROM ORDENS_SERVICO
);

SELECT '--- 8.4 (Desafio) Serviços com preço_mao_obra acima da média ---' AS CONSULTA;
SELECT nome_servico, preco_mao_obra
FROM SERVICOS
WHERE preco_mao_obra > (
    SELECT AVG(preco_mao_obra) FROM SERVICOS
);


-- --------------------------------------------------
-- 9. Agregação (SUM, COUNT, AVG, GROUP BY)
-- --------------------------------------------------
SELECT '--- 9.0 Faturamento Total da OS 104 (Serviços + Peças) ---' AS CONSULTA;
SELECT
    (SELECT COALESCE(SUM(preco_cobrado * quantidade), 0) FROM OS_SERVICOS WHERE id_os = 104) +
    (SELECT COALESCE(SUM(preco_unitario_cobrado * quantidade_usada), 0) FROM OS_PECAS WHERE id_os = 104)
AS faturamento_total_os_104;

SELECT '--- 9.0 Tempo Médio (dias) de OS abertas (Concluídas) ---' AS CONSULTA;
SELECT
    AVG(DATEDIFF(data_conclusao, data_abertura)) AS tempo_medio_dias
FROM ORDENS_SERVICO
WHERE status = 'Concluído' AND data_conclusao IS NOT NULL;


-- 9.1 Agregações Simples
SELECT '--- 9.1.1 Total de Veículos Cadastrados ---' AS CONSULTA;
SELECT COUNT(id_veiculo) AS total_veiculos FROM VEICULOS;

SELECT '--- 9.1.2 Valor Total do Inventário (Estoque) ---' AS CONSULTA;
SELECT SUM(qtde_estoque * preco_custo) AS valor_total_inventario FROM PECAS;

SELECT '--- 9.1.3 Preço Médio da Mão de Obra de Todos os Serviços ---' AS CONSULTA;
SELECT AVG(preco_mao_obra) AS preco_medio_mao_obra FROM SERVICOS;

-- 9.2 Agregações com Agrupamento (GROUP BY)
SELECT '--- 9.2.1 Contagem de Veículos por Marca ---' AS CONSULTA;
SELECT marca_veiculo, COUNT(*) AS total_por_marca
FROM VEICULOS
GROUP BY marca_veiculo;

SELECT '--- 9.2.2 Número de OS Abertas por Mês ---' AS CONSULTA;
SELECT
    YEAR(data_abertura) AS ano,
    MONTH(data_abertura) AS mes,
    COUNT(*) AS total_os
FROM ORDENS_SERVICO
GROUP BY ano, mes
ORDER BY ano, mes;

SELECT '--- 9.2.3 Contagem de OS por Status ---' AS CONSULTA;
SELECT status, COUNT(*) AS total_por_status
FROM ORDENS_SERVICO
GROUP BY status;

-- 9.3 Agregações com Filtros (WHERE)
SELECT '--- 9.3.1 Total de OS Concluídas ---' AS CONSULTA;
SELECT COUNT(*) AS total_os_concluidas
FROM ORDENS_SERVICO
WHERE status = 'Concluído';

SELECT '--- 9.3.2 Faturamento Total da marca Fiat no último ano ---' AS CONSULTA;
SELECT
    COALESCE(SUM(oss.preco_cobrado * oss.quantidade), 0) +
    COALESCE(SUM(osp.preco_unitario_cobrado * osp.quantidade_usada), 0)
AS faturamento_fiat_ultimo_ano
FROM ORDENS_SERVICO os
JOIN VEICULOS v ON os.id_veiculo = v.id_veiculo
LEFT JOIN OS_SERVICOS oss ON os.id_os = oss.id_os
LEFT JOIN OS_PECAS osp ON os.id_os = osp.id_os
WHERE v.marca_veiculo = 'Fiat'
  AND os.data_abertura >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

SELECT '--- 9.3.3 Preço Médio da Mão de Obra em OS de Mecânicos de Motor ---' AS CONSULTA;
SELECT AVG(s.preco_mao_obra) AS preco_medio_mao_obra_motor
FROM SERVICOS s
JOIN OS_SERVICOS oss ON s.id_servico = oss.id_servico
JOIN OS_MECANICOS osm ON oss.id_os = osm.id_os
JOIN MECANICOS m ON osm.id_mecanico = m.id_mecanico
WHERE m.especialidade = 'Motor';

-- 9.4 Agregações com Condições Complexas (HAVING)
SELECT '--- 9.4.1 Clientes que gastaram mais de R$ 5.000,00 (HAVING) ---' AS CONSULTA;
SELECT
    c.id_cliente,
    c.nome_cliente,
    SUM(COALESCE(oss.preco_cobrado * oss.quantidade, 0) + COALESCE(osp.preco_unitario_cobrado * osp.quantidade_usada, 0)) AS total_gasto
FROM CLIENTE c
JOIN VEICULOS v ON c.id_cliente = v.id_cliente
JOIN ORDENS_SERVICO os ON v.id_veiculo = os.id_veiculo
LEFT JOIN OS_SERVICOS oss ON os.id_os = oss.id_os
LEFT JOIN OS_PECAS osp ON os.id_os = osp.id_os
GROUP BY c.id_cliente, c.nome_cliente
HAVING total_gasto > 5000.00;

SELECT '--- 9.4.2 Peças vendidas mais de 100 vezes (HAVING) ---' AS CONSULTA;
SELECT id_peca, SUM(quantidade_usada) AS total_vendido
FROM OS_PECAS
GROUP BY id_peca
HAVING total_vendido > 100;

SELECT '--- 9.4.3 Especialidades que trabalharam em mais de 20 OS (HAVING) ---' AS CONSULTA;
SELECT
    m.especialidade,
    COUNT(osm.id_os) AS total_os_por_especialidade
FROM MECANICOS m
JOIN OS_MECANICOS osm ON m.id_mecanico = osm.id_mecanico
GROUP BY m.especialidade
HAVING total_os_por_especialidade > 20;

SELECT '--- 9.4.4 (Desafio) Mecânico que mais trabalhou em OS (ORDER BY + LIMIT) ---' AS CONSULTA;
SELECT
    m.nome_mecanico,
    COUNT(osm.id_os) AS total_os_trabalhadas
FROM MECANICOS m
JOIN OS_MECANICOS osm ON m.id_mecanico = osm.id_mecanico
GROUP BY m.nome_mecanico
ORDER BY total_os_trabalhadas DESC
LIMIT 1;

-- --------------------------------------------------
-- 10. Indexação e Explicações (SQL já executado)
-- --------------------------------------------------
SELECT '--- 10. Explicações (As ações DDL foram executadas no início) ---' AS INFO;
SELECT '10.1: O índice na placa_veiculo foi criado no início (CREATE UNIQUE INDEX idx_placa_veiculo ON VEICULOS (placa_veiculo);)';
SELECT '10.2: O índice na chave estrangeira ORDENS_SERVICO.id_veiculo foi criado no início (CREATE INDEX idx_id_veiculo_os ON ORDENS_SERVICO (id_veiculo);)';
SELECT '10.2: A JUNÇÃO entre Ordens_Servico e Veiculos por id_veiculo é rápida porque id_veiculo é a chave primária (indexada) em VEICULOS e o índice foi criado explicitamente na chave estrangeira em ORDENS_SERVICO. Sem a indexação na FK, o banco faria uma varredura completa (full table scan) em Ordens_Servico, o que prejudicaria drasticamente a performance.';
SELECT '10.3: Um ÍNDICE COMPOSTO (ex: na PK de OS_Pecas (id_os, id_peca)) é mais eficiente para consultas que filtram por id_os E id_peca porque ele armazena e ordena as chaves em conjunto. Isso permite que o banco vá diretamente ao bloco de dados desejado, minimizando leituras no disco.';