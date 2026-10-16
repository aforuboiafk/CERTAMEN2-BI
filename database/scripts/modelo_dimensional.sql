DROP TABLE H_VENTAS;
DROP TABLE D_CLIENTES;
DROP TABLE D_PRODUCTOS;
DROP TABLE D_SUCURSALES;
DROP TABLE D_EMPLEADOS;
DROP TABLE D_TIEMPO;

CREATE TABLE D_CLIENTES (
    sk_cliente INT IDENTITY(1,1) PRIMARY KEY,
    cliente_id_nk INT,
    sexo CHAR(1),
    estado_civil NVARCHAR(255),
    edad INT
);

CREATE TABLE D_PRODUCTOS (
    sk_producto INT IDENTITY(1,1) PRIMARY KEY,
    producto_id_nk INT,
    nombre NVARCHAR(255),
    precio INT,
    categoria NVARCHAR(255)
);

CREATE TABLE D_SUCURSALES (
    sk_sucursal INT IDENTITY(1,1) PRIMARY KEY,
    sucursal_id_nk INT,
    sucursal NVARCHAR(255),
    comuna NVARCHAR(255)
);

CREATE TABLE D_EMPLEADOS (
    sk_empleado INT IDENTITY(1,1) PRIMARY KEY,
    empleado_id_nk INT,
    nombre_completo NVARCHAR(255),
    cargo NVARCHAR(255)
);

CREATE TABLE D_TIEMPO (
    sk_tiempo INT PRIMARY KEY,
    fecha DATE,
    anio INT,
    mes INT,
    dia INT
);

CREATE TABLE H_VENTAS (
    sk_cliente INT,
    sk_producto INT,
    sk_sucursal INT,
    sk_empleado INT,
    sk_tiempo INT,
    
    cantidad INT,
    precio_unitario INT,
    descuento NUMERIC(5,2),
    monto_total INT,
    
    FOREIGN KEY (sk_cliente) REFERENCES D_CLIENTES(sk_cliente),
    FOREIGN KEY (sk_producto) REFERENCES D_PRODUCTOS (sk_producto),
    FOREIGN KEY (sk_sucursal) REFERENCES D_SUCURSALES (sk_sucursal),
    FOREIGN KEY (sk_empleado) REFERENCES D_EMPLEADOS (sk_empleado),
    FOREIGN KEY (sk_tiempo) REFERENCES D_TIEMPO(sk_tiempo)
);
