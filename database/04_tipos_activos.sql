USE InventarioTI;

CREATE TABLE tipos_activos (
    id_tipo_activo INT PRIMARY KEY IDENTITY(1,1),
    nombre_tipo NVARCHAR(50) NOT NULL UNIQUE,
    descripcion NVARCHAR(255)
);