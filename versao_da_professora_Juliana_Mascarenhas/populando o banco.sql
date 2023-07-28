USE e_commerce_da_professora;

INSERT INTO cliente (pnome, nome_do_meio, sobrenome, cpf, endereco, data_de_nascimento) VALUES
("Silvio", "S", "Ribeiro", "96933016169", "Rua Frederico Costa", "1944-06-06"),
("Adriano", "L", "Carvalho", "46347715741", "Rua Reitor Macedo Costa", "1980-04-27"),
("Emily", "S", "Pereira", "02255141638", "Av. Mário Leal Ferreira", "1947-06-08"),
("Thiago", "S", "Almeida", "58648661822", "Av. Dom João VI", "1970-07-01"),
("Angelo", "S", "Carvalho", "54606474783", "Av. Paulo VI", "1940-02-19");

INSERT INTO produto (categoria, descricao, valor) VALUES
("informática", "placa de vídeo", 4299),
("cozinha", "prato de descongelamento rápido", 77.5),
("informática", "monitor", 1429),
("cozinha", "moedor de sal e pimenta", 87.2),
("cozinha", "máquina de gazeificar água", 678.03);

INSERT INTO vendedor_terceiro (razao_social, local_vendedor_terceiro, nome_fantasia, cpf, cnpj) VALUES
("Macroware Tecnologia", "BR 324", "Macroware", null, "70934584411417"),
("Utilvidr Produtos para Cozinha", "Av. Aleomar Baleeiro", "Utilvidr", null, "06199094032786");

INSERT INTO fornecedor (razao_social, cnpj, contato) VALUES
("Tecnobebida", "45786054841709", "3014-3563"),
("Labeltec", "41723129253061", "3595-2640");

INSERT INTO estoque (local_estoque, quantidade) VALUES
("Av. Afrânio Peixoto", 1);

INSERT INTO pedido (status_do_pedido, descricao, cliente_id_cliente, frete) VALUES
("Em processamento", "PIX", 1, 10),
("Em processamento", "Boleto", 5, 10),
("Em processamento", "PIX", 3, 10),
("Em processamento", "Cartão de Crédito", 1, 10),
("Em processamento", "Boleto", 1, 0);

INSERT INTO produto_pedido (id_produto, id_pedido, quantidade, status_produto_pedido) VALUES
(2, 5, 3, "sem estoque"),
(1, 5, 1, "sem estoque"),
(5, 3, 1, "disponível"),
(3, 4, 1, "disponível"),
(5, 4, 1, "sem estoque"),
(4, 1, 1, "disponível"),
(3, 1, 1, "sem estoque"),
(2, 2, 1, "disponível"),
(1, 2, 1, "sem estoque"),
(4, 4, 1, "sem estoque");

INSERT INTO produto_vendedor_tereceiro (id_p_seller, id_produto, quantidade) VALUES
(1, 1, 0),
(2, 2, 1),
(1, 3, 0),
(2, 4, 1),
(2, 5, 0);

INSERT INTO produto_fornecedor (id_fornecedor, id_produto, quantidade) VALUES
(2, 1, 0),
(1, 2, 1),
(2, 3, 0),
(1, 4, 1),
(1, 5, 0);

INSERT INTO produto_estoque (id_estoque, id_produto, localizacao) VALUES
(1, 2, 1),
(1, 4, 1);