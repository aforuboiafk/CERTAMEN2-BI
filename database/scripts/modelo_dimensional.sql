DELETE FROM H_VENTAS;
DELETE FROM D_PRODUCTOS;
DELETE FROM D_SUCURSALES;
DELETE FROM D_EMPLEADOS;
DELETE FROM D_CLIENTES;
DELETE FROM D_TIEMPO;


-- 1. Dimensión Cliente
CREATE TABLE D_CLIENTES (
    sk_cliente INT IDENTITY(1,1) PRIMARY KEY,
    cliente_id_nk INT,
    sexo NVARCHAR(20),
    estado_civil NVARCHAR(50),
    edad INT
);

-- 2. Dimensión Producto
CREATE TABLE D_PRODUCTOS (
    sk_producto INT IDENTITY(1,1) PRIMARY KEY,
    producto_id_nk INT,
    nombre NVARCHAR(100),
    precio INT,
    categoria NVARCHAR(100)
);

-- 3. Dimensión Sucursal
CREATE TABLE D_SUCURSALES (
    sk_sucursal INT IDENTITY(1,1) PRIMARY KEY,
    sucursal_id_nk INT,
    sucursal NVARCHAR(100),
    comuna NVARCHAR(100)
);

-- 4. Dimensión Empleado
CREATE TABLE D_EMPLEADOS (
    sk_empleado INT IDENTITY(1,1) PRIMARY KEY,
    empleado_id_nk INT,
    nombre_completo NVARCHAR(150),
    cargo NVARCHAR(100)
);
