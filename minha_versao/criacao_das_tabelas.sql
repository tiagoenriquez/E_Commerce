CREATE DATABASE e_commerce;

USE e_commerce;

-- Como endereço possui muitos atributos e podem haver mais deuma pessoa no mesmo endereço, bem como pessoas com mais 
-- de um endereço, optei por criar uma tabela só para os endereços.
CREATE TABLE enderecos (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	logradouro VARCHAR (45) NOT NULL,
	numero INT NOT NULL,
    complemento VARCHAR (45),
    cep CHAR (8) NOT NULL,
    bairro VARCHAR (45) NOT NULL,
    cidade VARCHAR (45) NOT NULL,
    estado CHAR (2) NOT NULL
);

-- Aqui podem existir tanto clientes como fornecedores que são pessoas físicas. Pessoas físicas podem vender no
-- e-commerce.
CREATE TABLE pessoas_fisicas (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR (45) NOT NULL,
    cpf CHAR (11) NOT NULL UNIQUE,
    nascimento DATE NOT NULL
);

-- Para facilitar a administração das categorias (permitir alteração de nome ou acréscimo de categoria em caso de 
-- crescimento da empresa) preferi criar uma tabela só para as categorias.
CREATE TABLE categorias (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR (45) NOT NULL UNIQUE
);

-- Aqui pessoas jurídicas podem ser tanto clientes como fornecedores. A diferença destas em relação às pessoas
-- físicas são os atributos e a forma de administrar os contatos e os endereços.
CREATE TABLE pessoas_juridicas (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR (91) NOT NULL UNIQUE,
    nome_fantasia VARCHAR (45) NOT NULL,
    cnpj CHAR (14) NOT NULL UNIQUE,
    email VARCHAR (45) NOT NULL UNIQUE,
    endereco_id INT NOT NULL UNIQUE,
    CONSTRAINT fk_pessoas_juridicas_endereco
        FOREIGN KEY (endereco_id) REFERENCES enderecos (id)
);

-- Os telefones podem ser de pessoa física ou de pessoa jurídica. Mas não vão haver duas pessoas jurídicas com o mesmo
-- telefone. Então a propriedade pessoa_juridica_id vai ser nula se o número for de pessoa física e este tratamento
-- pode ser feito pela aplicação.
CREATE TABLE telefones (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR (15) UNIQUE,
    pessoa_juridica_id INT UNIQUE,
    CONSTRAINT fk_telefones_pessoa_juridica
        FOREIGN KEY (pessoa_juridica_id) REFERENCES pessoas_juridicas (id)
);

CREATE TABLE produtos (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(45) NOT NULL UNIQUE,
    valor FLOAT NOT NULL,
    quantidade INT NOT NULL,
    categoria_id INT NOT NULL,
    CONSTRAINT fk_produtos_categoria
        FOREIGN KEY (categoria_id) REFERENCES categorias (id)
);

-- Os clientes vão ser pessoa física ou pessoa jurídica.
CREATE TABLE clientes (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    pessoa_fisica_id INT UNIQUE,
    pessoa_juridica_id INT UNIQUE,
    CONSTRAINT fk_clientes_pessoa_fisica
        FOREIGN KEY (pessoa_fisica_id) REFERENCES pessoas_fisicas (id),
    CONSTRAINT fk_clientes_pessoa_juridica
        FOREIGN KEY (pessoa_juridica_id) REFERENCES pessoas_juridicas (id)
);

