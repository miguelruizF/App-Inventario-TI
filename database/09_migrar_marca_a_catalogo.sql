USE InventarioTI;
GO

-- ============================================================
-- Migración: pasar activos.marca (texto) a activos.id_marca (FK)
-- Ejecutar solo si ya tienes la BD con la estructura antigua.
-- ============================================================

-- 1. Crear tabla marcas si no existe
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'marcas')
BEGIN
    CREATE TABLE marcas (
        id_marca INT PRIMARY KEY IDENTITY(1,1),
        nombre_marca NVARCHAR(50) NOT NULL UNIQUE
    );
    PRINT 'Tabla marcas creada.';
END
ELSE
    PRINT 'Tabla marcas ya existe.';
GO

-- 2. Si activos tiene la columna "marca" (estructura antigua), migrar datos
IF COL_LENGTH('activos', 'marca') IS NOT NULL
BEGIN
    -- 2.1 Insertar en marcas los valores distintos de activos.marca (evitar duplicados)
    INSERT INTO marcas (nombre_marca)
    SELECT DISTINCT LTRIM(RTRIM(marca))
    FROM activos
    WHERE marca IS NOT NULL AND LTRIM(RTRIM(marca)) <> ''
    AND NOT EXISTS (SELECT 1 FROM marcas m WHERE m.nombre_marca = LTRIM(RTRIM(activos.marca)));

    PRINT 'Catálogo marcas actualizado con valores de activos.';

    -- 2.2 Añadir columna id_marca si no existe
    IF COL_LENGTH('activos', 'id_marca') IS NULL
    BEGIN
        ALTER TABLE activos ADD id_marca INT NULL;
        PRINT 'Columna id_marca añadida a activos.';
    END

    -- 2.3 Rellenar id_marca según el nombre de marca
    UPDATE a
    SET a.id_marca = m.id_marca
    FROM activos a
    INNER JOIN marcas m ON m.nombre_marca = LTRIM(RTRIM(a.marca))
    WHERE a.marca IS NOT NULL AND LTRIM(RTRIM(a.marca)) <> '';

    PRINT 'activos.id_marca actualizado.';

    -- 2.4 Crear FK a marcas si no existe
    IF NOT EXISTS (
        SELECT 1 FROM sys.foreign_keys
        WHERE parent_object_id = OBJECT_ID('activos')
        AND name = 'FK_activos_marcas'
    )
    BEGIN
        ALTER TABLE activos
        ADD CONSTRAINT FK_activos_marcas
        FOREIGN KEY (id_marca) REFERENCES marcas(id_marca);
        PRINT 'FK activos -> marcas creada.';
    END

    -- 2.5 Eliminar la columna antigua marca
    ALTER TABLE activos DROP COLUMN marca;
    PRINT 'Columna activos.marca eliminada.';
END
ELSE
    PRINT 'activos no tiene columna marca (ya migrado o estructura nueva).';
GO
