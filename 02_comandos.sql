--- COMANDOS PARA CRIAÇÃO DAS TABELAS E SEUS RELACIONAMENTOS ---
CREATE TABLE Produtos(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NULL,
	fabricante VARCHAR(100) NULL,
    codigo_de_barra INT NULL,
    data_validade DATE,
    data_fabricacao DATE
);
CREATE TABLE Farmacias(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NULL
);
CREATE TABLE Cidades(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NULL,
    uf VARCHAR(100) NULL
);
CREATE TABLE Estoque(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    produto_id INT NULL,
    quantidade INT NULL,
    FOREIGN KEY (produto_id) REFERENCES Produtos(id)
);
CREATE TABLE Unidades(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    farmacia_id INT NULL,
    cidade_id INT NULL,
    nome VARCHAR(100) NULL,
	FOREIGN KEY (farmacia_id) REFERENCES Farmacias(id),
    FOREIGN KEY (cidade_id) REFERENCES Cidades(id)
);
CREATE TABLE EstoqueUnidade (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    estoque_id INT NULL,
    unidade_id INT NULL,
    FOREIGN KEY (estoque_id) REFERENCES Estoque(id),
    FOREIGN KEY (unidade_id) REFERENCES Unidades(id)
);
CREATE TABLE Clientes(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(100) NULL,
    telefone VARCHAR(100) NULL,
    idade INT NULL
);
CREATE TABLE Funcionarios(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	farmacia_id INT NULL,
    nome VARCHAR(100) NULL,
    email VARCHAR(100) NULL,
    cargo VARCHAR(100) NULL,
    FOREIGN KEY (farmacia_id) REFERENCES Farmacias(id)
);
CREATE TABLE Telefones(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    funcionario_id INT NULL,
    numero VARCHAR(100) NULL,
    FOREIGN KEY (funcionario_id) REFERENCES Funcionarios(id)
);
CREATE TABLE Compras(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	farmacia_id INT NULL,
    cliente_id INT NULL,
    valor_total DOUBLE NULL,
    FOREIGN KEY (farmacia_id) REFERENCES Farmacias(id),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);
CREATE TABLE Produtos_comprados(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	compra_id INT NULL,
    produto_id INT NULL,
    quantidade INT NULL,
    data_hora_compra TIMESTAMP NULL, 
    preco_unico INT NULL
);
CREATE TABLE Entregadores(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(100) NULL
);
CREATE TABLE Retiradas(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	metodo VARCHAR(100) NULL,
    data_hora_retirada TIMESTAMP NULL
);
CREATE TABLE Entregas(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	entregador_id INT NULL,
    compra_id INT NULL,
    retirada_id INT NULL,
    FOREIGN KEY (entregador_id) REFERENCES Entregadores(id),
    FOREIGN KEY (compra_id) REFERENCES Compras(id),
    FOREIGN KEY (retirada_id) REFERENCES Retiradas(id)
);

--- COMANDOS PARA POPULAÇÃO DAS TABELAS ---
INSERT INTO Produtos(nome, fabricante, codigo_de_barra, data_validade, data_fabricacao) VALUES 
("Dipirona","Medley",71001, "2025-10-20","2015-10-20"),
("Aspirina","PharmaX", 71002,"2024-01-12","2018-01-12"),
("Ibuprofeno","DrugCo", 71003,"2023-12-12","2016-12-12"),
("Loratadina","HealthMeds",71004,"2023-12-28","2020-12-28"),
("Omeprazol","MegaPharm",71005,"2028-05-08","2020-05-08");

INSERT INTO Farmacias(nome) VALUES /*5*/
("Drogasil"),("DrogaFarma"),("DrogaCenter"),("DrogaSena"),("Drogaria Popular");

INSERT INTO Cidades(nome, uf) VALUES /*4*/
("Belo Horizonte","MG"),
("Taguatinga","DF"),("Samambaia","DF")
,("Fortaleza","CE");

INSERT INTO Estoque(produto_id, quantidade) VALUES /*15x5*/
(1,12),(1,18),(1,20),(1,8),(1,7),(1,12),(1,3),(1,6),(1,34),(1,44),(1,11),(1,9),(1,88),(1,45),(1,4), /*Estoques do Produto 1*/
(2,3),(2,5),(2,9),(2,12),(2,5),(2,5),(2,8),(2,9),(2,12),(2,4),(2,12),(2,7),(2,6),(2,5),(2,6), /*Estoques do Produto 2*/
(3,9),(3,4),(3,20),(3,12),(3,4),(3,4),(3,5),(3,6),(3,7),(3,8),(3,9),(3,11),(3,22),(3,33),(3,12), /*Estoques do Produto 3*/
(4,4),(4,22),(4,30),(4,33),(4,0),(4,5),(4,6),(4,5),(4,7),(4,5),(4,6),(4,3),(4,55),(4,3),(4,23), /*Estoques do Produto 4*/
(5,0),(5,12),(5,27),(5,45),(5,70),(5,33),(5,23),(5,1),(5,4),(5,6),(5,44),(5,23),(5,10),(5,9),(5,8); /*Estoques do Produto 5*/

INSERT INTO Unidades(farmacia_id, cidade_id, nome) VALUES /*15*/
(1,1,"Unidade 1"),(1,2,"Unidade 2"),(1,3,"Unidade 3"), /*unidades da farmácia 1*/
(2,1,"Unidade 1"),(2,2,"Unidade 2"),(2,2,"Unidade 3"), /*unidades da farmácia 2*/
(3,4,"Unidade 1"),(3,4,"Unidade 2"),(3,3,"Unidade 3"), /*unidades da farmácia 3*/
(4,4,"Unidade 1"),(4,4,"Unidade 2"),(4,1,"Unidade 3"), /*unidades da farmácia 4*/
(5,3,"Unidade 1"),(5,4,"Unidade 2"),(5,2,"Unidade 3"); /*unidades da farmácia 5*/

