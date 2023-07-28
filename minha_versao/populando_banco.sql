INSERT INTO enderecos (logradouro, numero, cep, bairro, cidade, estado) VALUES
('Av. Anita Garibaldi', '24', '94221730', 'Rio Vermelho', 'Fortaleza', 'CE'),
('Al. Espatódias', '91', '18601033', 'Engenho Velho de Brotas', 'Salvador', 'BA'),
('Av. Dom João VI', '36', '85140137', 'Brotas', 'Rio de Janeiro', 'RJ'),
('Av. Mário Leal Ferreira', '3', '47604808', 'Itaigara', 'São Paulo', 'SP'),
('Ladeira do Pepino', '57', '34319671', 'Engenho Velho de Brotas', 'Rio de Janeiro', 'RJ'),
('Rua Rio Grande do Sul', '51', '62432167', 'Itaigara', 'Fortaleza', 'CE'),
('Av. Vasco da Gama', '92', '75575876', 'Pernambués', 'Belo Horizonte', 'MG'),
('Av. ACM', '27', '86008946', 'Ondina', 'Curitiba', 'PR'),
('Ladeira do Pepino', '79', '71634911', 'Stiep', 'Recife', 'PE'),
('Av. Manoel Dias', '86', '55676388', 'Nazaré', 'Belém', 'PA');

INSERT INTO pessoas_fisicas (nome, cpf, nascimento) VALUES
('Denival Santos Catherine', '00477345060', '1974-02-16'),
('Tainá Santana Pedreira', '09481971763', '1941-08-28'),
('Ezequiel Miquéias Catherine Araújo', '04123891271', '1979-11-06'),
('Silvio Lopes Carvalho', '16608075380', '2013-12-21'),
('Tainá Rodrigues Enriquez', '68466216850', '1956-01-28');

INSERT INTO categorias (nome) VALUES
('informática'),
('limpeza'),
('casa'),
('eletrodomésticos'),
('higiene'),
('construção'),
('alimento'),
('moda'),
('papelaria'),
('brinquedo');

INSERT INTO pessoas_juridicas (razao_social, nome_fantasia, cnpj, email, endereco_id) VALUES
('NES COSTA BRASIL LTDA', 'Nes Costa', 74809338689351, 'vendas@nescosta.com.br', 4),
('ELELUX INDUSTRIA E COMÉRCIO LTDA', 'Elelux', 22494743067707, 'vendas@elelux.com.br', 7),
('BRITLE INDUSTRIA E COMERCIO ELETRO ELETRONICA LTDA', 'Britlê', 52800545117787, 'vendas@britle.com.br', 8),
('HIGHTROLUX DO BRASIL S.A.', 'Hightrolux', 23043106927379, 'vendas@hightrolux.com.br', 6),
('FERREIRATECH & CIA LTDA', 'Ferreiratech', 21637021994513, 'vendas@ferreiratech.com.br', 3);

INSERT INTO telefones (numero, pessoa_juridica_id) VALUES
(996172002, null),
(38064327, 2),
(992693627, null),
(993723252, null),
(999352775, null),
(994728632, null),
(34045570, 4),
(32222813, 1),
(33741441, 5),
(39507397, 3);

INSERT INTO produtos (descricao, valor, quantidade, categoria_id) VALUES
('computador', 5699, 2, 1),
('switch', 3975.96, 5, 1),
('detergente', 3.99, 9, 2),
('mop esfregão giratório', 59.99, 8, 2),
('garrafa', 36.44, 1, 3),
('liquidificador', 135.54, 1, 3),
('forno elétrico', 7769, 8, 4),
('geladeira', 10499, 4, 4),
('papel higiênico', 37.90, 1, 5),
('sabonete líquido', 55.05, 8, 5);

INSERT INTO clientes (pessoa_fisica_id, pessoa_juridica_id) VALUES
(3, null),
(1, null),
(4, null),
(5, null),
(2, null);

INSERT INTO pedidos (data_realizacao, forma_de_pagamento, status_do_pagamento, forma_de_envio, status_do_envio, frete, cliente_id) VALUES
('2023-07-17', 'cartão de crédito', 'em dia', 'transportadora', 'recebido pelo cliente', 10, 1),
('2023-07-18', 'cartão de crédito', 'em dia', 'transportadora', 'recebido pelo cliente', 10, 2),
('2023-07-19', 'boleto', 'quitado', 'retirada do local', 'enviado pelo vendedor', 10, 3),
('2023-07-20', 'pix', 'quitado', 'transportadora', 'pendente', 10, 4),
('2023-07-21', 'cartão de crédito', 'pendente', 'retirada do local', 'pendente', 10, 5);

INSERT INTO vendedores (nota, pessoa_fisica_id, pessoa_juridica_id) VALUES
(1.1, null, 1),
(4.8, null, 2),
(3.8, null, 3),
(3.4, null, 4),
(2.9, null, 5);

INSERT INTO enderecos_de_pessoas_fisicas (endereco_id, pessoa_fisica_id) VALUES
(2, 1),
(1, 2),
(5, 3),
(9, 4),
(10, 5);

INSERT INTO telefones_de_pessoas_fisicas (telefone_id, pessoa_fisica_id) VALUES
(1, 1),
(3, 2),
(4, 3),
(5, 4),
(6, 5);

INSERT INTO produtos_nos_pedidos (produto_id, pedido_id, quantidade) VALUES
(2, 1, 1),
(5, 2, 2),
(1, 3, 2),
(5, 3, 1),
(2, 4, 2),
(4, 4, 1),
(5, 4, 1),
(1, 5, 1),
(2, 5, 1);

INSERT INTO produtos_dos_vendedores (produto_id, vendedor_id, quantidade) VALUES
(1, 1, 139),
(2, 2, 111),
(3, 5, 128),
(4, 3, 137),
(5, 4, 140);