-- Aqui pedido não tem propriedade "descrição". Esta propriedade está distribuída em outros atributos (data de
-- realização, forma de pagamento, status do pagamento, forma de envio e status do envio.
CREATE TABLE pedidos (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    data_realizacao DATE NOT NULL,
    forma_de_pagamento ENUM ("boleto", "cartão de crédito", "pix") NOT NULL,
    status_do_pagamento ENUM ("pendente", "em atraso", "em dia", "quitado")
        DEFAULT "pendente",
    forma_de_envio ENUM
        ("correio", "melhor envio", "transportadora", "retirada do local")
        NOT NULL,
    status_do_envio ENUM
        ("pendente", "enviado pelo vendedor", "recebido pelo cliente")
        NOT NULL,
    frete FLOAT NOT NULL,
    cliente_id INT NOT NULL,
    CONSTRAINT fk_pedidos_cliente
        FOREIGN KEY (cliente_id) REFERENCES clientes (id)
);

-- Vendedores, assim como clientes, vão ser pessoa física ou jurídica. A nota é uma média das avaliações feitas pelos
-- clientes.
CREATE TABLE vendedores (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nota FLOAT NOT NULL DEFAULT 0.0,
    pessoa_fisica_id INT UNIQUE,
    pessoa_juridica_id INT UNIQUE,
    CONSTRAINT fk_vendedores_pessoa_fisica
        FOREIGN KEY (pessoa_fisica_id) REFERENCES pessoas_fisicas (id),
    CONSTRAINT fk_vendedores_pessoa_juridica
        FOREIGN KEY (pessoa_juridica_id) REFERENCES pessoas_juridicas (id)
);

-- Esta tabela permite que as pessoas físicas tenham mais de um endereço e este possa ser de mais de um cliente.
CREATE TABLE enderecos_de_pessoas_fisicas (
    endereco_id INT NOT NULL,
    pessoa_fisica_id INT NOT NULL,
    CONSTRAINT pk_enderecos_de_pessoas_fisicas
        PRIMARY KEY (endereco_id, pessoa_fisica_id),
    CONSTRAINT fk_enderecos_de_pessoas_fisicas_endereco
        FOREIGN KEY (endereco_id) REFERENCES enderecos (id),
    CONSTRAINT fk_enderecos_de_pessoas_fisicas_pessoa_fisica
        FOREIGN KEY (pessoa_fisica_id) REFERENCES pessoas_fisicas (id)
);

-- Esta tabela permite que as pessoas físicas tenham mais de um telefone e este possa ser de mais de um cliente.
CREATE TABLE telefones_de_pessoas_fisicas (
    telefone_id INT NOT NULL,
    pessoa_fisica_id INT NOT NULL,
    CONSTRAINT pk_telefones_de_pessoas_fisicas
        PRIMARY KEY (telefone_id, pessoa_fisica_id),
    CONSTRAINT fk_telefones_de_pessoas_fisicas_telefone
        FOREIGN KEY (telefone_id) REFERENCES telefones (id),
    CONSTRAINT fk_telefones_de_pessoas_fisicas_pessoa_fisica
        FOREIGN KEY (pessoa_fisica_id) REFERENCES pessoas_fisicas (id)
);

-- Esta tabela está conforme a sugestão da professora Juliana Mascarenhas.
CREATE TABLE produtos_nos_pedidos (
    produto_id INT NOT NULL,
    pedido_id INT NOT NULL,
    quantidade int NOT NULL,
    CONSTRAINT pk_produtos_nos_pedidos
        PRIMARY KEY (produto_id, pedido_id),
    CONSTRAINT fk_produtos_nos_pedidos_produto
        FOREIGN KEY (produto_id) REFERENCES produtos (id),
    CONSTRAINT fk_produtos_nos_pedidos_pedido
        FOREIGN KEY (pedido_id) REFERENCES pedidos (id)
);

-- Esta tabela está parecida com a sugestão da professora Juliana Mascarenhas. A diferença aqui está no fato de que a
-- empresa que gere este e-commerce, se vender algum produto, vai ser inclusa dentro desta tabela. Desta forma,
-- podemos atrelar todos os produtos a algum vendedor.
CREATE TABLE produtos_dos_vendedores (
    produto_id INT NOT NULL,
    vendedor_id INT NOT NULL,
    quantidade INT NOT NULL,
    CONSTRAINT pk_produtos_dos_vendedores
        PRIMARY KEY (produto_id, vendedor_id),
    CONSTRAINT fk_produtos_dos_vendedores_produto
        FOREIGN KEY (produto_id) REFERENCES produtos (id),
    CONSTRAINT fk_produtos_dos_vendedores_vendedor
        FOREIGN KEY (vendedor_id) REFERENCES vendedores (id)
);