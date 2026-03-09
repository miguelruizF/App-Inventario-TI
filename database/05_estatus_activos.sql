USE InventarioTI;

CREATE TABLE estatus_activos (
    id_estatus INT PRIMARY KEY IDENTITY(1,1),
    nombre_estatus NVARCHAR(50) NOT NULL UNIQUE
);