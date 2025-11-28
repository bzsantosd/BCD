<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <title>Sistema de Gerenciamento da Oficina</title>
  <style>
    /* --- Estilos de Estrutura --- */
    body { 
      font-family: Arial, sans-serif; 
      margin: 40px; 
      background-color: #f4f4f9; 
    }
    .container { 
      max-width: 800px; 
      margin: auto; 
      background: white; 
      padding: 30px; 
      border-radius: 8px; 
      box-shadow: 0 0 10px rgba(0,0,0,0.1); 
    }
    h1 { 
      text-align: center; 
      color: #333; 
    }
    
    /* --- Estilos do Grid (MANTIDOS PARA OS 3 PRIMEIROS) --- */
    .menu-grid { 
      display: grid; 
      grid-template-columns: repeat(3, 1fr); /* 3 colunas iguais */
      gap: 20px; 
      margin-top: 30px; 
    }

    /* --- NOVO: Estilos para a Última Linha Centralizada --- */
    .last-row-centered {
      display: flex;
      justify-content: center; /* Centraliza horizontalmente */
      gap: 20px;
      margin-top: 20px; /* Adiciona espaço acima da nova linha */
    }

    /* Ajuste para o tamanho dos itens na última linha */
    .last-row-centered .menu-item {
      flex-basis: 230px; /* Define uma largura base para os itens */
      flex-grow: 0; /* Impede que eles cresçam para preencher todo o espaço */
    }

    /* --- Estilos Base do Item de Menu --- */
    .menu-item {
      text-decoration: none;
      color: white;
      padding: 25px;
      border-radius: 6px;
      text-align: center;
      font-size: 18px;
      font-weight: bold;
      transition: background-color 0.3s;
      background-color: #555; 
    }
    
    /* --- Cores de Fundo por Seção --- */
    .item-cliente { background-color: #388E3C; }
    .item-estoque { background-color: #388E3C; }
    .item-mecanico { background-color: #388E3C; }
    .item-servico { background-color: #388E3C; }
    .item-veiculo { 
      background-color: #388E3C; 
      color: #ffffff; 
    }

    /* --- Efeito Hover --- */
    .menu-item:hover { 
      opacity: 0.85; 
    }
    .item-cliente:hover { background-color: #388E3C; }
    .item-estoque:hover { background-color: #388E3C; }
    .item-mecanico:hover { background-color: #388E3C; }
    .item-servico:hover { background-color: #388E3C; }
    .item-veiculo:hover { background-color: #388E3C; }
    
    /* Media Query para Telas Menores (garantir responsividade) */
    @media (max-width: 700px) {
      .menu-grid {
        grid-template-columns: 1fr; /* Coluna única em telas pequenas */
      }
      .last-row-centered {
        flex-direction: column; /* Itens empilhados em telas pequenas */
      }
      .last-row-centered .menu-item {
        flex-basis: auto;
      }
    }
  </style>
</head>
<body>

  <div class="container">
    <h1>Gerenciamento da Oficina Mecânica</h1>
    
    <div class="menu-grid">
      <a href="cliente.php" class="menu-item item-cliente">Cliente</a>
      <a href="estoque.php" class="menu-item item-estoque">Estoque</a>
      <a href="mecanicos.php" class="menu-item item-mecanico">Mecânicos</a>
    </div>

    <div class="last-row-centered">
      <a href="servico.php" class="menu-item item-servico">Serviço</a>
      <a href="veiculo.php" class="menu-item item-veiculo">Veículo</a>
    </div>
  </div>

</body>
</html>