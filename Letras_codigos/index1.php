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
if ($result = $mysqli->query('select * from livros_vendas order by' . $column . '' . $sort_order)) {
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
                <th><a href="index1.php?column=titulo&order=<?php echo $asc_or_desc; ?>">Título <?php echo $column == 'titulo' ? '-' . $up_or_down : ''; ?> </th>

                <th><a href="index1.php?column=data&order=<?php echo $asc_or_desc; ?>">Data <?php echo $column == 'data_venda' ? '-' . $up_or_down : ''; ?> </th>

                <th><a href="index1.php?column=preco&order=<?php echo $asc_or_desc; ?>">Preco <?php echo $column == 'preco' ? '-' . $up_or_down : ''; ?> </th>
            </tr>
            <?php while ($row = $result->fetch_assoc()): ?>
                <tr>
                    <td <?php echo $column =='titulo' ? $add_class : ''; ?>> <?php echo $row ['titulo']; ?> </td>

                     <td <?php echo $column =='data_venda' ? $add_class : ''; ?>> <?php echo $row ['data_venda']; ?> </td>

                     <td <?php echo $column =='preco' ? $add_class : ''; ?>> <?php echo $row ['preco']; ?> </td>
            </tr>
                <?php endwhile;?>
        </table>
    </body>
    </html>
    <?php $result->free();
}
?>