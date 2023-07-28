CREATE DATABASE e_commerce_da_professora;

USE e_commerce_da_professora;

CREATE TABLE cliente(
    id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    pnome VARCHAR (10) NOT NULL,
    nome_do_meio VARCHAR (3),
    sobrenome VARCHAR (20),
    cpf CHAR (11) NOT NULL UNIQUE,
    endereco VARCHAR (45),
    data_de_nascimento DATE NOT NULL
);

CREATE TABLE produto(
    id_produto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    categoria ENUM ("informática", "moda", "brinquedo", "cozinha", "casa") DEFAULT "informática",
    descricao VARCHAR (45),
    valor FLOAT NOT NULL
);

CREATE TABLE vendedor_terceiro(
    id_vendedor_terceiro INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR (45) NOT NULL UNIQUE,
    local_vendedor_terceiro VARCHAR (45),
    nome_fantasia VARCHAR (45),
    cpf CHAR (11) UNIQUE,
    cnpj CHAR (14) UNIQUE
);

CREATE TABLE fornecedor(
    id_fornecedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR (45),
    cnpj CHAR (14) NOT NULL UNIQUE,
    contato VARCHAR (45) NOT NULL
);

CREATE TABLE estoque(
    id_estoque INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    local_estoque VARCHAR (45) NOT NULL,
    quantidade INT NOT NULL
);

CREATE TABLE pedido(
    id_pedido INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    status_do_pedido ENUM ("Em andamento", "Em processamento", "Enviado", "Entregue") DEFAULT "Em processamento",
    descricao VARCHAR (45),
    cliente_id_cliente INT NOT NULL,
    frete FLOAT,
    CONSTRAINT fk_pedido_id_cliente FOREIGN KEY (cliente_id_cliente) REFERENCES cliente (id_cliente)
);

CREATE TABLE produto_pedido(
    id_produto INT NOT NULL,
    id_pedido INT NOT NULL,
    quantidade INT NOT NULL,
    status_produto_pedido ENUM ("disponível", "sem estoque") DEFAULT "disponível",
    CONSTRAINT pk_produto_pedido PRIMARY KEY (id_produto, id_pedido),
    CONSTRAINT fk_produto_pedido_id_produto FOREIGN KEY (id_produto) REFERENCES produto (id_produto),
    CONSTRAINT fk_produto_pedido_id_pedido FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido)
);

CREATE TABLE produto_vendedor_tereceiro(
    id_p_seller INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT,
    CONSTRAINT pk_produto_vendedor_tereceiro PRIMARY KEY (id_p_seller, id_produto),
    CONSTRAINT fk_id_p_seller FOREIGN KEY (id_p_seller) REFERENCES vendedor_terceiro (id_vendedor_terceiro),
    CONSTRAINT fk_produto_vendedor_id_produto FOREIGN KEY (id_produto) REFERENCES produto (id_produto)
);

CREATE TABLE produto_fornecedor(
    id_fornecedor INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT,
    CONSTRAINT pk_produto_fornecedor PRIMARY KEY (id_fornecedor, id_produto),
    CONSTRAINT fk_id_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES fornecedor (id_fornecedor),
    CONSTRAINT fk_produto_fornecedor_id_produto FOREIGN KEY (id_produto) REFERENCES produto (id_produto)
);

CREATE TABLE produto_estoque(
    id_estoque INT NOT NULL,
    id_produto INT NOT NULL,
    localizacao INT,
    CONSTRAINT pk_produto_estoque PRIMARY KEY (id_estoque, id_produto),
    CONSTRAINT fk_id_estoque FOREIGN KEY (id_estoque) REFERENCES estoque (id_estoque),
    CONSTRAINT fk_produto_estoque_id_produto FOREIGN KEY (id_produto) REFERENCES produto (id_produto)
);

SHOW TABLES;