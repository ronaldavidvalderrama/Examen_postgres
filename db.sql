DROP SCHEMA IF EXISTS techzone CASCADE;
CREATE SCHEMA IF NOT EXISTS techzone;
SET search_path TO techzone;

CREATE TABLE techzone.clientes (
    id_cliente         VARCHAR(20)  PRIMARY KEY,
    nombre             VARCHAR(40)  NOT NULL,
    apellidos          VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) UNIQUE NOT NULL,
    telefono           VARCHAR(15)
);


CREATE TABLE techzone.proveedores (
    id_proveedor   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre         VARCHAR(100) NOT NULL,
    contacto       VARCHAR(100),
    telefono       VARCHAR(20),
    correo         VARCHAR(100),
    estado         SMALLINT NOT NULL DEFAULT 1,
    CONSTRAINT proveedores_estado_chk CHECK (estado IN (0,1))
);

CREATE TABLE techzone.categorias (
    id_categoria  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    descripcion   VARCHAR(50) NOT NULL,
    estado        SMALLINT    NOT NULL DEFAULT 1,
    CONSTRAINT categorias_estado_chk CHECK (estado IN (0,1))
);

CREATE TABLE techzone.productos (
    id_producto     INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    id_categoria    INT          NOT NULL,
    id_proveedor    INT          NOT NULL,
    precio_venta    NUMERIC(12,2) NOT NULL,
    cantidad_stock  INT          NOT NULL DEFAULT 0,
    estado          SMALLINT     NOT NULL DEFAULT 1,
    codigo_barras   VARCHAR(150),
    CONSTRAINT productos_precio_chk   CHECK (precio_venta >= 0),
    CONSTRAINT productos_stock_chk    CHECK (cantidad_stock >= 0),
    CONSTRAINT productos_estado_chk   CHECK (estado IN (0,1)),

    CONSTRAINT productos_fk_categoria FOREIGN KEY (id_categoria)
        REFERENCES techzone.categorias(id_categoria)
        ON UPDATE CASCADE ON DELETE RESTRICT,

    CONSTRAINT productos_fk_proveedor FOREIGN KEY (id_proveedor)
        REFERENCES techzone.proveedores(id_proveedor)
        ON UPDATE CASCADE ON DELETE RESTRICT
);



CREATE UNIQUE INDEX IF NOT EXISTS ux_productos_codigo_barras
    ON techzone.productos (codigo_barras)
    WHERE codigo_barras IS NOT NULL;

CREATE INDEX IF NOT EXISTS idx_productos_categoria
    ON techzone.productos (id_categoria);

CREATE INDEX IF NOT EXISTS idx_productos_proveedor
    ON techzone.productos (id_proveedor);


CREATE TABLE techzone.ventas (
    id_venta     INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_cliente   VARCHAR(20) NOT NULL,
    fecha        TIMESTAMP   NOT NULL DEFAULT NOW(),
    medio_pago   VARCHAR(20) NOT NULL,
    estado       SMALLINT    NOT NULL DEFAULT 1,

    CONSTRAINT ventas_fk_cliente FOREIGN KEY (id_cliente)
        REFERENCES techzone.clientes(id_cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT ventas_estado_chk CHECK (estado IN (0,1))
);

CREATE TABLE techzone.ventas_detalle (
    id_venta    INT           NOT NULL,
    id_producto INT           NOT NULL,
    cantidad    INT           NOT NULL,
    subtotal    NUMERIC(12,2) NOT NULL,
    estado      SMALLINT      NOT NULL DEFAULT 1,

    CONSTRAINT ventas_detalle_pk PRIMARY KEY (id_venta, id_producto),

    CONSTRAINT ventas_detalle_cantidad_chk CHECK (cantidad > 0),
    CONSTRAINT ventas_detalle_subtotal_chk CHECK (subtotal >= 0),
    CONSTRAINT ventas_detalle_estado_chk CHECK (estado IN (0,1)),

    CONSTRAINT ventas_detalle_fk_venta FOREIGN KEY (id_venta)
        REFERENCES techzone.ventas(id_venta)
        ON UPDATE CASCADE ON DELETE CASCADE,

    CONSTRAINT ventas_detalle_fk_producto FOREIGN KEY (id_producto)
        REFERENCES techzone.productos(id_producto)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

