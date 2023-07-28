-- Vamos saber o nome da pessoa que pediu mais produtos, os produtos pedidos e em quais pedidos estão:
SELECT
	pessoas_fisicas.id AS id_pessoas,
    pessoas_fisicas.nome AS pessoa,
    produtos.descricao AS produto,
    pedidos.id AS pedido,
    qtd.quantidade
FROM produtos_nos_pedidos
INNER JOIN pedidos ON produtos_nos_pedidos.pedido_id = pedidos.id
INNER JOIN produtos ON produtos_nos_pedidos.produto_id = produtos.id
INNER JOIN clientes ON pedidos.cliente_id = clientes.id
INNER JOIN pessoas_fisicas ON clientes.pessoa_fisica_id = pessoas_fisicas.id
INNER JOIN (
    SELECT pessoas_fisicas.nome, count(*) AS quantidade
    FROM produtos_nos_pedidos
	INNER JOIN pedidos ON produtos_nos_pedidos.pedido_id = pedidos.id
	INNER JOIN clientes ON pedidos.cliente_id = clientes.id
	INNER JOIN pessoas_fisicas ON clientes.pessoa_fisica_id = pessoas_fisicas.id
    GROUP BY pessoas_fisicas.nome
) AS qtd ON pessoas_fisicas.nome = qtd.nome
ORDER BY quantidade DESC, pessoa ASC;

-- Vamos saber mais informações sobre a pessoa de id = 5, que foi quem pediu mais produtos:
SELECT 
    pessoas_fisicas.nome AS pessoa,
    pessoas_fisicas.cpf,
    timestampdiff(year, pessoas_fisicas.nascimento, now()) AS idade,
    telefones.numero AS telefone,
    concat(enderecos.cidade, "/", enderecos.estado) AS cidade
FROM pessoas_fisicas
INNER JOIN telefones_de_pessoas_fisicas ON pessoas_fisicas.id = telefones_de_pessoas_fisicas.pessoa_fisica_id
INNER JOIN enderecos_de_pessoas_fisicas ON pessoas_fisicas.id = enderecos_de_pessoas_fisicas.pessoa_fisica_id
INNER JOIN telefones ON telefones_de_pessoas_fisicas.telefone_id = telefones.id
INNER JOIN enderecos ON enderecos_de_pessoas_fisicas.endereco_id = enderecos.id
WHERE pessoas_fisicas.id = 5;

-- Vamos saber a quantidade de pedidos nos quais a forma de envio escolhida foi transportadora.
SELECT
	pedidos.forma_de_envio,
    CONCAT(ROUND(COUNT(*) * 100 / quantidade.qtd, 2), '%') AS porcentagem
FROM pedidos
INNER JOIN (
    SELECT pedidos.forma_de_envio, COUNT(*) AS qtd
    FROM pedidos
    GROUP BY forma_de_envio
) AS quantidade ON pedidos.forma_de_envio = quantidade.forma_de_envio
GROUP BY forma_de_envio
HAVING forma_de_envio = "transportadora";