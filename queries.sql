-- 1️⃣ Listar los productos con stock menor a 5 unidades.

SELECT 
    id_producto,
    nombre,
    cantidad_stock,
    TO_CHAR(precio_venta, 'FM$999G999G999') AS precio
FROM techzone.productos
WHERE cantidad_stock < 5;


--2️⃣ Calcular ventas totales de un mes específico.

SELECT
    TO_CHAR(fecha, 'YYYY-MM') AS mes,
    SUM(subtotal) AS ventas_totales
FROM techzone.ventas_detalle
WHERE EXTRACT(MONTH FROM fecha) = 8
GROUP BY mes;


-- 3️⃣ Calcular el total de ventas de un mes específico.

SELECT
    DATE_TRUNC('month', v.fecha) AS mes,
    SUM(vd.subtotal) AS total_ventas
FROM techzone.ventas v
JOIN techzone.ventas_detalle vd
    ON v.id_venta = vd.id_venta
WHERE EXTRACT(YEAR FROM v.fecha) = 2025
  AND EXTRACT(MONTH FROM v.fecha) = 8
  GROUP BY DATE_TRUNC('month', v.fecha);

-- 4️⃣ Listar los productos más vendidos.

SELECT 
    p.nombre AS producto,
    SUM(vd.cantidad) AS total_vendido
FROM techzone.ventas v
JOIN techzone.ventas_detalle vd 
    ON v.id_venta = vd.id_venta
JOIN techzone.productos p 
    ON vd.id_producto = p.id_producto
GROUP BY p.nombre
ORDER BY total_vendido DESC
LIMIT 3;

-- 5️⃣ Consultar ventas realizadas en un rango de fechas.

SELECT vd.id_venta,
       TO_CHAR(v.fecha, 'YYYY-MM-DD HH24:MI:SS') AS fecha,
       v.medio_pago,
       vd.estado
FROM techzone.ventas AS v
JOIN techzone.ventas_detalle vd
    ON vd.id_venta = v.id_venta
WHERE EXTRACT(YEAR FROM v.fecha) BETWEEN 2025 AND 2026
  AND EXTRACT(MONTH FROM v.fecha) BETWEEN 8 AND 9
ORDER BY v.fecha DESC;


-- 6️⃣ Identificar clientes que no han comprado en los últimos 6 meses.


SELECT c.id_cliente,
       c.nombre,
       c.apellidos,
       c.correo_electronico,
       c.telefono
FROM techzone.clientes c
WHERE c.id_cliente NOT IN (
    SELECT v.id_cliente
    FROM techzone.ventas v
    WHERE v.fecha >= (CURRENT_DATE - INTERVAL '6 months')
)
