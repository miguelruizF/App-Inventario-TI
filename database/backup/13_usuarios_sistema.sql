USE InventarioTI;

CREATE TABLE usuarios_sistema (

    id_usuario_sistema INT PRIMARY KEY IDENTITY(1,1),

    id_usuario INT NOT NULL,

    username NVARCHAR(50) NOT NULL UNIQUE,

    password_hash NVARCHAR(255) NOT NULL,

    id_rol INT NOT NULL,

    activo BIT DEFAULT 1,

    FOREIGN KEY (id_usuario)
    REFERENCES usuarios(id_usuario),

    FOREIGN KEY (id_rol)
    REFERENCES roles(id_rol)

);