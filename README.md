# Certamen 2 Inteligencia de Negocios - Fase 1

## Caso seleccionado
Mueblería Albarrán - CASO 1

## Integrantes y sección
* Yamandú Lettieri - 300

## Descripción del problema
Actualmente, la información de la Mueblería Albarrán se genera y almacena en sistemas transaccionales orientados a la operación diaria. Como estos sistemas por lo general guardan solo datos vigentes y no están estructurados para el análisis, la gerencia tiene dificultades para cruzar datos, generar reportes ágiles y tomar decisiones informadas sobre ventas, sucursales y desempeño de productos.

## Objetivo del proyecto
Construir una solución de Inteligencia de Negocios aplicando el enfoque Bottom-Up (Data Mart) presentado por Ralph Kimball. Mediante un proceso de Extracción, Transformación y Carga (ETL), se organizará la información en un modelo dimensional tipo Estrella. Este esquema desnormalizado optimizará la velocidad de consulta y estructurará los datos de manera integrada y variante en el tiempo para apoyar directamente el proceso de toma de decisiones.

## KPI definidos
1. **Ingresos Totales por Sucursal:** Permite identificar las sucursales con mayor rentabilidad.
2. **Ticket Promedio de Venta:** Mide el gasto promedio por transacción para evaluar el impacto de las ventas cruzadas de los empleados.
3. **Volumen de Ventas por Categoría de Producto:** Ayuda a identificar productos de alta rotación para optimizar el inventario.

## Modelo dimensional
Se aplicaron las cuatro actividades clásicas del modelamiento dimensional:

### Proceso de negocio
El proceso de negocio seleccionado es la **Venta** al detalle de la Mueblería Albarrán.

### Granularidad
El nivel de detalle establecido corresponde a **una línea de producto vendido** dentro de una transacción, permitiendo el mayor nivel de detalle posible para posteriores sumarizaciones.

### Dimensiones
Dimensiones definidas para filtrar o agrupar las medidas:
* `D_CLIENTES`: Indica quién es el destinatario de la actividad (sexo, estado civil, edad).
* `D_PRODUCTOS`: Indica cuál es el objeto de la actividad (incluye categoría).
* `D_SUCURSALES`: Indica dónde se produce la actividad (incluye comuna).
* `D_EMPLEADOS`: Vendedor que realiza la transacción (incluye cargo).
* `D_TIEMPO`: Indica cuándo se produce la actividad (año, mes, día).

### Tabla de hechos y medidas
La tabla de hechos `H_VENTAS` está conformada por las claves primarias de cada dimensión (llaves subrogadas) y las siguientes métricas evaluables mediante funciones de agregación:
* `cantidad` 
* `precio_unitario`
* `descuento` 
* `monto_total` (Métrica derivada o precálculo almacenado para facilitar el análisis final)

## Proceso ETL - Fase 1
- **Herramienta:** SQL Server Integration Services (SSIS).
- **Flujo de Carga:** Extracción desde base transaccional (`Albarran`), transformación de datos (limpieza de inconsistencias y manejo de nulos), búsqueda de llaves subrogadas mediante componentes *Lookup* y carga en el Data Warehouse relacional (`Albarran_DW`).
- **Integridad:** Mantenimiento de relaciones de clave foránea y control de ejecuciones sin duplicidad.

## Cubo OLAP - Fase 2
- **Tecnología:** SQL Server Analysis Services (SSAS Multidimensional).
- **Estructura Analítica:** Importación de la Vista de Origen de Datos (DSV) en esquema estrella desde `Albarran_DW`.
- **Ajustes Técnicos Realizados:**
  - **Dimensión Tiempo:** Ajuste de propiedades `KeyColumns` (clave compuesta `Año` + `Mes` + `Día`) y `OrderBy` en `Key` para resolver la duplicidad de días entre meses y garantizar la ordenación cronológica.
  - **Jerarquías Analíticas:** Implementación de la jerarquía de tiempo `Anio -> Mes -> Dia` para permitir exploración mediante desgloses (*drill-down*). También se hizo lo mismo con `Comuna -> Sucursal` para exploración geográfica.
  - **Métricas de Negocio:** Creación e integración directa de la medida calculada `[Ticket Promedio]`, garantizando la consistencia matemática al consultar agregaciones superiores.

## Dashboard Power BI - Fase 2
- **Modo de Conexión:** *Live Connection* (Conexión directa en vivo al Cubo OLAP desplegado en SSAS).
- **Componentes Visuales:**
  - Tarjetas de KPI gerenciales (Monto Total, Cantidad Vendida y Ticket Promedio).
  - Gráficos interactivos de ingresos por sucursal y volumen por categoría.
  - Segmentadores jerárquico por **Año**, **Mes** y **Día** para filtrado temporal instantáneo.
- **Ventaja Técnica:** Cero carga de procesamiento local en Power BI; las consultas y agregaciones se resuelven en el motor OLAP de SSAS.

## Tecnologías utilizadas
- **SQL Server Management Studio (SSMS):** Motor de base de datos relacional y Data Warehouse.
- **Visual Studio (SSIS & SSAS):** Desarrollo del paquete ETL y modelado del cubo multidimensional OLAP.
- **Power BI Desktop:** Diseño del panel de control e integración mediante *Live Connection*.
- **Git / GitHub:** Control de versiones y alojamiento del proyecto.

## Estructura del repositorio
```
CERTAMEN2-BI/
├── README.md
├── docs/
│   └── modelo-dimiensional/
│       └── modelo_estrella_diagrama.png
│   └── presentacion/
│       └── presentación-fase1.pptx
│       └── presentación-fase2.pptx
├── database/
│   ├── scripts/
│   │   └── modelo_dimensional.sql
│   └── backup/
│       └── Albarran_DW.bak
│       └── Albarran.bak
├── etl/
│   └── proyecto-ssis/
│       └── ETL_Albarran/
├── olap/
│   └── proyecto-ssas/
├── powerbi/
    └── powerbi/dashboard.pbix

```



## Instrucciones de ejecución/revisión
1. Restaurar el archivo `.bak` incluido en la carpeta `database/backup/`.
2. Ejecutar el script de creación del modelo dimensional ubicado en `database/scripts/`.
3. Abrir la solución `.sln` en Visual Studio y ejecutar el paquete `Package.dtsx` para iniciar la carga ETL.
4. Abrir la solución de Analysis Services en Visual Studio (`olap/proyecto-ssas/`), configurar el servidor de destino, realizar el despliegue  y procesar completamente.
5. Abrir el archivo `dashboard.pbix` en Power BI Desktop, asegurando que la conexión en vivo (*Live Connection*) apunte correctamente al servidor SSAS local desplegado.

## Distribución de responsabilidades y aportes
* **Yamandú Lettieri:** Todo :)))
