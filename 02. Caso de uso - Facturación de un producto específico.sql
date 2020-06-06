/**
 * Caso de uso: La facturación de un producto en especifico
 */
-- Variables
SET @ProductoId = 42;

-- SQL: La facturación de un producto en especifico
SELECT 
    P.id AS producto_id,
    P.nombre AS producto,
    F.id AS factura_id,
    F.descuento,
    F.total,
    C.nombre
FROM
    productos AS P
        INNER JOIN
    factura_productos AS FP ON P.id = FP.productos_id
        AND P.id = @ProductoId
        INNER JOIN
    facturas AS F ON FP.facturas_id = F.id
        INNER JOIN
    clientes AS C ON F.clientes_id = C.id;
