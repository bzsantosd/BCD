<?php
$conn = new mysqli("localhost","root","senaisp","teste");

$id =$_POST["id_usuario"];
$nome =$_POST["nome"];
$email =$_POST["email"];

$sql = "UPDATE usuarios SET nome= '$nome', email='$email' WHERE id_usuario='$id'";

if($conn->query($sql) === TRUE) {
    echo "Dados atualizados com sucesso!";
    echo "<br><a href='index.html'>Voltar</a>";
} else {
    echo "Erro:" . $conn->error;
}
$conn->close();
?>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meu CRUD Simples</title>
    <link rel="stylesheet" href="style.css">
</head>