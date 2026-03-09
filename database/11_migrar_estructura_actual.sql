USE InventarioTI;
GO

-- ============================================================
-- Migration: update existing DB to new structure
-- Run this on your existing InventarioTI database.
-- ============================================================

-- -------------------------------------------------------------------
-- 1. Rename estatus_activo -> estatus_activos
-- -------------------------------------------------------------------
IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'estatus_activo')
   AND NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'estatus_activos')
BEGIN
    -- Create new table
    CREATE TABLE estatus_activos (
        id_estatus INT PRIMARY KEY IDENTITY(1,1),
        nombre_estatus NVARCHAR(50) NOT NULL UNIQUE
    );

    SET IDENTITY_INSERT estatus_activos ON;
    INSERT INTO estatus_activos (id_estatus, nombre_estatus)
    SELECT id_estatus, nombre_estatus FROM estatus_activo;
    SET IDENTITY_INSERT estatus_activos OFF;

    -- Drop FK from activos (find constraint name)
    DECLARE @fk_estatus NVARCHAR(256);
    SELECT @fk_estatus = fk.name
    FROM sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
    WHERE fk.parent_object_id = OBJECT_ID('activos') AND fkc.referenced_object_id = OBJECT_ID('estatus_activo');

    IF @fk_estatus IS NOT NULL
    BEGIN
        EXEC('ALTER TABLE activos DROP CONSTRAINT ' + @fk_estatus);
    END

    DROP TABLE estatus_activo;

    ALTER TABLE activos
    ADD CONSTRAINT FK_activos_estatus_activos
    FOREIGN KEY (id_estatus) REFERENCES estatus_activos(id_estatus);

    PRINT 'Tabla estatus_activo migrada a estatus_activos.';
END
ELSE IF EXISTS (SELECT 1 FROM sys.tables WHERE name = 'estatus_activos')
    PRINT 'estatus_activos ya existe, se omite migración de estatus.';
GO

-- -------------------------------------------------------------------
-- 2. historial_asignaciones: numero_sap -> id_usuario
-- -------------------------------------------------------------------
IF COL_LENGTH('historial_asignaciones', 'numero_sap') IS NOT NULL
BEGIN
    -- Add new column
    IF COL_LENGTH('historial_asignaciones', 'id_usuario') IS NULL
    BEGIN
        ALTER TABLE historial_asignaciones ADD id_usuario INT NULL;
    END

    -- Fill id_usuario from usuarios by numero_sap
    UPDATE h
    SET h.id_usuario = u.id_usuario
    FROM historial_asignaciones h
    INNER JOIN usuarios u ON u.numero_sap = h.numero_sap;

    -- Fail if any row has no matching user
    IF EXISTS (SELECT 1 FROM historial_asignaciones WHERE id_usuario IS NULL AND numero_sap IS NOT NULL)
    BEGIN
        RAISERROR('Hay filas en historial_asignaciones con numero_sap que no existe en usuarios. Corrige los datos antes de continuar.', 16, 1);
        RETURN;
    END

    -- Drop FK on numero_sap
    DECLARE @fk_sap NVARCHAR(256);
    SELECT @fk_sap = fk.name
    FROM sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
    WHERE fk.parent_object_id = OBJECT_ID('historial_asignaciones')
      AND COL_NAME(fkc.parent_object_id, fkc.parent_column_id) = 'numero_sap';

    IF @fk_sap IS NOT NULL
    BEGIN
        EXEC('ALTER TABLE historial_asignaciones DROP CONSTRAINT ' + @fk_sap);
    END

    ALTER TABLE historial_asignaciones DROP COLUMN numero_sap;
    ALTER TABLE historial_asignaciones ALTER COLUMN id_usuario INT NOT NULL;

    ALTER TABLE historial_asignaciones
    ADD CONSTRAINT FK_historial_asignaciones_usuarios
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario);

    PRINT 'historial_asignaciones migrado: numero_sap reemplazado por id_usuario.';
END
ELSE IF COL_LENGTH('historial_asignaciones', 'id_usuario') IS NOT NULL
    PRINT 'historial_asignaciones ya tiene id_usuario, se omite migración.';
GO

-- -------------------------------------------------------------------
-- 3. Indexes on foreign keys (create if not exists)
-- -------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_usuarios_id_departamento' AND object_id = OBJECT_ID('usuarios'))
    CREATE NONCLUSTERED INDEX IX_usuarios_id_departamento ON usuarios(id_departamento);

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_activos_id_marca' AND object_id = OBJECT_ID('activos'))
    CREATE NONCLUSTERED INDEX IX_activos_id_marca ON activos(id_marca);

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_activos_id_tipo_activo' AND object_id = OBJECT_ID('activos'))
    CREATE NONCLUSTERED INDEX IX_activos_id_tipo_activo ON activos(id_tipo_activo);

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_activos_id_estatus' AND object_id = OBJECT_ID('activos'))
    CREATE NONCLUSTERED INDEX IX_activos_id_estatus ON activos(id_estatus);

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_activos_id_usuario' AND object_id = OBJECT_ID('activos'))
    CREATE NONCLUSTERED INDEX IX_activos_id_usuario ON activos(id_usuario);

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_historial_asignaciones_id_activo' AND object_id = OBJECT_ID('historial_asignaciones'))
    CREATE NONCLUSTERED INDEX IX_historial_asignaciones_id_activo ON historial_asignaciones(id_activo);

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_historial_asignaciones_id_usuario' AND object_id = OBJECT_ID('historial_asignaciones'))
    CREATE NONCLUSTERED INDEX IX_historial_asignaciones_id_usuario ON historial_asignaciones(id_usuario);

PRINT 'Índices en claves foráneas creados o ya existían.';
GO

PRINT 'Migración de estructura completada.';
