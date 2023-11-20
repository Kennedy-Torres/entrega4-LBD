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

--- COMANDOS PARA POPULAÇÃO DAS TABELAS ---
INSERT INTO Produtos(nome, fabricante, codigo_de_barra, data_validade, data_fabricacao) VALUES ("Dipirona","Medley",71001, "2025-10-20","2015-10-20"),("Aspirina","PharmaX", 71002,"2024-01-12","2018-01-12"),("Ibuprofeno","DrugCo", 71003,"2023-12-12","2016-12-12"),("Loratadina","HealthMeds",71004,"2023-12-28","2020-12-28"),("Omeprazol","MegaPharm",71005,"2028-05-08","2020-05-08");

INSERT INTO Farmacias(nome) VALUES ("Drogasil"),("DrogaFarma"),("DrogaCenter"),("DrogaSena"),("Drogaria Popular");

INSERT INTO Cidades(nome, uf) VALUES ("Belo Horizonte","MG"),("Juiz de Fora","MG");
INSERT INTO Cidades(nome, uf) VALUES ("Taguatinga","DF"),("Samambaia","DF"),("Ceilândia","DF");
INSERT INTO Cidades(nome, uf) VALUES ("Fortaleza","CE"),("Sobral","CE");

INSERT INTO Estoque(produto_id, quantidade) VALUES (1,12),(1,18),(1,20),(1,8),(1,7); /*Estoques do Produto 1*/
INSERT INTO Estoque(produto_id, quantidade) VALUES (2,3),(2,5),(2,9),(2,12),(2,5); /*Estoques do Produto 2*/
INSERT INTO Estoque(produto_id, quantidade) VALUES (3,9),(3,4),(3,20),(3,12),(3,4); /*Estoques do Produto 3*/
INSERT INTO Estoque(produto_id, quantidade) VALUES (4,4),(4,22),(4,30),(4,33),(4,0); /*Estoques do Produto 4*/
INSERT INTO Estoque(produto_id, quantidade) VALUES (5,0),(5,12),(5,27),(5,45),(5,70); /*Estoques do Produto 5*/

INSERT INTO Unidades(farmacia_id, cidade_id, nome) VALUES (1,1,"Unidade 1"),(1,1,"Unidade 2"),(1,2,"Unidade 3"); /*unidades da farmácia 1*/
INSERT INTO Unidades(farmacia_id, cidade_id, nome) VALUES (2,1,"Unidade 1"),(2,1,"Unidade 2"),(2,3,"Unidade 1"); /*unidades da farmácia 2*/
INSERT INTO Unidades(farmacia_id, cidade_id, nome) VALUES (3,3,"Unidade 1"),(3,3,"Unidade 2"),(3,3,"Unidade 3"); /*unidades da farmácia 3*/
INSERT INTO Unidades(farmacia_id, cidade_id, nome) VALUES (4,4,"Unidade 1"),(4,5,"Unidade 1"),(4,5,"Unidade 2"); /*unidades da farmácia 4*/
INSERT INTO Unidades(farmacia_id, cidade_id, nome) VALUES (5,6,"Unidade 1"),(5,6,"Unidade 2"),(5,7,"Unidade 1"); /*unidades da farmácia 5*/

INSERT INTO EstoqueUnidade(estoque_id, unidade_id) VALUES (1,1),(2,2),(3,3); /*quantidade do produto 1 na farmácia 1*/
INSERT INTO EstoqueUnidade(estoque_id, unidade_id) VALUES (6,1),(7,2),(8,3); /*quantidade do produto 2 na farmácia 1*/
INSERT INTO EstoqueUnidade(estoque_id, unidade_id) VALUES (4,4),(5,5); /*quantidade do produto 1 na farmácia 2*/

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
    c.id = 1
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
