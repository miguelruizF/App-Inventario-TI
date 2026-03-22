USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'InventarioTI')
    CREATE DATABASE InventarioTI;
GO

USE InventarioTI;
GO

-- ============================================================
-- departamentos
-- ============================================================
CREATE TABLE departamentos (
    id_departamento     INT          PRIMARY KEY IDENTITY(1,1),
    nombre_departamento NVARCHAR(100) NOT NULL
);
GO

-- ============================================================
-- roles
-- ============================================================
CREATE TABLE roles (
    id_rol     INT          PRIMARY KEY IDENTITY(1,1),
    nombre_rol NVARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO roles (nombre_rol) VALUES
    ('admin'),
    ('usuario');
GO

-- ============================================================
-- usuarios
-- ============================================================
CREATE TABLE usuarios (
    id_usuario      INT          PRIMARY KEY IDENTITY(1,1),
    numero_sap      CHAR(7)      NOT NULL UNIQUE,
    nombre          NVARCHAR(100) NOT NULL,
    apellidos       NVARCHAR(150) NOT NULL,
    id_departamento INT          NOT NULL,
    correo          NVARCHAR(150),

    CONSTRAINT chk_numero_sap CHECK (LEN(numero_sap) = 7),
    FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento)
);
GO

-- ============================================================
-- usuarios_sistema
-- ============================================================
CREATE TABLE usuarios_sistema (
    id_usuario_sistema INT          PRIMARY KEY IDENTITY(1,1),
    id_usuario         INT          NOT NULL,
    username           NVARCHAR(50) NOT NULL UNIQUE,
    password_hash      NVARCHAR(255) NOT NULL,
    id_rol             INT          NOT NULL,
    activo             BIT          DEFAULT 1,

    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_rol)     REFERENCES roles(id_rol)
);
GO

-- ============================================================
-- tipos_activos
-- ============================================================
CREATE TABLE tipos_activos (
    id_tipo_activo INT          PRIMARY KEY IDENTITY(1,1),
    nombre_tipo    NVARCHAR(50) NOT NULL UNIQUE
);
GO

-- ============================================================
-- estatus_activos
-- ============================================================
CREATE TABLE estatus_activos (
    id_estatus     INT          PRIMARY KEY IDENTITY(1,1),
    nombre_estatus NVARCHAR(50) NOT NULL UNIQUE
);
GO

-- ============================================================
-- marcas
-- ============================================================
CREATE TABLE marcas (
    id_marca     INT          PRIMARY KEY IDENTITY(1,1),
    nombre_marca NVARCHAR(50) NOT NULL UNIQUE
);
GO

-- ============================================================
-- activos
-- ============================================================
CREATE TABLE activos (
    id_activo      INT           PRIMARY KEY IDENTITY(1,1),
    numero_serie   NVARCHAR(100) NOT NULL UNIQUE,
    id_marca       INT           NULL,
    modelo         NVARCHAR(50),
    id_tipo_activo INT           NOT NULL,
    id_estatus     INT           NOT NULL,
    id_usuario     INT,
    observaciones  NVARCHAR(255),

    FOREIGN KEY (id_marca)       REFERENCES marcas(id_marca),
    FOREIGN KEY (id_tipo_activo) REFERENCES tipos_activos(id_tipo_activo),
    FOREIGN KEY (id_estatus)     REFERENCES estatus_activos(id_estatus),
    FOREIGN KEY (id_usuario)     REFERENCES usuarios(id_usuario)
);
GO

-- ============================================================
-- historial_asignaciones
-- ============================================================
CREATE TABLE historial_asignaciones (
    id_asignacion    INT      PRIMARY KEY IDENTITY(1,1),
    id_activo        INT      NOT NULL,
    id_usuario       INT      NOT NULL,
    fecha_asignacion DATETIME NOT NULL DEFAULT GETDATE(),
    fecha_devolucion DATETIME NULL,
    observaciones    NVARCHAR(255),

    FOREIGN KEY (id_activo)  REFERENCES activos(id_activo),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
GO

-- ============================================================
-- Índices
-- ============================================================
CREATE NONCLUSTERED INDEX IX_usuarios_id_departamento ON usuarios(id_departamento);
CREATE NONCLUSTERED INDEX IX_activos_id_marca          ON activos(id_marca);
CREATE NONCLUSTERED INDEX IX_activos_id_tipo_activo    ON activos(id_tipo_activo);
CREATE NONCLUSTERED INDEX IX_activos_id_estatus        ON activos(id_estatus);
CREATE NONCLUSTERED INDEX IX_activos_id_usuario        ON activos(id_usuario);
CREATE NONCLUSTERED INDEX IX_historial_id_activo       ON historial_asignaciones(id_activo);
CREATE NONCLUSTERED INDEX IX_historial_id_usuario      ON historial_asignaciones(id_usuario);
GO

PRINT 'Schema creado correctamente.';
