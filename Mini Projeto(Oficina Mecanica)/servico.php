<?php
include 'conexao.php';

$mensagem = "";
$servico_edicao = null;

// --- CREATE (INSERT) ---
if (isset($_POST['adicionar'])) {
    $nome = $conexao->real_escape_string($_POST['nome']);
    $valor = floatval($_POST['valor']);
    $data_entrega = $conexao->real_escape_string($_POST['data_entrega']);
    $tipo_veiculo = $conexao->real_escape_string($_POST['tipo_veiculo']);

    $sql = "INSERT INTO SERVICOS (nome_servico, valor_servico, data_entrega_servico, tipo_veiculo) 
            VALUES ('$nome', $valor, '$data_entrega', '$tipo_veiculo')";

    if ($conexao->query($sql) === TRUE) {
        $mensagem = "<p style='color: green;'> Serviço adicionado com sucesso!</p>";
    } else {
        $mensagem = "<p style='color: red;'> Erro: " . $conexao->error . "</p>";
    }
}

// --- DELETE ---
if (isset($_GET['deletar'])) {
    $id = intval($_GET['deletar']);
    $sql = "DELETE FROM SERVICOS WHERE id_servico = $id";

    if ($conexao->query($sql) === TRUE) {
        $mensagem = "<p style='color: green;'> Serviço deletado com sucesso!</p>";
    } else {
        $mensagem = "<p style='color: red;'> Erro ao deletar: " . $conexao->error . "</p>";
    }
}

// --- UPDATE - Etapa 1: Carregar dados ---
if (isset($_GET['editar'])) {
    $id_edicao = intval($_GET['editar']);
    $sql_edicao = "SELECT * FROM SERVICO WHERE id_servico = $id_edicao";
    $resultado_edicao = $conexao->query($sql_edicao);
    if ($resultado_edicao->num_rows == 1) {
        $servico_edicao = $resultado_edicao->fetch_assoc();
    }
}

// --- UPDATE - Etapa 2: Salvar edição ---
if (isset($_POST['editar_salvar'])) {
    $id = intval($_POST['id_servico']);
    $nome = $conexao->real_escape_string($_POST['nome']);
    $valor = floatval($_POST['valor']);
    $data_entrega = $conexao->real_escape_string($_POST['data_entrega']);
    $tipo_veiculo = $conexao->real_escape_string($_POST['tipo_veiculo']);

    $sql = "UPDATE SERVICOS SET nome_servico='$nome', valor_servico=$valor, data_entrega_servico='$data_entrega', tipo_veiculo='$tipo_veiculo' WHERE id_servico=$id";

    if ($conexao->query($sql) === TRUE) {
        $mensagem = "<p style='color: green;'> Serviço atualizado com sucesso!</p>";
        header("Location: servico_crud.php"); 
        exit();
    } else {
        $mensagem = "<p style='color: red;'> Erro ao atualizar: " . $conexao->error . "</p>";
    }
}

// --- READ (SELECT) ---
$sql_select = "SELECT * FROM SERVICOS ORDER BY data_entrega_servico DESC";
$resultado = $conexao->query($sql_select);

$conexao->close();
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Serviços</title>
   <style>
    /* Estilos base (body, .container, tabelas, inputs, botões) */
    body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f9; }
    .container { max-width: 900px; margin: auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
    table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
    
    /* Estilos que podem ser comuns a todos (inclui input[type="date"]) */
    .form-container input[type="text"], .form-container input[type="number"], .form-container input[type="date"] { padding: 8px; margin: 5px 0; border: 1px solid #ccc; border-radius: 4px; width: 100%; box-sizing: border-box; }
    .form-container input[type="submit"], .btn { padding: 10px 15px; margin-top: 10px; border: none; border-radius: 4px; cursor: pointer; color: white; }
    .btn-add { background-color: #ffa500; }
    .btn-edit { background-color: #0063BF; }
    .btn-delete { background-color: #900; }
    .btn-cancel { background-color: #777; }
    .btn-back { display: block; width: 150px; text-align: center; text-decoration: none; background-color: #555; margin-top: 20px; }
    
    /* Estilos específicos de cor (Laranja) */
    h1 { color: #388E3C; }
    th { background-color: #388E3C; color: white; }
  </style>
</head>
<body>

    <div class="container">
        <h1> Gerenciamento de Serviços</h1>
        <?= $mensagem ?>

        <h2><?= $servico_edicao ? ' Editar Serviço' : ' Adicionar Novo Serviço' ?></h2>

        <div class="form-container">
            <form method="POST">
                <?php if ($servico_edicao): ?>
                    <input type="hidden" name="id_servico" value="<?= $servico_edicao['id_servico'] ?>">
                <?php endif; ?>

                <label for="nome">Nome do Serviço:</label>
                <input type="text" id="nome" name="nome" value="<?= $servico_edicao ? $servico_edicao['nome_servico'] : '' ?>" required>

                <label for="valor">Valor (R$):</label>
                <input type="number" step="0.01" id="valor" name="valor" value="<?= $servico_edicao ? $servico_edicao['valor_servico'] : '' ?>" required min="0.00">

                <label for="data_entrega">Data de Entrega:</label>
                <input type="date" id="data_entrega" name="data_entrega" value="<?= $servico_edicao ? $servico_edicao['data_entrega_servico'] : '' ?>">
                
                <label for="tipo_veiculo">Tipo de Veículo:</label>
                <input type="text" id="tipo_veiculo" name="tipo_veiculo" value="<?= $servico_edicao ? $servico_edicao['tipo_veiculo'] : '' ?>">

                <?php if ($servico_edicao): ?>
                    <input type="submit" name="editar_salvar" value="Salvar Edição" class="btn-edit">
                    <a href="servico_crud.php" class="btn btn-cancel">Cancelar</a>
                <?php else: ?>
                    <input type="submit" name="adicionar" value="Adicionar Serviço" class="btn-add">
                <?php endif; ?>
            </form>
        </div>

        <h2>Lista de Serviços</h2>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome do Serviço</th>
                    <th>Valor (R$)</th>
                    <th>Data de Entrega</th>
                    <th>Tipo de Veículo</th>
                    <th>Ações</th>
                </tr>
            </thead>
            <tbody>
                <?php
                if ($resultado->num_rows > 0) {
                    while($row = $resultado->fetch_assoc()) {
                        echo "<tr>";
                        echo "<td>" . $row["id_servico"] . "</td>";
                        echo "<td>" . $row["nome_servico"] . "</td>";
                        echo "<td>R$ " . number_format($row["valor_servico"], 2, ',', '.') . "</td>";
                        echo "<td>" . (new DateTime($row["data_entrega_servico"]))->format('d/m/Y') . "</td>";
                        echo "<td>" . $row["tipo_veiculo"] . "</td>";
                        echo "<td>
                                <a href='?editar=" . $row["id_servico"] . "' class='btn btn-edit'>Editar</a>
                                <a href='?deletar=" . $row["id_servico"] . "' onclick=\"return confirm('Tem certeza que deseja deletar este serviço?');\" class='btn btn-delete'>Deletar</a>
                              </td>";
                        echo "</tr>";
                    }
                } else {
                    echo "<tr><td colspan='6'>Nenhum serviço cadastrado.</td></tr>";
                }
                ?>
            </tbody>
        </table>
        
        <a href="index.php" class="btn btn-back">Voltar ao Menu</a>
    </div>

</body>
</html>