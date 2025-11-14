<?php
// 1. Inclui o arquivo que estabelece a conexão
include 'conexao.php'; // Certifique-se de que este arquivo contém o objeto $conn

// 2. Dados a serem inseridos (Simulação de dados de um formulário POST)
$nome = "João da Silva";
$cpf = "123.456.789-00";
$contato = "99887766"; // Assumindo apenas 8 dígitos
$endereco = "Rua das Flores, 100";

// 3. O SQL para INSERT com '?' como placeholders para os valores
$sql_insert = "INSERT INTO CLIENTE (nome_cliente, cpf_cliente, contato_cliente, endereco_cliente) VALUES (?, ?, ?, ?)";

// 4. Prepara a consulta
$stmt = $conn->prepare($sql_insert);

if ($stmt === false) {
    die('Erro na preparação do SQL: ' . $conn->error);
}

// 5. Liga os parâmetros (Bind Parameters)
/*
 * O primeiro argumento ("ssss") define o tipo de dados:
 * "s" = string para cada um dos 4 campos (nome, cpf, contato, endereco)
*/
$stmt->bind_param("ssss", $nome, $cpf, $contato, $endereco);

// 6. Executa a consulta
if ($stmt->execute()) {
    echo "✅ Cliente inserido com sucesso!";
    // Opcional: Mostra o ID gerado automaticamente
    $novo_id = $conn->insert_id;
    echo " O ID do novo cliente é: " . $novo_id;
} else {
    echo " Erro ao inserir cliente: " . $stmt->error;
}

// 7. Fecha o statement e a conexão
$stmt->close();
$conn->close();
?>