--- COMANDOS PARA CRIAÇÃO DAS TABELAS E SEUS RELACIONAMENTOS ---

CREATE TABLE Produtos(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NULL,
	fabricante VARCHAR(100) NULL,
    codigo_de_barra INT NULL,
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
    data_validade DATE NULL,
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
    telefone VARCHAR(100),
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
CREATE TABLE Entregas(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	entregador_id INT NULL,
    entregador_nome VARCHAR(100) NULL
);

CREATE TABLE Compras(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	farmacia_id INT NULL,
    cliente_id INT NULL,
	plataforma VARCHAR(20) NOT NULL,
    data_hora TIMESTAMP NULL,
    entrega_id INT NULL,
    FOREIGN KEY (farmacia_id) REFERENCES Farmacias(id),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
    /*FOREIGN KEY (entrega_id) REFERENCES Entregas(id)*/
);
CREATE TABLE Produtos_comprados(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	compra_id INT NULL,
    produto_id INT NULL,
    quantidade INT NULL,
    data_hora_compra TIMESTAMP NULL, 
    preco_unico INT NULL,
    desconto_preco_unico INT NULL
);



--- COMANDOS PARA POPULAÇÃO DAS TABELAS ---

INSERT INTO Produtos(nome, fabricante, codigo_de_barra, data_fabricacao) VALUES 
("Dipirona","Medley",71001,"2015-10-20"),
("Aspirina","PharmaX", 71002,"2018-01-12"),
("Ibuprofeno","DrugCo", 71003,"2016-12-12"),
("Loratadina","HealthMeds",71004,"2020-12-28"),
("Omeprazol","MegaPharm",71005,"2020-05-08");

INSERT INTO Cidades(nome, uf) VALUES /*4*/
("Belo Horizonte","MG"),
("Taguatinga","DF"),("Samambaia","DF")
,("Fortaleza","CE");

INSERT INTO Farmacias(nome, sede) VALUES /*5*/
("Drogasil", 1),("DrogaFarma", 2),("DrogaCenter", 3),("DrogaSena", 1),("Drogaria Popular",4);


INSERT INTO Estoque(produto_id, data_validade, quantidade) VALUES /*15x5*/
(1, "2025-10-20",12),(1, "2023-08-15",18),(1, "2024-12-03",20),(1, "2022-06-10",8),(1, "2023-02-28",7),(1, "2024-09-22",2),(1, "2023-11-05",12),(1, "2022-09-30",3),(1, "2023-07-14",6),(1, "2024-04-01",34),(1, "2023-01-15",44),(1, "2022-11-30",11),(1, "2024-02-18",9),(1, "2023-05-25",88),(1, "2024-08-08",45), /*Estoques do Produto 1*/
(2, "2023-09-17",22),(2, "2023-12-20",23),(2, "2022-04-05",24),(2, "2022-08-22",25),(2, "2023-03-10",26),(2, "2023-03-10",27),(2, "2022-07-15",28),(2, "2022-09-22",29),(2, "2022-08-30",30),(2, "2022-04-10",31),(2, "2022-12-30",32),(2, "2023-05-01",33),(2, "2023-03-01",34),(2, "2022-12-12",35),(2, "2023-01-05",36), /*Estoques do Produto 2*/
(3, "2022-10-01",37),(3, "2023-07-08",38),(3, "2025-01-15",39),(3, "2022-10-10",40),(3, "2023-05-02",41),(3, "2023-05-02",42),(3, "2023-06-15",43),(3, "2023-07-22",44),(3, "2023-08-01",45),(3, "2023-09-10",46),(3, "2023-10-01",47),(3, "2023-12-05",48),(3, "2024-11-18",49),(3, "2025-02-03",50),(3, "2022-10-12",51), /*Estoques do Produto 3*/
(4, "2023-03-10",52),(4, "2024-11-02",53),(4, "2025-01-10",54),(4, "2024-11-13",55),(4, "2022-01-01",56),(4, "2023-05-15",57),(4, "2023-06-10",58),(4, "2023-05-02",59),(4, "2023-07-12",60),(4, "2023-05-10",61),(4, "2023-06-01",62),(4, "2023-03-01",63),(4, "2024-05-25",64),(4, "2023-03-03",65),(4, "2024-01-23",66), /*Estoques do Produto 4*/
(5, "2022-01-01",67),(5, "2024-02-15",68),(5, "2024-09-02",69),(5, "2025-05-10",70),(5, "2026-03-20",71),(5, "2024-11-13",72),(5, "2024-01-23",73),(5, "2022-06-01",74),(5, "2022-09-04",75),(5, "2023-03-10",76),(5, "2024-04-30",77),(5, "2023-03-01",78),(5, "2023-10-10",79),(5, "2023-08-09",80),(5, "2023-07-08",81); /*Estoques do Produto 5*/

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
(34,4),(35,5),(36,6),    /*quantidade do produto 3 na farmácia 2*/
(37,7),(38,8),(39,9),    /*quantidade do produto 3 na farmácia 3*/
(40,10),(41,11),(42,12), /*quantidade do produto 3 na farmácia 4*/
(43,13),(44,14),(45,15), /*quantidade do produto 3 na farmácia 5*/
(46,1),(47,2),(48,3),    /*quantidade do produto 4 na farmácia 1*/
(49,4),(50,5),(51,6),    /*quantidade do produto 4 na farmácia 2*/
(52,7),(53,8),(54,9),    /*quantidade do produto 4 na farmácia 3*/
(55,10),(56,11),(57,12), /*quantidade do produto 4 na farmácia 4*/
(58,13),(59,14),(60,15), /*quantidade do produto 4 na farmácia 5*/
(61,1),(62,2),(63,3),    /*quantidade do produto 5 na farmácia 1*/
(64,4),(65,5),(66,6),    /*quantidade do produto 5 na farmácia 2*/
(67,7),(68,8),(69,9),    /*quantidade do produto 5 na farmácia 3*/
(70,10),(71,11),(72,12), /*quantidade do produto 5 na farmácia 4*/
(73,13),(74,14),(75,15); /*quantidade do produto 5 na farmácia 5*/

INSERT INTO Clientes(cidade_id,nome,telefone, idade) VALUES /*total registrado: 5*/
(1,'João','(31)99533-5288', 57),
(2,'Maria','(61)92345-6789', 35),
(2,'Carlos','(61)91234-5678', 45),
(3,'Ana', '(61)97890-1234', 28),
(4,'Pedro', '(88)99999-0000', 50),
('2', 'Marcos', '(61) 9877-4449', '32'),
('2', 'Lucas', '(61) 9845-4540', '23'),
('1', 'Letícia', '(31) 98565-5461', '44'),
('3', 'João', '(61) 8898-7815', '32');

INSERT INTO Entregas(entregador_id, entregador_nome) VALUES /*Total registrado: 10 retiradas... em um total de 39*/
(1,'Sérgio Oliveira'),(2,'Ana Silva'),(3,'Carlos Santos'),(4,'Juliana Pereira'),(5,'Roberto Souza')
,(6,'Camila Lima'),(7, 'Lucas Ferreira'),(8, 'Fernanda Oliveira'),(9, 'Paulo Santos'),(10, 'Aline Costa') -- 10 de 52

	,(11, 'Mariana Silva'),(12, 'Ricardo Pereira'),(13, 'Isabela Oliveira'),(14, 'Felipe Costa'),(15, 'Larissa Santos')
,(16, 'Gustavo Lima'),(17, 'Amanda Ferreira'),(18, 'Pedro Souza'),(19, 'Tatiane Oliveira'),(20, 'Gabriel Santos')
,(21, 'Carla Pereira'),(22, 'Fábio Costa'),(23, 'Renata Lima'),(24, 'Bruno Ferreira'),(25,'Jéssica Oliveira')
,(26, 'Diego Santos'),(27, 'Patrícia Costa'),(28, 'Vinícius Lima'),(29, 'Natália Ferreira'),(30, 'Leonardo Oliveira')
,(31, 'Bianca Lima'),(32, 'César Souza'),(33, 'Mirella Pereira'),(34, 'André Santos'),(35,'Thaís Costa')
,(36, 'Eduardo Oliveira'),(37, 'Laura Santos'),(38, 'Rodrigo Lima'),(39, 'Sandra Ferreira'),(40, 'Luciano Costa')
,(41, 'Vanessa Oliveira'),(42, 'Marcelo Santos'),(43, 'Talita Lima'),(44, 'João Ferreira'),(45, 'Cristina Costa');

INSERT INTO Compras(farmacia_id, cliente_id,data_hora, plataforma, entrega_id) VALUES /*Total registrado: 10*/
(1, 1,'2023-11-14 10:15:00','WEB',1), -- Compra 1 (DF)
(1, 1, '2023-11-24 12:30:00','WEB',2),  -- Compra 2 (DF)
(3, 3,  '2023-11-25 14:45:00','APP',3),  -- Compra 3 (CE)
(4, 4, '2023-11-26 16:00:00','WEB',4), -- Compra 4 (CE)
(5, 5, '2023-11-27 18:15:00','APP',5),  -- Compra 5 (DF)
(1, 2, '2023-11-28 09:30:00','WEB',6),   -- Compra 6 (DF)
(2, 2,  '2023-11-29 11:45:00','WEB',7),  -- Compra 7 (DF)
(4, 4,  '2023-11-30 13:00:00','WEB',8),   -- Compra 8 (CE)
(4, 4,  '2023-12-01 15:15:00','WEB',9),  -- Compra 9 (CE)
(4, 4,  '2023-12-02 17:30:00','PRESENCIAL',10),   -- Compra 10 (CE)
(1, 1,  '2023-11-14 08:27:43','PRESENCIAL',11),
(1, 2,  '2023-11-15 10:30:00','PRESENCIAL',12),
(2, 3,  '2023-11-14 14:45:00','APP',13),
(2, 4,  '2023-11-15 16:00:00','APP',14),
(3, 5,  '2023-11-15 18:15:00','PRESENCIAL',15),
(3, 3,  '2023-05-30 17:10:00','PRESENCIAL',16),
(2, 2, '2023-08-20 11:00:00','PRESENCIAL',17),
(5, 5, '2023-07-05 09:45:00','WEB',18),
(1, 1,  '2023-09-15 16:15:00','WEB',19),
(4, 4,  '2023-10-25 13:30:00','WEB',20),
(1, 1,  '2023-10-25 13:30:00','PRESENCIAL',21),
(3, 3,  '2023-10-25 14:30:00','WEB',22),
(2, 2,  '2023-10-25 15:30:00','WEB',23),
(4, 4, '2023-12-06 10:00:00', 'WEB',24),
(5, 5, '2023-12-07 12:15:00', 'WEB',25),
(3, 3, '2023-12-08 14:30:00', 'WEB',26),
(4, 4, '2023-12-09 16:45:00', 'APP',27),
(5, 5, '2023-12-10 18:00:00', 'APP',28),
(1, 1, '2023-12-11 09:30:00', 'APP',29),
(2, 2, '2023-12-12 11:45:00', 'APP',30),
(4, 4, '2023-12-13 13:00:00', 'PRESENCIAL',31),
(5, 5, '2023-12-14 15:15:00', 'APP',32),
(1, 1, '2023-12-15 17:30:00', 'APP',33),
(3, 3, '2023-12-16 14:45:00', 'APP',34),
(2, 2, '2023-12-17 11:00:00', 'APP',35),
(4, 4, '2023-12-18 09:45:00', 'APP',36),
(5, 5, '2023-12-19 16:15:00', 'APP',37),
(1, 1, '2023-12-20 13:30:00', 'APP',38),
(5, 3, '2023-12-21 15:45:00', 'APP',39),
(2, 3, '2023-12-22 17:00:00', 'WEB',40),
(4, 1, '2023-12-23 18:15:00', 'APP',41),
(5, 5, '2023-12-24 10:30:00', 'APP',42),
(2, 4, '2023-12-25 12:45:00', 'APP',43),
(2, 2, '2023-12-26 14:00:00', 'APP',44),
(1, 4, '2023-12-27 15:15:00', 'APP',45),
(3, 5, '2023-12-28 16:30:00', 'APP',46),
(1, 4, '2023-12-29 17:45:00', 'APP',47),
(2, 3, '2023-12-30 19:00:00', 'APP',48),
(2, 1, '2023-12-31 20:15:00', 'APP',49),
(3, 4, '2024-01-01 21:30:00', 'PRESENCIAL',50),
(5, 3, '2024-01-02 22:45:00', 'PRESENCIAL',51),
(1, 1, '2024-01-03 23:59:59', 'APP',52);

INSERT INTO Produtos_comprados(compra_id, produto_id, quantidade, data_hora_compra, preco_unico) VALUES
(1, 1, 10, '2023-11-14 10:30:00', 25.0),(1, 2, 2, '2023-11-14 10:30:00', 15.5),(1, 3, 1, '2023-01-15 10:30:00', 30.0),
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

INSERT INTO Funcionarios(farmacia_id, nome, email, cargo, telefone_1, telefone_2) VALUES /*total registrado: 20 Funcionarios*/
(1, 'Marcio Oliveira', 'marcio.oliveira@gmail.com', 'Gerente','92345-4321','92345-8765'),
(1, 'Ana Silva', 'ana.silva@yahoo.com', 'Balconista','91234-9876', NULL),
(1, 'Carlos Santos', 'carlos.santos@hotmail.com', 'Farmacêutico','995331234','995335678'),
(1, 'Juliana Pereira', 'juliana.pereira@gmail.com', 'Caixa','923454321',NULL),

(2, 'Roberto Souza', 'roberto.souza@gmail.com', 'Gerente','923458765',NULL),
(2, 'Camila Lima', 'camila.lima@yahoo.com', 'Balconista','912349876','978905678'),
(2, 'Lucas Ferreira', 'lucas.ferreira@hotmail.com', 'Farmacêutico','999992345','995337890'),
(2, 'Fernanda Oliveira', 'fernanda.oliveira@gmail.com', 'Caixa','987654321','923458765'),

(3, 'Paulo Santos', 'paulo.santos@gmail.com', 'Gerente','912340123',NULL),
(3, 'Aline Costa', 'aline.costa@yahoo.com', 'Balconista','945678901',NULL),
(3, 'Gustavo Silva', 'gustavo.silva@hotmail.com', 'Farmacêutico','978902109','999994567'),
(3, 'Mariana Rocha', 'mariana.rocha@gmail.com', 'Caixa','995338901',NULL),

(4, 'Ricardo Lima', 'ricardo.lima@gmail.com', 'Gerente','987651234','923450987'),
(4, 'Renata Oliveira', 'renata.oliveira@yahoo.com', 'Balconista','912343456',NULL),
(4, 'Gabriel Silva', 'gabriel.silva@hotmail.com', 'Farmacêutico','945676789',NULL),
(4, 'Beatriz Santos', 'beatriz.santos@gmail.com', 'Caixa','978904321',NULL),

(5, 'Fábio Pereira', 'fabio.pereira@gmail.com', 'Gerente','999997890',NULL),
(5, 'Isabela Costa', 'isabela.costa@yahoo.com', 'Balconista','995332109',NULL),
(5, 'Henrique Oliveira', 'henrique.oliveira@hotmail.com', 'Farmacêutico','987652345','923459012'),
(5, 'Larissa Santos', 'larissa.santos@gmail.com', 'Caixa','912345678',NULL);



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
    c.id =1  /*entre 1 e 4*/ /*atencao: na populacao todas as farmacia possui todos os produtos*/
GROUP BY
    p.id, c.id
ORDER BY
    p.nome;



--- COMANDOS PARA A CONSULTA 2 ---

DELIMITER //
CREATE PROCEDURE BuscarClientesPorUF(IN uf_param VARCHAR(2))
BEGIN
    SELECT
        C.id AS id,
        C.nome AS nome,
        C.telefone AS telefone,
        C.idade AS idade,
        COUNT(DISTINCT Co.id) AS nr_de_compras
    FROM
        Clientes C
    LEFT JOIN
        Compras Co ON C.id = Co.cliente_id
    LEFT JOIN
        Cidades Ci ON C.cidade_id = Ci.id
    WHERE
        Ci.uf = uf_param
    GROUP BY
        C.id, C.nome, C.telefone, C.idade
    HAVING
        COUNT(DISTINCT Co.id) = (
            SELECT MAX(nr_de_compras)
            FROM (
                SELECT
                    C.id AS cliente_id,
                    COUNT(DISTINCT Co.id) AS nr_de_compras
                FROM
                    Clientes C
                LEFT JOIN
                    Compras Co ON C.id = Co.cliente_id
                LEFT JOIN
                    Cidades Ci ON C.cidade_id = Ci.id
                WHERE
                    Ci.uf = uf_param
                GROUP BY
                    C.id
            ) AS ComprasPorCliente
        );
END //
DELIMITER ;
CALL BuscarClientesPorUF('DF'); -- Substitua pelo estado desejado 'DF', 'CE' ou 'MG'



--- COMANDOS PARA A CONSULTA 3 ---

SELECT
    C.id AS id_compra,
    Cl.nome AS cliente,
    SUM(PC.quantidade * (PC.preco_unico - COALESCE(PC.desconto_preco_unico, 0))) AS valor_total,
    C.plataforma AS plataforma,
    C.data_hora
FROM
    Compras C
JOIN
    Clientes Cl ON C.cliente_id = Cl.id
LEFT JOIN
    Produtos_comprados PC ON C.id = PC.compra_id
WHERE
    (C.plataforma IS NULL OR C.plataforma NOT IN ('App'))
    AND C.data_hora BETWEEN '2023-11-14 00:00:00' AND '2023-11-15 23:59:59'
GROUP BY
    C.id, Cl.nome, C.plataforma, C.data_hora
ORDER BY
    C.data_hora;



--- COMANDOS PARA A CONSULTA 4 ---
-- intencionalmente, nós colocamos o Cliente Lucas de id 7 fazendo somente 
-- uma compra na farmacia de id 1 30 dias antes

DELIMITER $$
CREATE PROCEDURE `consulta4_passandoIdFarmacia` (id_farmacia_param INT)
BEGIN
SELECT clien.id as id_cliente, clien.nome as nome, clien.telefone, clien.idade as idade, clientes_ultimo_ano.qtd_comprada_ano as qtd_comprada_ultimo_ano
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

SELECT
    P.codigo_de_barra AS codigo,
    P.nome,
    P.fabricante,
    E.quantidade,
    E.data_validade AS vencimento,
    E.id AS lote
FROM
    Produtos P
JOIN
    Estoque E ON P.id = E.produto_id
JOIN
    EstoqueUnidade EU ON E.id = EU.estoque_id
JOIN
    Unidades U ON EU.unidade_id = U.id
WHERE
    P.nome = 'Dipirona'
    AND U.farmacia_id = 1
ORDER BY
    E.data_validade, E.id;



--- COMANDOS PARA A CONSULTA 6 ---

SELECT P.codigo_de_barra AS codigo, P.nome AS nome, P.fabricante AS fabricante, SUM(PC.quantidade) AS qtd_vendas
FROM Produtos_comprados PC
JOIN Produtos P ON PC.produto_id = P.id
JOIN Compras C ON PC.compra_id = C.id
JOIN Unidades U ON C.farmacia_id = U.farmacia_id AND U.cidade_id = 1  -- Substitua 1 pelo ID da cidade desejada
JOIN Estoque E ON E.produto_id = P.id
JOIN EstoqueUnidade EU ON EU.estoque_id = E.id AND EU.unidade_id = U.id
GROUP BY P.id, P.nome, P.fabricante
ORDER BY qtd_vendas DESC
LIMIT 10;



--- COMANDOS PARA A CONSULTA 7 ---

SELECT p.nome as produto, p.fabricante as fabricante, f.nome AS farmacia, cid.nome as cidade, cid.uf as uf, SUM(e.quantidade) AS qtd_vendas
FROM Farmacias AS f 
	JOIN Compras AS c ON f.id = c.farmacia_id 
	JOIN Produtos_comprados AS pc ON c.id = pc.compra_id
	JOIN Produtos AS P ON p.id = pc.produto_id
    JOIN Estoque as e ON p.id = e.produto_id
    JOIN EstoqueUnidade as eu ON e.id = eu.estoque_id 
    JOIN Cidades AS cid ON f.sede = cid.id
WHERE p.id = 1 AND pc.data_hora_compra > SUBDATE(CURDATE(), INTERVAL 30 DAY) AND c.plataforma = "APP" -- POPULAR MAIS PARA TERMOS NO MINIMO MAIS DE 10 PARA PUXAR SOH 10
GROUP BY f.id
ORDER BY qtd_vendas DESC
LIMIT 10;

--- COMANDOS PARA A CONSULTA 8 ---

SELECT f.nome as farmacia, func.nome as gerente, func.email
FROM Farmacias AS f 
	JOIN Compras AS c ON f.id = c.farmacia_id 
	JOIN Produtos_comprados AS pc ON c.id = pc.compra_id
	JOIN Produtos AS p ON p.id = pc.produto_id
    JOIN Funcionarios as func ON  func.farmacia_id = f.id
    JOIN Estoque ON p.id = Estoque.produto_id 
WHERE p.id = 3 AND pc.data_hora_compra > SUBDATE(CURDATE(), INTERVAL 30 DAY) AND func.cargo = "gerente" 
GROUP BY f.id, func.nome,func.email;



--- COMANDOS PARA A CONSULTA 9 ---

SELECT
    e.entregador_nome AS entregador,
    AVG(subquery.valor_total) AS ticket_medio
FROM (
    SELECT
        e.entregador_nome,
        c.id AS compra_id,
        SUM(PC.quantidade * (PC.preco_unico - COALESCE(PC.desconto_preco_unico, 0))) AS valor_total
    FROM
        entregas e
    JOIN
        compras c ON e.id = c.entrega_id
    JOIN
        produtos_comprados PC ON c.id = PC.compra_id
    WHERE
        e.entregador_id = 1
    GROUP BY
        e.entregador_nome, c.id
) AS subquery
JOIN entregas e ON subquery.compra_id = e.id
GROUP BY
    entregador;


--- COMANDOS PARA CRIAÇÃO E EXEMPLO DE USO DA "VIEW" ---

--- COMANDOS PARA CRIAÇÃO E EXEMPLO DE USO DA FUNÇÃO ---

-- CRIAÇÃO

-- Desativa a verificação de segurança para criação de funções
SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER //
CREATE FUNCTION calcularTotalGasto(compraID INT)
RETURNS DECIMAL(10, 2) -- retorna apenas valor escalar
BEGIN
    DECLARE total DECIMAL(10, 2);

    SELECT SUM(quantidade * preco_unico)
    INTO total
    FROM Produtos_comprados
    WHERE compra_id = compraID;

    RETURN total;
END //
DELIMITER ;
SET GLOBAL log_bin_trust_function_creators = 0;


-- EXEMPLO

CREATE TEMPORARY TABLE ResultadosTotais (
    compra_id INT,
    total_gasto DECIMAL(10, 2)
);
-- Preenche a tabela temporária usando a função
INSERT INTO ResultadosTotais (compra_id, total_gasto)
SELECT id, calcularTotalGasto(id) AS total_gasto
FROM Compras;
-- Exibe os resultados
SELECT * FROM ResultadosTotais ORDER BY total_gasto DESC;


--- COMANDOS PARA CRIAÇÃO E EXEMPLO DE USO DA "STORED PROCEDURE" ---

-- CRIAÇÃO
DELIMITER //
CREATE PROCEDURE ObterQuantidadeProdutoNaFarmaciass(
    IN farmacia_id_param INT,
    IN produto_id_param INT
)
BEGIN
    DECLARE quantidade_produto INT;
    DECLARE nome_produto VARCHAR(100);
    DECLARE nome_farmacia VARCHAR(100);

    SELECT nome INTO nome_farmacia
    FROM Farmacias
    WHERE id = farmacia_id_param;

    SELECT nome INTO nome_produto
    FROM Produtos
    WHERE id = produto_id_param;

    SELECT COALESCE(SUM(Estoque.quantidade), 0) INTO quantidade_produto
    FROM Estoque
    INNER JOIN EstoqueUnidade eu ON Estoque.id = eu.estoque_id
    INNER JOIN Unidades u ON eu.unidade_id = u.id
    WHERE u.farmacia_id = farmacia_id_param AND Estoque.produto_id = produto_id_param;

    SELECT nome_farmacia AS 'Nome da Farmácia', nome_produto AS 'Nome do Produto', quantidade_produto AS 'Quantidade Total do Produto no Estoque';
END //
DELIMITER ;

-- EXEMPLO DA STORED PROCEDURE
CALL ObterQuantidadeProdutoNaFarmaciass(1, 1); -- PRIMEIRO PARAMETRO: farmacia especifica , SEGUNDO PARAMETRO: produto especifico


--- COMANDOS PARA CRIAÇÃO E EXEMPLO DE USO DA "TRIGGER" ---
/* É necessário desligar o modo safe update , para nao gerar o erro: 
Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  
To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.
 */
 
-- CRIAÇÃO
DELIMITER //
CREATE TRIGGER before_update_Produtos_comprados
BEFORE UPDATE ON Produtos_comprados
FOR EACH ROW
BEGIN
    -- Calcula o desconto de 15% no novo preço unitário ->e fornece o valor do produto com o desconto
    SET NEW.desconto_preco_unico = NEW.preco_unico * 0.85;
END;
//
DELIMITER ;

-- EXEMPLOS DA TRIGGER
-- produto_id=1 terao o mesmo preco_unico e receberam um desconto de 15%(pois a trigger será acionada), e assim sucessivamente para os demais
UPDATE Produtos_comprados
SET preco_unico = 22.0
WHERE produto_id = 1;
UPDATE Produtos_comprados
SET preco_unico = 15.0
WHERE produto_id = 2;
UPDATE Produtos_comprados
SET preco_unico = 40.0
WHERE produto_id = 3;
UPDATE Produtos_comprados
SET preco_unico = 20.0
WHERE produto_id = 4;
UPDATE Produtos_comprados
SET preco_unico = 30.0
WHERE produto_id = 5;

select produto_id, produtos.nome AS PRODUTOS , preco_unico as PrecoSemDesconto, desconto_preco_unico as PrecoDesconto
from produtos_comprados
join produtos ON produtos_comprados.produto_id = produtos.id;