INSERT INTO EstoqueUnidade(estoque_id, unidade_id) VALUES /*AS 5 FARMÁCIAS POSSUI CADASTRADO OS 5 PRODUTOS*/
(1,1),(2,2),(3,3),       /*quantidade do produto 1 na farmácia 1*/
(4,4),(5,5),(6,6),        /*quantidade do produto 1 na farmácia 2*/
(7,7),(8,8),(9,9),       /*quantidade do produto 1 na farmácia 3*/
(10,10),(11,11),(12,12), /*quantidade do produto 1 na farmácia 4*/
(13,13),(14,14),(15,15), /*quantidade do produto 1 na farmácia 5*/
(16,1),(17,2),(18,3),    /*quantidade do produto 2 na farmácia 1*/   
(19,4),(20,5),(21,6),     /*quantidade do produto 2 na farmácia 2*/   
(22,7),(23,8),(24,9),    /*quantidade do produto 2 na farmácia 3*/  
(25,10),(26,11),(27,12), /*quantidade do produto 2 na farmácia 4*/
(28,13),(29,14),(30,15), /*quantidade do produto 2 na farmácia 5*/
(31,1),(32,2),(33,3),    /*quantidade do produto 3 na farmácia 1*/ 
(34,4),(35,5),(36,6),     /*quantidade do produto 3 na farmácia 2*/   
(37,7),(38,8),(39,9),    /*quantidade do produto 3 na farmácia 3*/    
(40,10),(41,11),(42,12), /*quantidade do produto 3 na farmácia 4*/ 
(43,13),(44,14),(45,15), /*quantidade do produto 3 na farmácia 5*/
(46,1),(47,2),(48,3),    /*quantidade do produto 4 na farmácia 1*/   
(49,4),(50,5),(51,6),     /*quantidade do produto 4 na farmácia 2*/     
(52,7),(53,8),(54,9),    /*quantidade do produto 4 na farmácia 3*/     
(55,10),(56,11),(57,12), /*quantidade do produto 4 na farmácia 4*/  
(58,13),(59,14),(60,15), /*quantidade do produto 4 na farmácia 5*/  
(61,1),(62,2),(63,3),    /*quantidade do produto 5 na farmácia 1*/    
(64,4),(65,5),(66,6),     /*quantidade do produto 5 na farmácia 2*/   
(67,7),(68,8),(69,9),    /*quantidade do produto 5 na farmácia 3*/   
(70,10),(71,11),(72,12), /*quantidade do produto 5 na farmácia 4*/
(73,13),(74,14),(75,15);  /*quantidade do produto 5 na farmácia 5*/

INSERT INTO Clientes(nome, telefone, idade) VALUES
('João', '(61) 99999-9999', 57),
('Maria', '(62) 88888-8888', 35),
('Carlos', '(63) 77777-7777', 45),
('Ana', '(64) 66666-6666', 28),
('Pedro', '(65) 55555-5555', 50);

--- COMANDOS PARA A CONSULTA 1 ---
SELECT
    p.codigo_de_barra AS codigo,
    p.nome,
    p.fabricante,
    SUM(e.quantidade) AS quantidade,
    c.nome AS cidade,
    c.uf
FROM
    Produtos p
JOIN
    Estoque e ON p.id = e.produto_id
JOIN
    EstoqueUnidade eu ON e.id = eu.estoque_id
JOIN
    Unidades u ON eu.unidade_id = u.id
JOIN
    Cidades c ON u.cidade_id = c.id
WHERE
    c.id =1  /*entre 1 e 4*/
GROUP BY
    p.id, c.id
ORDER BY
    p.nome;
    
/*APENAS VALIDACAO.... DESCARTAR NO FINAL*/
SELECT
    f.nome AS farmacia,
    p.nome AS produto,
    u.nome AS unidade,
    e.quantidade
FROM
    Produtos p
JOIN
    Estoque e ON p.id = e.produto_id
JOIN
    EstoqueUnidade eu ON e.id = eu.estoque_id
JOIN
    Unidades u ON eu.unidade_id = u.id
JOIN
    Farmacias f ON u.farmacia_id = f.id
JOIN
    Cidades c ON u.cidade_id = c.id
WHERE
    c.id = 1 AND p.codigo_de_barra = 71001; /*VALIDANDO A QUANTIDADE DOS PRODUTOS*/



--- COMANDOS PARA A CONSULTA 2 ---



--- COMANDOS PARA A CONSULTA 3 ---

--- COMANDOS PARA A CONSULTA 4 ---

--- COMANDOS PARA A CONSULTA 5 ---

--- COMANDOS PARA A CONSULTA 6 ---

--- COMANDOS PARA A CONSULTA 7 ---

--- COMANDOS PARA A CONSULTA 8 ---

--- COMANDOS PARA A CONSULTA 9 ---

--- COMANDOS PARA CRIAÇÃO E EXEMPLO DE USO DA "VIEW" ---

--- COMANDOS PARA CRIAÇÃO E EXEMPLO DE USO DA FUNÇÃO ---

--- COMANDOS PARA CRIAÇÃO E EXEMPLO DE USO DA "STORED PROCEDURE" ---

--- COMANDOS PARA CRIAÇÃO E EXEMPLO DE USO DA "TRIGGER" ---
