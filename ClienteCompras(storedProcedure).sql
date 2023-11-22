-- Criação da stored procedure
DELIMITER //
CREATE PROCEDURE GetClienteCompras(IN uf_param VARCHAR(2))
BEGIN
    SELECT
        c.id,
        c.nome,
        c.telefone,
        c.idade,
        COUNT(co.id) AS nr_de_comprasGetClienteCompras
    FROM
        Clientes c
    JOIN
        Compras co ON c.id = co.cliente_id
    JOIN
        Unidades u ON co.farmacia_id = u.farmacia_id
    JOIN
        Cidades ci ON u.cidade_id = ci.id
    WHERE
        ci.uf = uf_param
    GROUP BY
        c.id, c.nome, c.telefone, c.idade
    HAVING
        COUNT(co.id) = (
            SELECT
                COUNT(co_sub.id)
            FROM
                Compras co_sub
            JOIN
                Unidades u_sub ON co_sub.farmacia_id = u_sub.farmacia_id
            JOIN
                Cidades ci_sub ON u_sub.cidade_id = ci_sub.id
            WHERE
                ci_sub.uf = uf_param
            GROUP BY
                co_sub.cliente_id
            ORDER BY
                COUNT(co_sub.id) DESC
            LIMIT 1
        );
END //
DELIMITER ;
