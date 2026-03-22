USE InventarioTI;

CREATE TABLE roles (
    id_rol     INT PRIMARY KEY IDENTITY(1,1),
    nombre_rol NVARCHAR(50) NOT NULL UNIQUE
);

-- Roles por defecto
INSERT INTO roles (nombre_rol) VALUES
    ('admin'),
    ('usuario');
GO
