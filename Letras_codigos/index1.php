<?php
// comunicacao com o banco de dados
$mysqli = mysqli_connect('localhost','root','senaisp','Letras_Codigos');

// seguranca em buscar valores no banco
$columns = array('titulo','data_venda', 'preco');

// trazer conteudo do banco
$column = isset($_GET['column']) && in_array($_GET['column'], $columns) ? $_GET['column']: $columns[0];

// trazer dados em ordem decrescente
$sort_order = isset($_GET['order']) && strtolower ($_GET['order']) == 'desc' ?'DESC' : 'ASC';

//verificar dados no banco
if ($result = $mysqli->query('select * from livros order by' . $column . '' . $sort_order)) {
    // varias para a tabela
    $up_or_down = str_replace(array('ASC','DESC'), array('up', 'down'), $sort_order);
    $asc_or_desc = $sort_order == 'ASC' ? 'desc' : 'asc';
    $add_class = 'class="highlight"';
    ?>

    <!DOCTYPE html>
    <html>
       <head>
        <title>Banco de Dados - Códigos e Letras</title>
        <meta charset="utf-8">
    </head>
    <body>
        <table>
            <tr>
                <th><a href="index1.php?column=titulo&order=<?php echo $asc_or_desc; ?>">Título</th>
            </tr>
        </table>
    </body>
    </html>
}

