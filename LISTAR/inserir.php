<?php
$nome = $_POST['nome'];
$email = $_POST['email'];

$conn = new mysqli("localhost","root","senaisp","teste");

if ($conn->connect_error) {
    die("Erro de conexão:". $conn->connect_error);
}

$sql = "INSERT INTO usuarios (nome, email) VALUES ('$nome', '$email')";
if ($conn->query($sql) === TRUE) {
    echo "Dados salvos com sucesso!";
} else {
    echo "Erro: " . $conn->error;
}
// header("Location: index.html"); // ou index.php, dependendo do seu arquivo principal
$conn->close();
exit;

?>
