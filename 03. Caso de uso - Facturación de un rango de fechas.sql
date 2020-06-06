/**
 * Caso de uso: Facturación en un rango de fechas específico
 */
-- Variables
set @FechaInicial = '2020-06-01';
set @FechaFinal = '2020-06-05';

-- SQL: Facturación en un rango de fechas específico
SELECT 
    F.id AS factura_id,
    DATE(F.dt_creacion) AS fecha,
    F.total,
    F.clientes_id,
    C.nombre
FROM
    facturas AS F
        INNER JOIN
    clientes AS C ON F.clientes_id = C.id
WHERE
    (DATE(F.dt_creacion) BETWEEN @FechaInicial AND @FechaFinal);

-- SQL: Facturación en un rango de fechas específico (con detalle de productos)    
SELECT 
    F.id AS factura_id,
    DATE(F.dt_creacion) AS fecha,
    F.total,
    F.clientes_id,
    C.nombre,
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
        INNER JOIN
    productos AS P ON P.id = FP.productos_id
WHERE
    (DATE(F.dt_creacion) BETWEEN @FechaInicial AND @FechaFinal);

    
