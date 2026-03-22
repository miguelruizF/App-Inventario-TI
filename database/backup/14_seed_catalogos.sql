USE InventarioTI;

-- ============================================================
-- Seed: Departamentos
-- Ajusta estos valores según los departamentos de tu empresa
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
-- Seed: Tipos de activos
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
-- Seed: Estatus de activos
-- ============================================================
INSERT INTO estatus_activos (nombre_estatus) VALUES
    ('Activo'),
    ('En reparación'),
    ('De baja'),
    ('En almacén');
GO

-- ============================================================
-- Seed: Marcas
-- ============================================================
INSERT INTO marcas (nombre_marca) VALUES
    ('HP'),
    ('Apple'),
    ('Samsung'),
    ('Cisco'),
    ('Logitech'),
    ('Microsoft');
GO
