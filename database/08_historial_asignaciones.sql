USE InventarioTI;

CREATE TABLE historial_asignaciones (
    id_asignacion INT PRIMARY KEY IDENTITY(1,1),
    id_activo INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha_asignacion DATETIME NOT NULL DEFAULT GETDATE(),
    fecha_devolucion DATETIME NULL,
    observaciones NVARCHAR(255),

    FOREIGN KEY (id_activo) REFERENCES activos(id_activo),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);
