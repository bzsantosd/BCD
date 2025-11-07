<?php
$conn = new mysqli("localhost", "root", "senaisp", "teste");

$id = $_GET['id'];
$result = $conn->query("SELECT * FROM usuarios WHERE id_usuario = $id");
$row = $result->fetch_assoc();
?>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meu CRUD Simples</title>
    <link rel="stylesheet" href="style.css">
</head>
<form action="atualizar.php" method="POST">
    <input type="hidden" name="id_usuario" value="<?php echo $row['id_usuario']; ?>">
    Nome: <input type="text" name="nome" value="<?php echo $row['nome']; ?>"><br>
    Emal: <input type="email" name="email" value="<?php echo $row['email']; ?>"><br>
    <input type="submit" value="Atualizar">
</form>