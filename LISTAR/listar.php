<?php
$conn = new mysqli("localhost", "root", "senaisp", "teste");
$result = $conn->query("SELECT * FROM usuarios");

echo "<h2>Usuários</h2>";
echo "<table border='1'>";
echo "<tr><th>ID</th><th>Nome</th><th>Email</th><th>Ações</th></tr>";

while ($row = $result->fetch_assoc()) {
    echo "<tr>
    <td>{$row['id_usuario']}</td>
    <td>{$row['nome']}</td>
    <td>{$row['email']}</td>
    <td><a href='editar.php?id={$row['id_usuario']}'>Editar</a></td></tr>";

}
echo "</table>";
$conn->close();
?>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meu CRUD Simples</title>
    <link rel="stylesheet" href="style.css">
</head>
<a href="index.html"><button type="button">Página Inicial</button></a>

