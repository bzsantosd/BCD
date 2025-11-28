<?php
include 'conexao.php'; 

$mensagem = "";
$peca_edicao = null;

// --- CREATE (INSERT) ---
if (isset($_POST['adicionar'])) {
    $nome = $conexao->real_escape_string($_POST['nome']);
    $qtde = intval($_POST['qtde']);
    $valor = floatval($_POST['valor']);
    $local = $conexao->real_escape_string($_POST['local']);

    $sql = "INSERT INTO ESTOQUE (nome_peca, qtde_estoque, valor_peca, local_estoque) 
            VALUES ('$nome', $qtde, $valor, '$local')";

    if ($conexao->query($sql) === TRUE) {
        $mensagem = "<p style='color: green;'>Peça adicionada com sucesso!</p>";
    } else {
        $mensagem = "<p style='color: red;'> Erro: " . $conexao->error . "</p>";
    }
}

// --- DELETE ---
if (isset($_GET['deletar'])) {
    $id = intval($_GET['deletar']);
    $sql = "DELETE FROM ESTOQUE WHERE id_peca = $id";

    if ($conexao->query($sql) === TRUE) {
        $mensagem = "<p style='color: green;'> Peça deletada com sucesso!</p>";
    } else {
        $mensagem = "<p style='color: red;'>Erro ao deletar: " . $conexao->error . "</p>";
    }
}

// --- UPDATE - Etapa 1: Carregar dados ---
if (isset($_GET['editar'])) {
    $id_edicao = intval($_GET['editar']);
    $sql_edicao = "SELECT * FROM ESTOQUE WHERE id_peca = $id_edicao";
    $resultado_edicao = $conexao->query($sql_edicao);
    if ($resultado_edicao->num_rows == 1) {
        $peca_edicao = $resultado_edicao->fetch_assoc();
    }
}

// --- UPDATE - Etapa 2: Salvar edição ---
if (isset($_POST['editar_salvar'])) {
    $id = intval($_POST['id_peca']);
    $nome = $conexao->real_escape_string($_POST['nome']);
    $qtde = intval($_POST['qtde']);
    $valor = floatval($_POST['valor']);
    $local = $conexao->real_escape_string($_POST['local']);

    $sql = "UPDATE ESTOQUE SET nome_peca='$nome', qtde_estoque=$qtde, valor_peca=$valor, local_estoque='$local' WHERE id_peca=$id";

    if ($conexao->query($sql) === TRUE) {
        $mensagem = "<p style='color: green;'> Peça atualizada com sucesso!</p>";
        header("Location: estoque_crud.php"); 
        exit();
    } else {
        $mensagem = "<p style='color: red;'> Erro ao atualizar: " . $conexao->error . "</p>";
    }
}

// --- READ (SELECT) ---
$sql_select = "SELECT * FROM ESTOQUE ORDER BY nome_peca";
$resultado = $conexao->query($sql_select);

$conexao->close(); 
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Estoque</title>
    <style>
    /* Estilos base (body, .container, tabelas, inputs, botões) */
    body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f9; }
    .container { max-width: 900px; margin: auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }

    /* Estilos que podem ser comuns a todos */
    .form-container input[type="text"], .form-container input[type="number"] { padding: 8px; margin: 5px 0; border: 1px solid #ccc; border-radius: 4px; width: 100%; box-sizing: border-box; }
    .form-container input[type="submit"], .btn { padding: 10px 15px; margin-top: 10px; border: none; border-radius: 4px; cursor: pointer; color: white; }
    .btn-add { background-color: #ffa500; }
    .btn-edit { background-color: #0063BF; }
    .btn-delete { background-color: #900; }
    .btn-cancel { background-color: #777; }
    .btn-back { display: block; width: 150px; text-align: center; text-decoration: none; background-color: #555; margin-top: 20px; }
    
    /* Estilos específicos de cor (Roxo) */
    h1 { color: #388E3C; }
    th { background-color: #388E3C; color: white; }
  </style>
</head>
<body>

    <div class="container">
        <h1>Gerenciamento de Estoque</h1>
        <?= $mensagem ?>

        <h2><?= $peca_edicao ? ' Editar Peça' : 'Adicionar Nova Peça' ?></h2>

        <div class="form-container">
            <form method="POST">
                <?php if ($peca_edicao): ?>
                    <input type="hidden" name="id_peca" value="<?= $peca_edicao['id_peca'] ?>">
                <?php endif; ?>

                <label for="nome">Nome da Peça:</label>
                <input type="text" id="nome" name="nome" value="<?= $peca_edicao ? $peca_edicao['nome_peca'] : '' ?>" required>

                <label for="qtde">Quantidade em Estoque:</label>
                <input type="number" id="qtde" name="qtde" value="<?= $peca_edicao ? $peca_edicao['qtde_estoque'] : '' ?>" required min="0">

                <label for="valor">Valor (R$):</label>
                <input type="number" step="0.01" id="valor" name="valor" value="<?= $peca_edicao ? $peca_edicao['valor_peca'] : '' ?>" required min="0.01">
                
                <label for="local">Localização no Estoque:</label>
                <input type="text" id="local" name="local" value="<?= $peca_edicao ? $peca_edicao['local_estoque'] : '' ?>">

                <?php if ($peca_edicao): ?>
                    <input type="submit" name="editar_salvar" value="Salvar Edição" class="btn-edit">
                    <a href="estoque_crud.php" class="btn btn-cancel">Cancelar</a>
                <?php else: ?>
                    <input type="submit" name="adicionar" value="Adicionar Peça" class="btn-add">
                <?php endif; ?>
            </form>
        </div>

        <h2> Lista de Peças</h2>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome da Peça</th>
                    <th>Quantidade</th>
                    <th>Valor (R$)</th>
                    <th>Local</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <?php
                if ($resultado->num_rows > 0) {
                    while($row = $resultado->fetch_assoc()) {
                        echo "<tr>";
                        echo "<td>" . $row["id_peca"] . "</td>";
                        echo "<td>" . $row["nome_peca"] . "</td>";
                        echo "<td>" . $row["qtde_estoque"] . "</td>";
                        echo "<td>R$ " . number_format($row["valor_peca"], 2, ',', '.') . "</td>";
                        echo "<td>" . $row["local_estoque"] . "</td>";
                        echo "<td>
                                <a href='?editar=" . $row["id_peca"] . "' class='btn btn-edit'>Editar</a>
                                <a href='?deletar=" . $row["id_peca"] . "' onclick=\"return confirm('Tem certeza que deseja deletar esta peça?');\" class='btn btn-delete'>Deletar</a>
                              </td>";
                        echo "</tr>";
                    }
                } else {
                    echo "<tr><td colspan='6'>Nenhuma peça em estoque.</td></tr>";
                }
                ?>
            </tbody>
        </table>
        
        <a href="index.php" class="btn btn-back">Voltar ao Menu</a>
    </div>

</body>
</html>