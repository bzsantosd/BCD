-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.
CREATE DATABASE CURSOS_ON;
USE CURSOS_ON;
SELECT DATABASE();


CREATE TABLE Alunos (
id_aluno int auto_increment primary key  PRIMARY KEY,
nome varchar(100),
email int not null,
data_nascimento datetime
);

CREATE TABLE Cursos (
id_curso int auto_increment primary key  PRIMARY KEY,
titulo_curso varchar(100),
descricao varchar(255),
carga_horaria int not null,
status varchar(10)
);

CREATE TABLE Inscricoes (
id_inscricao int auto_increment primary key,
data_inscricao datetime,
id_aluno int ,
id_curso int ,
FOREIGN KEY(id_aluno) REFERENCES Alunos (id_aluno),
FOREIGN KEY(id_curso) REFERENCES Cursos (id_curso)
);

CREATE TABLE Avaliacoes (
id_avaliacao int auto_increment primary key,
nota decimal(5,2),
comentario varchar(255),
id_inscricao int ,
FOREIGN KEY(id_inscricao) REFERENCES Inscricoes (id_inscricao)
);

ALTER TABLE Alunos MODIFY column email varchar(100) not null;
INSERT INTO Alunos (Alunos.nome, Alunos.email, Alunos.data_nascimento) VALUES
( 'Ana Silva', 'ana.silva@email.com', '1998-05-20'),
( 'Bruno Costa', 'bruno.costa@email.com', '1995-11-15'),
( 'Carla Lima', 'carla.lima@email.com', '2000-08-01'),
( 'Daniel Alves', 'daniel.alves@email.com', '1997-03-25'),
( 'Erica Fernandes', 'erica.fernandes@email.com', '1999-01-10');

-- INSERT
INSERT INTO Cursos (titulo_curso, descricao, carga_horaria, status) VALUES
('Fundamentos de SQL', 'Curso introdutório que cobre SELECT, INSERT, UPDATE e DELETE.', 40, 'ativo'),
('Desenvolvimento Web com Python', 'Aprenda a construir aplicações web usando Python e Django/Flask.', 120, 'inativo'),
('Design UX/UI', 'Introdução à experiência do usuário e interface com foco em projetos práticos.', 60, 'ativo'),
('Marketing Digital Avançado', 'Estratégias de SEO, SEM e mídias sociais para crescimento de negócios.', 80, 'ativo'),
('Introdução à Contabilidade', 'Noções básicas e princípios contábeis para iniciantes no mercado financeiro.', 30, 'inativo');

INSERT INTO Inscricoes (data_inscricao, id_aluno, id_curso) VALUES
('2025-10-01 08:00:00', 1, 1), -- Aluno 1 se inscreve no Curso 
('2025-10-01 10:30:00', 2, 2), -- Aluno 2 se inscreve no Curso 
('2025-10-02 14:00:00', 4, 1), -- Aluno 3 se inscreve no Curso 
('2025-10-03 09:45:00', 4, 4), -- Aluno 4 se inscreve no Curso 
('2025-10-04 11:15:00', 5, 5); -- Aluno 5 se inscreve no Curso 

INSERT INTO Avaliacoes (nota, comentario, id_inscricao) VALUES
(9.80, 'Conteúdo muito relevante e superou as expectativas.', 11),  -- Avalia a Inscrição 1
(7.50, 'Bom, mas senti falta de exercícios mais desafiadores.', 12),  -- Avalia a Inscrição 2
(10.00, 'Perfeito! Recomendo a todos os iniciantes.', 13), -- Avalia a Inscrição 3
(8.90, 'Ótimo curso, o professor é muito didático.', 14),  -- Avalia a Inscrição 4
(6.00, 'Achei o ritmo um pouco lento e o material desatualizado.', 15); -- Avalia a Inscrição 5

-- UPDATE
UPDATE Alunos
SET Alunos.nome = "Luiza"
WHERE Alunos.id_aluno = 1;

UPDATE Alunos
SET Alunos.email = 'takemiluiza.novo@dominio.com'
WHERE Alunos.id_aluno = 1;

UPDATE Cursos
SET Cursos.carga_horaria = 90
WHERE Cursos.id_curso = 3;

UPDATE Cursos
SET Cursos.status = 'inativo'
WHERE Cursos.id_curso = 4;

UPDATE Avaliacoes
SET Avaliacoes.nota = 10.0
WHERE Avaliacoes.id_avaliacao = 2;

-- DELETE 
SELECT * FROM Cursos;

SELECT * FROM Inscricoes;

SELECT * FROM Avaliacoes;
DELETE FROM Avaliacoes WHERE Avaliacoes.id_avaliacao =15;
DELETE FROM Inscricoes WHERE Inscricoes.id_inscricao = 15;

DELETE FROM Cursos WHERE cursos.id_curso = 5;
DELETE FROM Alunos WHERE Alunos.id_aluno = 5;

-- select
SELECT *
FROM Alunos;

SELECT nome, email
FROM Alunos;

SELECT titulo_curso, carga_horaria
FROM Cursos
WHERE carga_horaria > 30;

SELECT titulo_curso, status
FROM Cursos
WHERE status = 'inativo';

SELECT nome, data_nascimento
FROM Alunos
WHERE data_nascimento > '1995-12-31';


SELECT id_avaliacao, nota, comentario
FROM Avaliacoes
WHERE nota > 9.0;

SELECT COUNT(*) AS total_cursos
FROM Cursos;

SELECT titulo_curso, carga_horaria
FROM Cursos
ORDER BY carga_horaria DESC
LIMIT 3;

-- DESAFIO EXTRA
CREATE INDEX idx_aluno_email
ON Alunos (email);

