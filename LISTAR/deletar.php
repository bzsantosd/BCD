<?php
$conn = new mysqli("localhost", "root", "senaisp", "teste");
if ($conn->connect_error) {
    die("Erro de conexão". $conn->connect_error);
}
$id = $_GET['id'];

//preparar a declaração
$stmt = $conn->prepare("DELETE FROM usuarios WHERE id_usuario = ?");
$stmt->bind_param("i", $id);

//executar e verificar
if ($stmt->execute()) {
    echo "Usuario deletado com sucesso!";
} else {
    echo "Erro ao deletar" . $stmt->error;
}
echo "<br><a href='listar.php'>Voltar para a lista</a>";

$stmt->close();
$conn->close() ;
?>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meu CRUD Simples</title>
    <link rel="stylesheet" href="style.css">
</head>