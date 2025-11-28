<?php
// Configurações do Banco de Dados
$host = "localhost";
$usuario = "root";   
$senha = "senaisp";         
$banco = "Oficina"; // Nome do banco criado no setup_db.sql

// Cria a conexão
$conexao = new mysqli($host, $usuario, $senha, $banco);

// Verifica a conexão
if ($conexao->connect_error) {
    die("Falha na conexão com o Banco de Dados: " . $conexao->connect_error);
}

// Define o charset para UTF-8 (acentuação)
$conexao->set_charset("utf8");
?>