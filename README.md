# 🏪 Gestión de Inventario para TechZone

## 📌 Descripción del Proyecto

Este proyecto consiste en el desarrollo de un sistema de gestión de inventario y ventas para la tienda **TechZone**, especializada en productos tecnológicos como laptops, teléfonos, accesorios y componentes electrónicos.  

Actualmente, la tienda manejaba sus inventarios y ventas en hojas de cálculo, lo que generaba problemas como errores en stock, seguimiento ineficiente de ventas y dificultad en la gestión de proveedores. Con este sistema, se busca automatizar el registro de productos, clientes, proveedores y ventas, garantizando integridad de los datos y facilitando el análisis de información clave.

El proyecto se implementa en **PostgreSQL** y cumple con las siguientes funcionalidades:  

- Registro de productos con nombre, categoría, precio, stock y proveedor.  
- Registro de clientes con nombre, correo electrónico y teléfono.  
- Registro de ventas y detalle de productos vendidos.  
- Registro de proveedores y productos que suministran.  
- Consultas avanzadas para análisis de ventas, stock y clientes frecuentes.  
- Procedimiento almacenado para registrar ventas con validación de stock y cliente existente.

---

## 📂 Estructura del Repositorio

El repositorio contiene los siguientes archivos:

| Archivo | Descripción |
|---------|------------|
| `modelo_er.png` | Diagrama Entidad-Relación (E-R) del sistema, normalizado hasta 3FN. |
| `db.sql` | Script SQL para la creación de la base de datos, tablas, claves primarias y foráneas, y restricciones. |
| `insert.sql` | Script SQL para insertar datos de prueba (7 a 10 registros por entidad). |
| `queries.sql` | Consultas avanzadas para análisis de inventario, ventas y clientes. |
| `procedure.sql` | Procedimiento almacenado para registrar ventas con validación de stock y cliente. |
| `README.md` | Documentación del proyecto y guía de uso. |

---

## 🗂️ Contenido de los Scripts

### 1️⃣ db.sql
- Crea el esquema de la base de datos `techzone`.  
- Define las tablas: `clientes`, `proveedores`, `productos`, `ventas`, `ventas_detalle`.  
- Establece relaciones entre tablas mediante claves foráneas.  
- Aplica restricciones de integridad (NOT NULL, UNIQUE, CHECK).

### 2️⃣ insert.sql
- Inserta datos de ejemplo para cada tabla:  
  - 7-10 clientes.  
  - 7-10 proveedores.  
  - 7-10 productos.  
  - 7-10 ventas y detalles de ventas.  

### 3️⃣ queries.sql
Incluye 6 consultas avanzadas:  
1. Listar productos con stock menor a 5 unidades.  
2. Calcular ventas totales de un mes específico.  
3. Obtener el cliente con más compras realizadas.  
4. Listar los productos más vendidos.  
5. Consultar ventas realizadas en un rango de fechas.  
6. Identificar clientes que no han comprado en los últimos 6 meses.

### 4️⃣ procedure.sql
- Procedimiento almacenado `registrar_venta(cliente_id, producto_id, cantidad)` que:  
  - Valida que el cliente exista.  
  - Verifica que haya stock suficiente para la venta.  
  - Actualiza el inventario si la venta se realiza correctamente.  
  - Lanza un error (`RAISE`) si el cliente no existe o no hay stock suficiente.

---

## ⚙️ Instrucciones para Ejecutar

1. Abrir **PostgreSQL** y crear el esquema de trabajo:

```sql
-- Ejecutar db.sql
\i path_to/db.sql
