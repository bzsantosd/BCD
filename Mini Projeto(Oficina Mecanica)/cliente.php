<?php
include 'conexao.php'; // Inclui a conexão única

$mensagem = "";
$cliente_edicao = null;

// --- CREATE (INSERT) ---
if (isset($_POST['adicionar'])) {
    $nome = $conexao->real_escape_string($_POST['nome']);
    $cpf = $conexao->real_escape_string($_POST['cpf']);
    $endereco = $conexao->real_escape_string($_POST['endereco']);
    $contato = $conexao->real_escape_string($_POST['contato']);

    $sql = "INSERT INTO CLIENTE (nome_cliente, cpf_cliente, endereco_cliente, contato_cliente) VALUES ('$nome', '$cpf', '$endereco', '$contato')";

    if ($conexao->query($sql) === TRUE) {
        $mensagem = "<p style='color: green;'>Cliente adicionado com sucesso!</p>";
    } else {
        $mensagem = "<p style='color: red;'>Erro: " . $conexao->error . "</p>";
    }
}

// --- DELETE ---
if (isset($_GET['deletar'])) {
    $id = intval($_GET['deletar']);
    // O ON DELETE CASCADE no SQL garante que os VEÍCULOS sejam deletados primeiro.
    $sql = "DELETE FROM CLIENTE WHERE id_cliente = $id";

    if ($conexao->query($sql) === TRUE) {
        $mensagem = "<p style='color: green;'>Cliente deletado com sucesso!</p>";
    } else {
        $mensagem = "<p style='color: red;'>Erro ao deletar (Pode haver veículos associados): " . $conexao->error . "</p>";
    }
}

// --- UPDATE - Etapa 1: Carregar dados ---
if (isset($_GET['editar'])) {
    $id_edicao = intval($_GET['editar']);
    $sql_edicao = "SELECT * FROM CLIENTE WHERE id_cliente = $id_edicao";
    $resultado_edicao = $conexao->query($sql_edicao);
    if ($resultado_edicao->num_rows == 1) {
        $cliente_edicao = $resultado_edicao->fetch_assoc();
    }
}

// --- UPDATE - Etapa 2: Salvar edição ---
if (isset($_POST['editar_salvar'])) {
    $id = intval($_POST['id_cliente']);
    $nome = $conexao->real_escape_string($_POST['nome']);
    $cpf = $conexao->real_escape_string($_POST['cpf']);
    $endereco = $conexao->real_escape_string($_POST['endereco']);
    $contato = $conexao->real_escape_string($_POST['contato']);

    $sql = "UPDATE CLIENTE SET nome_cliente='$nome', cpf_cliente='$cpf', endereco_cliente='$endereco', contato_cliente='$contato' WHERE id_cliente=$id";

    if ($conexao->query($sql) === TRUE) {
        $mensagem = "<p style='color: green;'>Cliente atualizado com sucesso!</p>";
        header("Location: cliente_crud.php"); // Redireciona para limpar URL
        exit();
    } else {
        $mensagem = "<p style='color: red;'>Erro ao atualizar: " . $conexao->error . "</p>";
    }
}

// --- READ (SELECT) ---
$sql_select = "SELECT * FROM CLIENTE ORDER BY nome_cliente";
$resultado = $conexao->query($sql_select);

$conexao->close(); // Fecha a conexão
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Clientes</title>
    <style>
    /* Estilos base (body, .container, inputs, botões) */
    body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f9; }
    .container { max-width: 900px; margin: auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
    h2 { border-bottom: 2px solid #eee; padding-bottom: 5px; }
    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
    
    /* Estilos que podem ser comuns a todos */
    .form-container input[type="text"] { padding: 8px; margin: 5px 0; border: 1px solid #ccc; border-radius: 4px; width: 100%; box-sizing: border-box; }
    .form-container input[type="submit"], .btn { padding: 10px 15px; margin-top: 10px; border: none; border-radius: 4px; cursor: pointer; color: white; }
    .btn-add { background-color: #ffa500; }
    .btn-edit { background-color: #0063BF; }
    .btn-delete { background-color: #900; }
    .btn-cancel { background-color: #777; }
    .btn-back { display: block; width: 150px; text-align: center; text-decoration: none; background-color: #555; margin-top: 20px; }
    
    /* Estilos específicos de cor (Verde) */
    h1 { color: #388E3C; }
    th { background-color: #388E3C; color: white; }
  </style>
    </style>
</head>
<body>

    <div class="container">
        <h1> Gerenciamento de Clientes</h1>
        <?= $mensagem ?>

        <h2><?= $cliente_edicao ? ' Editar Cliente' : 'Adicionar Novo Cliente' ?></h2>

        <div class="form-container">
            <form method="POST">
                <?php if ($cliente_edicao): ?>
                    <input type="hidden" name="id_cliente" value="<?= $cliente_edicao['id_cliente'] ?>">
                <?php endif; ?>

                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" value="<?= $cliente_edicao ? $cliente_edicao['nome_cliente'] : '' ?>" required>

                <label for="cpf">CPF:</label>
                <input type="text" id="cpf" name="cpf" value="<?= $cliente_edicao ? $cliente_edicao['cpf_cliente'] : '' ?>">

                <label for="endereco">Endereço:</label>
                <input type="text" id="endereco" name="endereco" value="<?= $cliente_edicao ? $cliente_edicao['endereco_cliente'] : '' ?>">

                <label for="contato">Contato:</label>
                <input type="text" id="contato" name="contato" value="<?= $cliente_edicao ? $cliente_edicao['contato_cliente'] : '' ?>">

                <?php if ($cliente_edicao): ?>
                    <input type="submit" name="editar_salvar" value="Salvar Edição" class="btn-edit">
                    <a href="cliente_crud.php" class="btn btn-cancel">Cancelar</a>
                <?php else: ?>
                    <input type="submit" name="adicionar" value="Adicionar Cliente" class="btn-add">
                <?php endif; ?>
            </form>
        </div>

        <h2>Lista de Clientes</h2>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>CPF</th>
                    <th>Endereço</th>
                    <th>Contato</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <?php
                if ($resultado->num_rows > 0) {
                    while($row = $resultado->fetch_assoc()) {
                        echo "<tr>";
                        echo "<td>" . $row["id_cliente"] . "</td>";
                        echo "<td>" . $row["nome_cliente"] . "</td>";
                        echo "<td>" . $row["cpf_cliente"] . "</td>";
                        echo "<td>" . $row["endereco_cliente"] . "</td>";
                        echo "<td>" . $row["contato_cliente"] . "</td>";
                        echo "<td>
                                <a href='?editar=" . $row["id_cliente"] . "' class='btn btn-edit'>Editar</a>
                                <a href='?deletar=" . $row["id_cliente"] . "' onclick=\"return confirm('ATENÇÃO: Deletar cliente também remove VEÍCULOS associados. Tem certeza?');\" class='btn btn-delete'>Deletar</a>
                              </td>";
                        echo "</tr>";
                    }
                } else {
                    echo "<tr><td colspan='6'>Nenhum cliente encontrado.</td></tr>";
                }
                ?>
            </tbody>
        </table>
        
        <a href="index.php" class="btn btn-back">Voltar ao Menu</a>
    </div>

</body>
</html>