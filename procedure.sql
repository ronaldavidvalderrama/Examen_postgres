-- Un procedimiento almacenado para registrar una venta.

CREATE OR REPLACE PROCEDURE techzone.registrar_venta_simple(
    p_id_cliente VARCHAR,
    p_medio_pago VARCHAR,
    p_productos JSON
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_venta INT;
BEGIN
    -- Insertar venta
    INSERT INTO techzone.ventas (id_cliente, medio_pago)
    VALUES (p_id_cliente, p_medio_pago)
    RETURNING id_venta INTO v_id_venta;

    -- Insertar detalle de venta y actualizar stock
    FOR v_producto IN SELECT * FROM json_array_elements(p_productos)
    LOOP
        INSERT INTO techzone.ventas_detalle (id_venta, id_producto, cantidad, subtotal)
        VALUES (
            v_id_venta,
            (v_producto ->> 'id_producto')::INT,
            (v_producto ->> 'cantidad')::INT,
            (v_producto ->> 'cantidad')::INT *
            (SELECT precio_venta FROM techzone.productos WHERE id_producto = (v_producto ->> 'id_producto')::INT)
        );

        UPDATE techzone.productos
        SET cantidad_stock = cantidad_stock - (v_producto ->> 'cantidad')::INT
        WHERE id_producto = (v_producto ->> 'id_producto')::INT;
    END LOOP;
END;
$$;

-- Implementación de validaciones haciendo uso de RAISE para:

CREATE OR REPLACE PROCEDURE techzone.registrar_venta_validar_cliente(
    p_id_cliente VARCHAR,
    p_medio_pago VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_id_venta INT;
BEGIN
    -- Validar que el cliente exista
    IF NOT EXISTS (SELECT 1 FROM techzone.clientes WHERE id_cliente = p_id_cliente) THEN
        RAISE EXCEPTION 'El cliente % no existe', p_id_cliente;
    END IF;

    -- Insertar la venta si el cliente existe
    INSERT INTO techzone.ventas (id_cliente, medio_pago)
    VALUES (p_id_cliente, p_medio_pago)
    RETURNING id_venta INTO v_id_venta;

    RAISE NOTICE 'Venta registrada correctamente con ID %', v_id_venta;
END;
$$;
