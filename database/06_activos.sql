USE InventarioTI;

CREATE TABLE activos (
    id_activo INT PRIMARY KEY IDENTITY(1,1),
    numero_serie NVARCHAR(100) NOT NULL UNIQUE,
    marca NVARCHAR(50),
    modelo NVARCHAR(50),
    id_tipo_activo INT NOT NULL,
    id_estatus INT NOT NULL,
    id_usuario INT,
    observaciones NVARCHAR(255),

    FOREIGN KEY (id_tipo_activo) REFERENCES tipos_activos(id_tipo_activo),
    FOREIGN KEY (id_estatus) REFERENCES estatus_activo(id_estatus),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);