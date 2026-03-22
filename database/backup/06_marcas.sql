USE InventarioTI;

CREATE TABLE marcas (
    id_marca INT PRIMARY KEY IDENTITY(1,1),
    nombre_marca NVARCHAR(50) NOT NULL UNIQUE
);
