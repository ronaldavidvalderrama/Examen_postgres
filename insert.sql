SET search_path TO techzone;

INSERT INTO techzone.clientes (id_cliente, nombre, apellidos, telefono, correo_electronico) VALUES
('CC1001', 'Juan Diego',   'Menezes',          3004567890,  'juan.menezes@example.com'),
('CC1002', 'Ronal David',  'Valderrama Gomez', 3109876543,  'ronal.valderrama@example.com'),
('CC1003', 'Valeria',      'Suares Caceres',   3012223344,  'valeria.suares@example.com'),
('CC1004', 'Juan David',   'Villamizar Perez', 3155556677,  'juan.villamizar@example.com'),
('CC1005', 'Luisa Fernanda','Moreno Peña',     3028889911,  'luisa.moreno@example.com'),
('CC1006', 'Carlos',       'Duran',            3014567890,  'carlos.duran@example.com'),
('CC1007', 'Adrian',       'Ortiz',            3126665544,  'adrian.ortiz@example.com'),
('CC1008', 'Miguel',       'Vargas Rincón',    3201234567,  'miguel.vargas@example.com');


INSERT INTO techzone.proveedores (nombre, contacto, telefono, correo, estado) VALUES
('TechWorld S.A.',      'Ana Martínez',   '3105551234', 'contacto@techworld.com', 1),
('ElectroGlobal Ltda.', 'Carlos Pérez',   '3114445678', 'ventas@electroglobal.com', 1),
('DigitalNet SAS',      'Laura Gómez',    '3123339876', 'info@digitalnet.com', 1),
('CompuCenter',         'Jorge Ramírez',  '3132227654', 'soporte@compucenter.com', 1),
('SmartTech',           'Paola Rodríguez','3141113456', 'servicio@smarttech.com', 1);


INSERT INTO techzone.categorias (descripcion, estado) VALUES
('Laptops', 1),
('Smartphones', 1),
('Accesorios', 1),
('Tablets', 1),
('Componentes PC', 1);



INSERT INTO techzone.productos (nombre, id_categoria, id_proveedor, precio_venta, cantidad_stock, estado, codigo_barras) VALUES
('Laptop Dell Inspiron 15',     1, 1, 2500000, 15, 1, '7501234567890'),
('Laptop HP Pavilion 14',       1, 2, 2800000, 10, 1, '7501234567891'),
('iPhone 13 128GB',             2, 3, 4200000, 20, 1, '7501234567892'),
('Samsung Galaxy S22',          2, 3, 3900000, 18, 1, '7501234567893'),
('Teclado Mecánico Logitech',   3, 4, 350000,  30, 1, '7501234567894'),
('Mouse Inalámbrico Microsoft', 3, 4, 120000,  25, 1, '7501234567895'),
('Tablet Samsung Galaxy Tab A', 4, 5, 1500000, 12, 1, '7501234567896'),
('Memoria RAM 16GB DDR4',       5, 1, 450000,  40, 1, '7501234567897'),
('Disco Duro SSD 1TB Kingston', 5, 2, 520000,  35, 1, '7501234567898'),
('Auriculares Bluetooth Sony',  3, 5, 280000,  22, 1, '7501234567899');


INSERT INTO techzone.ventas (id_cliente, medio_pago, estado) VALUES
('CC1001', 'Tarjeta', 1),
('CC1003', 'Efectivo', 1),
('CC1005', 'Transferencia', 1);


-- Venta 1: Juan Diego compra Laptop Dell y un mouse
INSERT INTO techzone.ventas_detalle (id_venta, id_producto, cantidad, subtotal, estado) VALUES
(1, 1, 1, 2500000, 1),
(1, 6, 1, 120000, 1);

-- Venta 2: Valeria compra un iPhone
INSERT INTO techzone.ventas_detalle (id_venta, id_producto, cantidad, subtotal, estado) VALUES
(2, 3, 1, 4200000, 1);

-- Venta 3: Luisa compra audífonos y una memoria RAM
INSERT INTO techzone.ventas_detalle (id_venta, id_producto, cantidad, subtotal, estado) VALUES
(3, 10, 1, 280000, 1),
(3, 8, 2, 900000, 1);
