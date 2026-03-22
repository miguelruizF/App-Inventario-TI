USE InventarioTI;

CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY IDENTITY(1,1),
    numero_sap CHAR(7) NOT NULL UNIQUE,
    nombre NVARCHAR(100) NOT NULL,
    apellidos NVARCHAR(150) NOT NULL,
    id_departamento INT NOT NULL,
    correo NVARCHAR(150),

    CONSTRAINT chk_numero_sap
    CHECK (LEN(numero_sap) = 7),

    FOREIGN KEY (id_departamento)
    REFERENCES departamentos(id_departamento)
);