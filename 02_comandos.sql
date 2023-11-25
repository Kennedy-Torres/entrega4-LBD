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
    cidade_id INT NOT NULL,
	nome VARCHAR(100) NULL,
    idade INT NULL,
    FOREIGN KEY (cidade_id) REFERENCES Cidades(id)
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
    numero VARCHAR(100) NOT NULL
);
CREATE TABLE TelefoneFuncionarios(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    telefone_id INT NOT NULL,
    funcionario_id INT NOT NULL,
    FOREIGN KEY (telefone_id) REFERENCES Telefones(id),
    FOREIGN KEY (funcionario_id) REFERENCES Funcionarios(id)
);
CREATE TABLE TelefoneClientes(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    telefone_id INT NOT NULL,
    cliente_id INT NOT NULL,
    FOREIGN KEY (telefone_id) REFERENCES Telefones(id),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);
CREATE TABLE Compras(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	farmacia_id INT NULL,
    cliente_id INT NULL,
    valor_total DECIMAL(10,2) NULL,
    data_hora TIMESTAMP,
    desconto_compra DECIMAL(10,2) NULL, -- usado no desenvolvimento da trigger
    FOREIGN KEY (farmacia_id) REFERENCES Farmacias(id),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);
CREATE TABLE Produtos_comprados(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	compra_id INT NULL,
    produto_id INT NULL,
    quantidade INT NULL,
    data_hora_compra TIMESTAMP NULL, 
    preco_unico DECIMAL(10,2) NULL,
    desconto_preco_unico DECIMAL(10,2) NULL
);
CREATE TABLE Entregadores(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(100) NULL
);
/*CREATE TABLE Retiradas(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	metodo VARCHAR(100) NULL,
    data_hora_retirada TIMESTAMP NULL
);*/
CREATE TABLE Entregas(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	entregador_id INT NULL,
    compra_id INT NULL,
    metodo_retirada VARCHAR(100) NULL,
    /*data_hora TIMESTAMP,*/
    /*retirada_id INT NULL,*/
    FOREIGN KEY (entregador_id) REFERENCES Entregadores(id),
    FOREIGN KEY (compra_id) REFERENCES Compras(id)
    /*FOREIGN KEY (retirada_id) REFERENCES Retiradas(id)*/
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

INSERT INTO Clientes(cidade_id,nome, idade) VALUES /*total registrado: 5*/
(1,'João',57),
(2,'Maria',35),
(2,'Carlos',45),
(3,'Ana',28),
(4,'Pedro',50);

INSERT INTO Compras(farmacia_id, cliente_id, valor_total, data_hora) VALUES /*Total registrado: 10*/
(1, 1, 150.52, '2023-11-24 10:15:00'), -- Compra 1 (DF)
(1, 1, 75.25, '2023-11-24 12:30:00'),  -- Compra 2 (DF)
(3, 3, 200.00, '2023-11-25 14:45:00'),  -- Compra 3 (CE)
(4, 4, 120.75, '2023-11-26 16:00:00'), -- Compra 4 (CE)
(5, 5, 180.30, '2023-11-27 18:15:00'),  -- Compra 5 (DF)
(1, 2, 75.00, '2023-11-28 09:30:00'),   -- Compra 6 (DF)
(2, 2, 150.00, '2023-11-29 11:45:00'),  -- Compra 7 (DF)
(4, 4, 50.00, '2023-11-30 13:00:00'),   -- Compra 8 (CE)
(4, 4, 100.00, '2023-12-01 15:15:00'),  -- Compra 9 (CE)
(4, 4, 25.00, '2023-12-02 17:30:00'),   -- Compra 10 (CE)
(1, 1, 120.00, '2023-11-14 08:27:43'),
(1, 2, 80.00, '2023-11-15 10:30:00'),
(2, 3, 150.00, '2023-11-14 14:45:00'),
(2, 4, 100.00, '2023-11-15 16:00:00'),
(3, 5, 90.00, '2023-11-15 18:15:00'),
    (3, 3, 180.00, '2023-05-30 17:10:00'),
    (2, 2, 45.00, '2023-08-20 11:00:00'),
    (5, 5, 60.00, '2023-07-05 09:45:00'),
    (1, 1, 100.00, '2023-09-15 16:15:00'),
    (4, 4, 80.00, '2023-09-15 16:15:00'),
    (5, 5, 45.00, '2023-10-25 13:30:00'),
    (1, 1, 150.00, '2023-10-25 13:30:00'),
    (3, 3, 95.00, '2023-10-25 14:30:00'),
    (2, 2, 110.00, '2023-10-25 15:30:00');

INSERT INTO Produtos_comprados(compra_id, produto_id, quantidade, preco_unico) VALUES
(1, 1, 10, 25.00),(1, 2, 2, 15.50),(1, 3, 1, 30.00),
(2, 1, 5, 25.00),(2, 4, 3, 20.25),
(3, 2, 2, 15.00),(3, 3, 4, 40.00),(3, 5, 1, 30.00),
(4, 1, 3, 25.00),(4, 2, 2, 17.25),(4, 3, 5, 30.00),
(5, 5, 2, 20.00),(5, 1, 3, 25.00),(5, 4, 1, 30.00),
(6, 1, 2, 25.00),(6, 3, 1, 30.00),
(7, 2, 3, 15.00),(7, 4, 2, 20.25),
(8, 1, 1, 25.00),(8, 5, 2, 15.00),
(9, 3, 3, 30.00),(9, 4, 1, 15.00),
(10, 2, 2, 15.00),(10, 5, 1, 12.00);

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

INSERT INTO Telefones(numero) VALUES -- total registrado: 10 + 29 = 39 telefones
('(31)99533-5288'), ('(31)98765-4321'), -- Cliente 1 - MG
('(61)92345-6789'), ('(61)93456-7890'), -- Cliente 2 - DF
('(61)91234-5678'), ('(61)94567-8901'), -- Cliente 3 - DF
('(61)97890-1234'), ('(61)96543-2109'), -- Cliente 4 - DF 
('(88)99999-0000'), ('(88)98888-1111'), -- Cliente 5 - CE
('99533-1234'), ('99533-5678'), -- Funcionário 1
('92345-4321'), ('92345-8765'), -- Funcionário 2
('91234-9876'),                 -- Funcionário 3
('97890-5678'), ('97890-9012'), -- Funcionário 4
('99999-2345'),                 -- Funcionário 5
('99533-7890'), ('98765-4321'), -- Funcionário 6
('92345-8765'),                 -- Funcionário 7
('91234-0123'), ('94567-8901'), -- Funcionário 8
('97890-2109'),                 -- Funcionário 9
('99999-4567'),                 -- Funcionário 10
('99533-8901'), ('98765-1234'), -- Funcionário 11
('92345-0987'),                 -- Funcionário 12
('91234-3456'), ('94567-6789'), -- Funcionário 13
('97890-4321'),                 -- Funcionário 14
('99999-7890'),                 -- Funcionário 15
('99533-2109'), ('98765-2345'), -- Funcionário 16
('92345-9012'),                 -- Funcionário 17
('91234-5678'), ('94567-8901'), -- Funcionário 18
('97890-2345'),                 -- Funcionário 19
('99999-0123');                 -- Funcionário 20

INSERT INTO TelefoneClientes(cliente_id, telefone_id) VALUES
  (1, 1), (1, 2), (2, 3), (2, 4), (3, 5), (3, 6), (4, 7), (4, 8), (5, 9), (5, 10);
  
  INSERT INTO TelefoneFuncionarios(funcionario_id, telefone_id) VALUES
  (1, 11), (1, 12), (2, 13), (2, 14), (3, 15), (4, 16), (4, 17), (5, 18), (6, 19), (7, 20),
  (8, 21), (8, 22), (9, 23), (10, 24), (11, 25), (11, 26), (12, 27), (13, 28), (13, 29),
  (14, 30), (15, 31), (16, 32), (16, 33), (17, 34), (18, 35), (18, 36), (19, 37), (20, 38);

INSERT INTO Entregadores (nome) VALUES /*total registrado: 10*/
('Sérgio Oliveira'),('Ana Silva'),('Carlos Santos'),('Juliana Pereira'),('Roberto Souza'),
('Camila Lima'),('Lucas Ferreira'),('Fernanda Oliveira'),('Paulo Santos'),('Aline Costa');

/*
INSERT INTO Retiradas (metodo, data_hora_retirada) VALUES 
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
*/

-- População da tabela Entregas correspondente, incluindo retirada_id
INSERT INTO Entregas(entregador_id, compra_id, metodo_retirada) VALUES /*Total registrado: 10 retiradas... em um total de 39*/
(1, 1,'App'),(2, 2,'Portal'),(3, 3,'loja'),
(4, 4, 'App'),(5, 5,'loja'),(6, 6,'Portal'),
(7, 7,'App'),(8, 8,'loja'),(9, 9,'App'),(10, 10,'Portal'),
(1, 11, 'loja'), (2, 12, 'App'), (3, 13, 'loja'),
(4, 14, 'Portal'), (5, 15, 'App'), (6, 16, 'Portal'),
(7, 17, 'loja'), (8, 18, 'Portal'), (9, 19, 'loja'), (10, 20, 'App');


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
    

--- COMANDOS PARA A CONSULTA 2 ---

DELIMITER //
CREATE PROCEDURE BuscarClientesPorUF(IN uf_param VARCHAR(2))
BEGIN
    SELECT
        C.id AS id,
        C.nome AS nome,
        T.numero AS telefone,
        C.idade AS idade,
        COUNT(DISTINCT Co.id) AS nr_de_compras
    FROM
        Clientes C
    LEFT JOIN
        TelefoneClientes TC ON C.id = TC.cliente_id
    LEFT JOIN
        Telefones T ON TC.telefone_id = T.id
    LEFT JOIN
        Compras Co ON C.id = Co.cliente_id
    LEFT JOIN
        Cidades Ci ON C.cidade_id = Ci.id
    WHERE
        Ci.uf = uf_param
    GROUP BY
        C.id, C.nome, T.numero, C.idade
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
CALL BuscarClientesPorUF('MG'); -- Substitua pelo estado desejado 'DF', 'CE' ou 'MG' esta consulta vai ser altera devido mudanças na tabela telefone


--- COMANDOS PARA A CONSULTA 3 ---
SELECT
    c.id AS id_compra,
    cli.nome AS cliente,
    c.valor_total,
    e.metodo_retirada AS plataforma,
    c.data_hora
FROM
    Compras c
JOIN Clientes cli ON c.cliente_id = cli.id
LEFT JOIN Entregas e ON c.id = e.compra_id
WHERE
    (e.metodo_retirada IS NULL OR e.metodo_retirada NOT IN ('App')) -- Exclui entregas pelo aplicativo
    AND c.data_hora BETWEEN '2023-11-14 00:00:00' AND '2023-11-15 23:59:59'
ORDER BY
    c.data_hora;




--- COMANDOS PARA A CONSULTA 4 ---

--- COMANDOS PARA A CONSULTA 5 ---

--- COMANDOS PARA A CONSULTA 6 ---

--- COMANDOS PARA A CONSULTA 7 ---

--- COMANDOS PARA A CONSULTA 8 ---

--- COMANDOS PARA A CONSULTA 9 ---

--- COMANDOS PARA CRIAÇÃO E EXEMPLO DE USO DA "VIEW" ---

--- COMANDOS PARA CRIAÇÃO E EXEMPLO DE USO DA FUNÇÃO ---

--- COMANDOS PARA CRIAÇÃO E EXEMPLO DE USO DA "STORED PROCEDURE" ---
-- Criação da stored procedure

-- Exemplo de uso 

--- COMANDOS PARA CRIAÇÃO E EXEMPLO DE USO DA "TRIGGER" ---

/*
CREATE TRIGGER tr_descontoCompra BEFORE INSERT 
ON Compras 
FOR EACH ROW
SET NEW.desconto_compra = (NEW.valor_total * 0.90); -- desconto de 10% na compra total
*/
DELIMITER //
CREATE TRIGGER tr_descontoProduto1Farmaciaa1 
BEFORE INSERT ON produtos_comprados
FOR EACH ROW
BEGIN
    DECLARE desconto DECIMAL(10, 2);

    -- Verifica se o produto_id é 1 e se a compra pertence à farmacia_id 1
    IF (SELECT farmacia_id FROM Compras WHERE id = NEW.compra_id) = 1 AND NEW.produto_id = 1 THEN
        -- Calcula o desconto de 15%
        SET desconto = NEW.preco_unico * 0.15;
        -- Aplica o desconto ao preco_unico
        SET NEW.preco_unico = NEW.preco_unico - desconto;
    END IF;
END;
//
DELIMITER ;

select*from produtos_comprados;


DELIMITER //
CREATE TRIGGER tr_desconto_produto
BEFORE INSERT ON produtos_comprados
FOR EACH ROW
BEGIN
    DECLARE qtd_produto_comprado INT;

    -- Verificar a quantidade total de produtos comprados com produto_id = 1 na farmacia_id = 1
    SELECT SUM(quantidade) INTO qtd_produto_comprado
    FROM produtos_comprados pc
    JOIN compras c ON pc.compra_id = c.id
    WHERE pc.produto_id = 1 AND c.farmacia_id = 1;

    -- Aplicar desconto de 15% nos próximos 30 produtos comprados com produto_id = 1 na farmacia_id = 1
    IF qtd_produto_comprado <= 30 THEN
        SET NEW.desconto_preco_unico = NEW.preco_unico * 0.85; -- Aplicar desconto de 15%
    END IF;
END;
//
DELIMITER ;
-- Inserir uma compra na farmacia_id = 1
INSERT INTO compras (farmacia_id, cliente_id, valor_total) VALUES (1, 1, 100.0);

-- Inserir produtos_comprados com produto_id = 1 na compra recém-criada
-- Certifique-se de inserir 30 produtos para testar o desconto
INSERT INTO produtos_comprados (compra_id, produto_id, quantidade, data_hora_compra, preco_unico)
VALUES
    (41, 1, 5, '2023-11-24 10:00:00', 20.0),
    (42, 1, 5, '2023-11-24 10:05:00', 20.0);
    -- Adicione mais linhas conforme necessário para atingir um total de 30 produtos
    
-- Consultar os registros inseridos
SELECT * FROM produtos_comprados WHERE compra_id = 1;

SELECT produto_id, preco_unico, desconto_preco_unico
FROM produtos_comprados
WHERE produto_id = 1;



