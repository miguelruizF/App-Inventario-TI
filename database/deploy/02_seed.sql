USE InventarioTI;
GO

-- ============================================================
-- Departamentos
-- Ajusta según los departamentos de tu empresa
-- ============================================================
INSERT INTO departamentos (nombre_departamento) VALUES
    ('Tecnologías de la Información'),
    ('Recursos Humanos'),
    ('Contabilidad'),
    ('Administración'),
    ('Ventas'),
    ('Operaciones');
GO

-- ============================================================
-- Tipos de activos
-- ============================================================
INSERT INTO tipos_activos (nombre_tipo) VALUES
    ('Laptop'),
    ('Desktop'),
    ('Monitor'),
    ('Impresora'),
    ('Teléfono IP'),
    ('Tablet'),
    ('Servidor'),
    ('Switch'),
    ('Router'),
    ('UPS'),
    ('Teclado'),
    ('Mouse'),
    ('Headset'),
    ('Proyector'),
    ('Scanner');
GO

-- ============================================================
-- Estatus de activos
-- ============================================================
INSERT INTO estatus_activos (nombre_estatus) VALUES
    ('Activo'),
    ('En reparación'),
    ('De baja'),
    ('En almacén');
GO

-- ============================================================
-- Marcas
-- ============================================================
INSERT INTO marcas (nombre_marca) VALUES
    ('HP'),
    ('Apple'),
    ('Samsung'),
    ('Cisco'),
    ('Logitech'),
    ('Microsoft');
GO

-- ============================================================
-- Usuario administrador inicial
-- IMPORTANTE: Reemplaza '$2b$10$Fz/9C1lJoywJjNsb0V0KleT0e9Rczw5DC8xOQNkaZv8y51RHj27Ka' con un
-- hash bcrypt real antes de ejecutar en producción.
-- Genera el hash con: bcrypt.hash('TuPassword', 10)
-- ============================================================
INSERT INTO usuarios (numero_sap, nombre, apellidos, id_departamento, correo)
VALUES ('0000001', 'Administrador', 'Sistema', 1, 'admin@empresa.com');

INSERT INTO usuarios_sistema (id_usuario, username, password_hash, id_rol, activo)
VALUES (
    (SELECT id_usuario FROM usuarios WHERE numero_sap = '0000001'),
    'admin',
    '$2b$10$Fz/9C1lJoywJjNsb0V0KleT0e9Rczw5DC8xOQNkaZv8y51RHj27Ka',  -- <-- reemplaza esto
    (SELECT id_rol FROM roles WHERE nombre_rol = 'admin'),
    1
);
GO

PRINT 'Seed completado correctamente.';
