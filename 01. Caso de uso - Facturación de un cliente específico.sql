/** 
 * Caso de uso: Consulta de la facturación de un cliente
 */
-- Variables
Set @ClienteId = 1000; 

-- SQL: Consulta de la facturación de un cliente en específico
SELECT 
    F.clientes_id,
    C.nombre,
    F.id AS factura_id,
    DATE(F.dt_creacion) AS fecha,
    f.descuento,
    F.total
FROM
    facturas AS F
        INNER JOIN
    clientes AS C ON F.clientes_id = C.id
        AND F.clientes_id = @ClienteId
;
    
-- SQL: Consulta de la facturación de un cliente en específico (con detalle de productos)
SELECT 
    F.clientes_id,
    C.nombre,
    F.id AS factura_id,
    DATE(F.dt_creacion) AS fecha,
    F.total,
    P.id AS producto_id,
    P.nombre AS producto,
    FP.cantidad AS cantidad,
    FP.precio_unitario,
    FP.impuesto_unitario,
    (FP.cantidad * FP.precio_unitario) AS total_linea
FROM
    facturas AS F
        INNER JOIN
    clientes AS C ON F.clientes_id = C.id
        INNER JOIN
    factura_productos AS FP ON F.id = FP.facturas_id
        AND F.clientes_id = @ClienteId
        INNER JOIN
    productos AS P ON P.id = FP.productos_id;
