<?php
$servidor = "localhost";
$usuario = "root"; // Mude para o seu usuário
$senha = "senaisp";     // Mude para a sua senha
$banco = "Oficina"; // Mude para o nome do seu DB

// 1. Cria a conexão usando a classe mysqli
$conn = new mysqli($servidor, $usuario, $senha, $banco);

// 2. Verifica se ocorreu algum erro na conexão
if ($conn->connect_error) {
    // Se houver erro, encerra o script e exibe a mensagem de erro
    die("Falha na conexão: " . $conn->connect_error);
}

// 3. Define o charset para evitar problemas com acentuação
$conn->set_charset("utf8");

// Se chegou até aqui, a conexão foi bem-sucedida
// O objeto $conn é a sua conexão ativa
?>