USE InventarioTI;

CREATE TABLE departamentos (
    id_departamento INT PRIMARY KEY IDENTITY(1,1),
    nombre_departamento NVARCHAR(100) NOT NULL
);