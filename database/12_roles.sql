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

-- Modificar la tabla usuarios para incluir el hash de la contraseña, el rol y el estado activo
ALTER TABLE usuarios
ADD password_hash NVARCHAR(255) NOT NULL,
    id_rol INT NOT NULL,
    activo BIT DEFAULT 1;

-- Establecer la relación entre usuarios y roles
ALTER TABLE usuarios
ADD CONSTRAINT fk_usuario_rol
FOREIGN KEY (id_rol)
REFERENCES roles(id_rol);