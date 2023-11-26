--- COMANDOS PARA CRIAÇÃO DAS TABELAS E SEUS RELACIONAMENTOS ---


CREATE TABLE Produtos(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NULL,
	fabricante VARCHAR(100) NULL,
    codigo_de_barra INT NULL,
    data_validade DATE,
    data_fabricacao DATE
);

CREATE TABLE Cidades(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NULL,
    uf VARCHAR(100) NULL
);

CREATE TABLE Farmacias(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NULL,
    sede INT NOT NULL,
    FOREIGN KEY (sede) REFERENCES Cidades(id)
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
    cidade_id INT NOT NULL,
	nome VARCHAR(100) NULL,
    telefone VARCHAR(20),
    idade INT NULL,
    FOREIGN KEY (cidade_id) REFERENCES Cidades(id)
);
CREATE TABLE Funcionarios(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	farmacia_id INT NULL,
    nome VARCHAR(100) NULL,
    telefone_1 VARCHAR(20) NULL,
    telefone_2 VARCHAR(20) NULL,
    email VARCHAR(100) NULL,
    cargo VARCHAR(100) NULL,
    FOREIGN KEY (farmacia_id) REFERENCES Farmacias(id)
);

CREATE TABLE Compras(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	farmacia_id INT NULL,
    cliente_id INT NULL,
	plataforma VARCHAR(20) NOT NULL,
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

INSERT INTO Cidades(nome, uf) VALUES /*4*/
("Belo Horizonte","MG"),
("Taguatinga","DF"),("Samambaia","DF")
,("Fortaleza","CE");

INSERT INTO Farmacias(nome, sede) VALUES /*5*/
("Drogasil", 1),("DrogaFarma", 2),("DrogaCenter", 3),("DrogaSena", 1),("Drogaria Popular",4);


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

INSERT INTO Clientes(cidade_id,nome, telefone, idade) VALUES /*total registrado: 5*/
(1,'João','(61) 97543-4449', 57),
(2,'Maria','(61) 99877-6612', 35),
(2,'Carlos','(61) 9877-4449', 45),
(3,'Ana', '(61) 99781-2233', 28),
(4,'Pedro', '(61) 98785-3256', 50),
('2', 'Marcos', '(61) 9877-4449', '32'),
('2', 'Lucas', '(61) 9845-4540', '23'),
('1', 'Letícia', '(61) 98565-5461', '44'),
('3', 'João', '(61) 8898-7815', '32');

INSERT INTO Compras(farmacia_id, cliente_id, plataforma) VALUES /*Total registrado: 10*/
	(2, 1, "WEB"), -- Compra 1 (DF)
	(1, 3, "WEB"),  -- Compra 2 (DF)
	(4, 3, "APP"),  -- Compra 3 (CE)
	(4, 5, "WEB"), -- Compra 4 (CE)
	(5, 5, "APP"),  -- Compra 5 (DF)
	(1, 1, "APP"),   -- Compra 6 (DF)
	(2, 2, "APP"),  -- Compra 7 (DF)
	(4, 3, "WEB"),   -- Compra 8 (CE)
	(3, 4, "WEB"),  -- Compra 9 (CE)
	(4, 5, "WEB"),   -- Compra 10 (CE)
	(1, 2, "WEB"),
	(1, 3, "APP"),
	(1, 5, "APP"),
	(2, 3, "WEB"),	
	(1, 4, "WEB"),
	(4, 3, "APP"),
	(4, 2, "WEB"),
	(5, 7, "WEB"),
    (1, 1, "APP"),
    (4, 4, "APP"),
    (5, 6, "WEB"),
    (1, 1, "WEB"),
    (3, 3, "WEB"),
    (2, 2, "WEB"),
    (4, 4, "WEB"),
    (5, 5, "WEB"),
    (3, 3, "WEB"),
    (4, 4, "APP"),
    (5, 5, "APP"),
    (1, 1, "APP"),
    (2, 2, "APP"),
    (4, 4, "APP"),
    (5, 5, "APP"),
    (1, 1, "APP"),
    (3, 3, "APP"),
    (2, 2, "APP"),
    (4, 4, "APP"),
    (5, 5, "APP"),
    (1, 1, "APP"),
     (5, 3, "WEB"),
    (2, 3, "WEB"),
    (4,1, "APP"),
    (5, 6, "APP"),
    (2, 6, "APP"),
    (2, 1, "APP"),
    (1, 2, "APP"),
    (3, 6, "APP"),
    (1, 6, "APP"),
    (2, 3, "APP"),
    (2, 1, "APP"),
    (3, 4, "APP"),
    (5, 3, "APP"),
    (1, 1, "APP"),
    (1, 7, "APP"),
    (2, 8, "PRESENCIAL"),
    (3, 8, "PRESENCIAL"),
    (3, 9, "APP");
    

INSERT INTO Produtos_comprados(compra_id, produto_id, quantidade, data_hora_compra, preco_unico) VALUES
(1, 1, 10, '2023-01-15 10:30:00', 25.0),(1, 2, 2, '2023-01-15 10:30:00', 15.5),(1, 3, 1, '2023-01-15 10:30:00', 30.0),
(2, 1, 5, '2023-02-05 15:45:00', 10.0),(2, 4, 3, '2023-02-05 15:45:00', 20.25),
(3, 2, 2, '2023-03-10 08:20:00', 15.0),(3, 3, 4, '2023-03-10 08:20:00', 40.0),(3, 5, 1, '2023-03-10 08:20:00', 30.0),
(4, 1, 3, '2023-04-20 12:15:00', 10.5),(4, 2, 2, '2023-04-20 12:15:00', 17.25),(4, 3, 5, '2023-04-20 12:15:00', 25.0),
(5, 5, 2, '2023-05-30 17:10:00', 20.0),(5, 1, 3, '2023-05-30 17:10:00', 15.3),(5, 4, 1, '2023-05-30 17:10:00', 30.0),
(6, 1, 2, '2023-06-12 14:30:00', 20.0),(6, 3, 1, '2023-06-12 14:30:00', 30.0), 
(7, 2, 3, '2023-07-05 09:45:00', 15.0),(7, 4, 2, '2023-07-05 09:45:00', 20.25),
(8, 1, 1, '2023-08-20 11:00:00', 10.5),(8, 5, 2, '2023-08-20 11:00:00', 15.0),
(9, 3, 3, '2023-09-15 16:15:00', 30.0),(9, 4, 1, '2023-09-15 16:15:00', 15.0),
(10, 2, 2, '2023-10-25 13:30:00', 15.5),(10, 5, 1, '2023-10-25 13:30:00', 12.0),
 (11, 1, 2, '2023-11-10 08:45:00', 25.0),(11, 3, 3, '2023-11-10 08:45:00', 30.0),
(12, 2, 1, '2023-12-15 14:20:00', 15.0),(12, 4, 4, '2023-12-15 14:20:00', 20.25),
(13, 5, 2, '2024-01-20 09:30:00', 20.0),(13, 1, 3, '2024-01-20 09:30:00', 15.3),(13, 3, 1, '2024-01-20 09:30:00', 30.0),
(14, 1, 2, '2024-02-28 15:15:00', 20.0),(14, 2, 1, '2024-02-28 15:15:00', 17.25),
(15, 3, 3, '2024-03-10 11:45:00', 30.0),(15, 4, 2, '2024-03-10 11:45:00', 20.25),
(16, 1, 1, '2024-04-18 13:20:00', 10.5),(16, 2, 2, '2024-04-18 13:20:00', 15.0),(16, 5, 1, '2024-04-18 13:20:00', 30.0),
(17, 4, 2, '2024-05-25 10:30:00', 25.0),(17, 1, 1, '2024-05-25 10:30:00', 15.5),
(18, 3, 3, '2024-06-08 08:15:00', 30.0),(18, 5, 1, '2024-06-08 08:15:00', 12.0), 
('20', '2', '87', '2023-03-15 10:30:00', '2'), ('20', '3', '82', '2023-03-15 10:30:00', '2'),
('21', '5', '98', '2023-02-24 10:30:00', '3'), ('22', '1', '45', '2023-01-16 10:30:00', '4'),
(55, 2, 2, '2023-08-25 13:30:00', 15.5),(56, 5, 1, '2023-07-25 13:30:00', 12.0),
(57, 5, 1, '2023-07-25 13:30:00', 12.0),
('22', '1', '2', '2023-08-19 10:30:00', '8'), ('23', '4', '6', '2023-11-15 10:30:00', '23');


INSERT INTO Funcionarios(farmacia_id, nome, email, cargo) VALUES /*total registrado: 20 Funcionarios*/
(1, 'Marcio Oliveira', 'marcio.oliveira@gmail.com', 'Gerente'),
(1, 'Ana Silva', 'ana.silva@yahoo.com', 'Balconista'),
(1, 'Carlos Santos', 'carlos.santos@hotmail.com', 'Farmacêutico'),
(1, 'Juliana Pereira', 'juliana.pereira@gmail.com', 'Caixa'),

(2, 'Roberto Souza', 'roberto.souza@gmail.com', 'Gerente'),
(2, 'Camila Lima', 'camila.lima@yahoo.com', 'Balconista'),
(2, 'Lucas Ferreira', 'lucas.ferreira@hotmail.com', 'Farmacêutico'),
(2, 'Fernanda Oliveira', 'fernanda.oliveira@gmail.com', 'Caixa'),

(3, 'Paulo Santos', 'paulo.santos@gmail.com', 'Gerente'),
(3, 'Aline Costa', 'aline.costa@yahoo.com', 'Balconista'),
(3, 'Gustavo Silva', 'gustavo.silva@hotmail.com', 'Farmacêutico'),
(3, 'Mariana Rocha', 'mariana.rocha@gmail.com', 'Caixa'),

(4, 'Ricardo Lima', 'ricardo.lima@gmail.com', 'Gerente'),
(4, 'Renata Oliveira', 'renata.oliveira@yahoo.com', 'Balconista'),
(4, 'Gabriel Silva', 'gabriel.silva@hotmail.com', 'Farmacêutico'),
(4, 'Beatriz Santos', 'beatriz.santos@gmail.com', 'Caixa'),

(5, 'Fábio Pereira', 'fabio.pereira@gmail.com', 'Gerente'),
(5, 'Isabela Costa', 'isabela.costa@yahoo.com', 'Balconista'),
(5, 'Henrique Oliveira', 'henrique.oliveira@hotmail.com', 'Farmacêutico'),
(5, 'Larissa Santos', 'larissa.santos@gmail.com', 'Caixa');


INSERT INTO Entregadores (nome) VALUES /*total registrado: 10*/
('Sérgio Oliveira'),('Ana Silva'),('Carlos Santos'),('Juliana Pereira'),('Roberto Souza'),
('Camila Lima'),('Lucas Ferreira'),('Fernanda Oliveira'),('Paulo Santos'),('Aline Costa');

INSERT INTO Retiradas (metodo, data_hora_retirada) VALUES /*total registrado: 39*/
('App', '2023-11-24 10:15:00'),('Portal', '2023-11-24 12:30:00'),
('Presencial', '2023-11-25 14:45:00'),('App', '2023-11-26 16:00:00'),
('Presencial', '2023-11-27 18:15:00'),('Portal', '2023-11-28 09:30:00'),
('App', '2023-11-29 11:45:00'),('Presencial', '2023-11-30 13:00:00'),
('App', '2023-12-01 15:15:00'),('Portal', '2023-12-02 17:30:00'),
('Presencial', '2023-12-03 19:45:00'),('App', '2023-12-04 08:00:00'),
('Portal', '2023-12-05 10:15:00'),('Presencial', '2023-12-06 12:30:00'),
('App', '2023-12-07 14:45:00'),('Portal', '2023-12-08 16:00:00'),
('App', '2023-12-09 18:15:00'),('Presencial', '2023-12-10 09:30:00'),
('App', '2023-12-11 11:45:00'),('Portal', '2023-12-12 13:00:00'),
('Presencial', '2023-12-13 15:15:00'),('App', '2023-12-14 17:30:00'),
('Portal', '2023-12-15 19:45:00'),('Presencial', '2023-12-16 08:00:00'),
('App', '2023-12-17 10:15:00'),('Portal', '2023-12-18 12:30:00'),
('App', '2023-12-19 14:45:00'),('Presencial', '2023-12-20 16:00:00'),
('App', '2023-12-21 18:15:00'),('Portal', '2023-12-22 09:30:00'),
('Presencial', '2023-12-23 11:45:00'),('App', '2023-12-24 13:00:00'),
('Portal', '2023-12-25 15:15:00'),('Presencial', '2023-12-26 17:30:00'),
('App', '2023-12-27 19:45:00'),('Portal', '2023-12-28 08:00:00'),
('App', '2023-12-29 10:15:00'),('Presencial', '2023-12-30 12:30:00'),
('App', '2023-12-31 14:45:00');

-- População da tabela Entregas correspondente, incluindo retirada_id
INSERT INTO Entregas(entregador_id, compra_id, retirada_id) VALUES /*Total registrado: 10 retiradas... em um total de 39*/
(1, 11, 1),(2, 12, 2),(3, 13, 3),(4, 14, 4),(5, 15, 5),(6, 16, 6),(7, 17, 7),(8, 18, 8),(9, 19, 9),(10, 20, 10);


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
    c.id =1  /*entre 1 e 4*/ /*atencao: na logica todas as farmacia possui todos os produtos... talvez devo mudar*/
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
-- intencionalmente, nós colocamos o Cliente Lucas de id 7 fazendo somente 
-- uma compra na farmacia de id 1 30 dias antes



DELIMITER $$
USE `t3`$$
CREATE PROCEDURE `consulta4_passandoIdFarmacia` (id_farmacia_param INT)
BEGIN
SELECT clien.id as id_cliente, clien.nome as nome, clien.telefone, clien.idade as idade, clientes_ultimo_ano.qtd_comprada_ano as qtd_comprada_ano
	FROM Clientes AS clien
	JOIN (SELECT clien.nome as cliente, SUM(pc.quantidade) as qtd_comprada_ano
			FROM Farmacias AS f 
				JOIN Compras AS c ON f.id = c.farmacia_id 
				JOIN Produtos_comprados AS pc ON c.id = pc.compra_id
				JOIN Clientes AS clien ON clien.id = c.cliente_id
			WHERE pc.data_hora_compra > SUBDATE(CURDATE(), INTERVAL 365 DAY) AND f.id = id_farmacia_param 
			GROUP BY clien.id) as clientes_ultimo_ano ON clientes_ultimo_ano.cliente = clien.nome
	WHERE clien.id not in(SELECT clien.id
			FROM Farmacias AS f 
				JOIN Compras AS c ON f.id = c.farmacia_id 
				JOIN Produtos_comprados AS pc ON c.id = pc.compra_id
				JOIN Clientes AS clien ON clien.id = c.cliente_id
			WHERE pc.data_hora_compra > SUBDATE(CURDATE(), INTERVAL 30 DAY) AND f.id = id_farmacia_param);
END$$

DELIMITER ;

CALL consulta4_passandoIdFarmacia(1);

--- COMANDOS PARA A CONSULTA 5 ---

--- COMANDOS PARA A CONSULTA 6 ---

--- COMANDOS PARA A CONSULTA 7 ---
SELECT p.nome as produto, p.fabricante as fabricante, f.nome AS farmacia, cid.nome as cidade, cid.uf as uf, SUM(pc.quantidade) AS qtd_vendas
FROM Farmacias AS f 
	JOIN Compras AS c ON f.id = c.farmacia_id 
	JOIN Produtos_comprados AS pc ON c.id = pc.compra_id
	JOIN Produtos AS P ON p.id = pc.produto_id
    JOIN Estoque as e ON p.id = e.produto_id
    JOIN Cidades AS cid ON f.sede = cid.id
WHERE p.id = 5 AND pc.data_hora_compra > SUBDATE(CURDATE(), INTERVAL 30 DAY) AND c.plataforma = "APP"
GROUP BY f.id
ORDER BY qtd_vendas DESC
LIMIT 10;
--- COMANDOS PARA A CONSULTA 8 ---
SELECT f.nome as farmacia, func.nome as gerente, func.email, SUM(pc.quantidade) as quantidade
FROM Farmacias AS f 
	JOIN Compras AS c ON f.id = c.farmacia_id 
	JOIN Produtos_comprados AS pc ON c.id = pc.compra_id
	JOIN Produtos AS p ON p.id = pc.produto_id
    JOIN Funcionarios as func ON  func.farmacia_id = f.id
WHERE p.id = 3 AND pc.data_hora_compra > SUBDATE(CURDATE(), INTERVAL 30 DAY) AND func.cargo = "gerente" 
GROUP BY f.id, func.nome,func.email;


--- COMANDOS PARA A CONSULTA 9 ---

--- COMANDOS PARA CRIAÇÃO E EXEMPLO DE USO DA "VIEW" ---

--- COMANDOS PARA CRIAÇÃO E EXEMPLO DE USO DA FUNÇÃO ---

--- COMANDOS PARA CRIAÇÃO E EXEMPLO DE USO DA "STORED PROCEDURE" ---
-- Criação da stored procedure

-- Exemplo de uso 

--- COMANDOS PARA CRIAÇÃO E EXEMPLO DE USO DA "TRIGGER" ---
