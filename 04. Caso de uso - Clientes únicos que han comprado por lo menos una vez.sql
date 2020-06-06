/**
 * Caso de uso: Clientes únicos que han comprado por lo menos una vez
 */
-- SQL: Clientes únicos que han comprado por lo menos una vez
SELECT 
    C.id, C.identificacion, C.nombre, P.nombre AS pais
FROM
    clientes AS C
        INNER JOIN
    paises AS P ON C.paises_id = P.id
        INNER JOIN
    (SELECT DISTINCT
        clientes_id
    FROM
        facturas) AS F ON C.id = F.clientes_id
ORDER BY C.nombre;