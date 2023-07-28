-- Vamos saber qual cliente fez mais pedidos:
SELECT
    cliente_id_cliente AS id_cliente,
    concat(cliente.pnome, " ", cliente.nome_do_meio, " ", cliente.sobrenome) AS nome_cliente,
    count(*) AS pedidos
FROM pedido
INNER JOIN cliente ON cliente.id_cliente = pedido.cliente_id_cliente
GROUP BY cliente_id_cliente, nome_cliente
ORDER BY pedidos DESC;

-- Reparando que o cliente 1 foi quem fez mais pedidos, vamos obter mais informações do cliente 1:
SELECT 
    concat(pnome, " ", nome_do_meio, " ", sobrenome) AS nome,
    cpf,
    endereco,
    timestampdiff(year, data_de_nascimento, now()) AS idade
FROM cliente WHERE id_cliente = 1;

-- Vamos obter as pessoas que fizeram pedidos e os produtos que estavam disponíveis nos pedidos:
SELECT
    concat(cliente.pnome, " ", cliente.nome_do_meio, " ", cliente.sobrenome) AS nome_cliente,
    produto.categoria,
    produto.descricao AS descricao_produto,
    produto.categoria,
    produto.valor,
    pedido.descricao AS descricao_pedido,
    produto_pedido.status_produto_pedido
FROM produto_pedido
INNER JOIN produto ON produto.id_produto = produto_pedido.id_produto
INNER JOIN pedido ON pedido.id_pedido = produto_pedido.id_pedido
INNER JOIN cliente ON cliente.id_cliente = pedido.cliente_id_cliente
WHERE status_produto_pedido = "disponível";

-- Vamos obter a quantidade de produtos de cada categoria cuja média dos valores é maior que R$1000,00:
SELECT 
    produto.categoria,
    count(*) AS quantidade,
    round(avg(produto.valor), 2) AS media_dos_valores
FROM produto
GROUP BY produto.categoria
HAVING media_dos_valores > 1000;

-- Vamos obter a quantidade de produtos de cada categoria cuja média dos valores é menor que R$1000,00:
SELECT 
    produto.categoria,
    count(*) AS quantidade,
    round(avg(produto.valor), 2) AS media_dos_valores
FROM produto
GROUP BY produto.categoria
HAVING media_dos_valores < 1000;

-- Vamos obter os vendedores terceiros que tem produtos e as informações dos produtos:
SELECT
    vendedor_terceiro.nome_fantasia AS terceiro,
    vendedor_terceiro.local_vendedor_terceiro AS endereco,
    vendedor_terceiro.cnpj,
    produto.descricao AS produto,
    produto_vendedor_tereceiro.quantidade
FROM produto_vendedor_tereceiro
INNER JOIN vendedor_terceiro ON vendedor_terceiro.id_vendedor_terceiro = id_p_seller
INNER JOIN produto ON produto.id_produto = produto_vendedor_tereceiro.id_produto
WHERE quantidade > 0;