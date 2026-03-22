USE InventarioTI;

-- ============================================================
-- Seed: Usuario administrador inicial
--
-- IMPORTANTE: Reemplaza el valor de password_hash con un hash
-- bcrypt real generado por la aplicación antes de ejecutar.
-- El hash de ejemplo corresponde a la contraseña: Admin1234!
-- Cámbiala después del primer inicio de sesión.
-- ============================================================

-- 1. Insertar el empleado en la tabla usuarios
-- Ajusta numero_sap, nombre, apellidos y id_departamento según corresponda
INSERT INTO usuarios (numero_sap, nombre, apellidos, id_departamento, correo)
VALUES ('0000001', 'Administrador', 'Sistema', 1, 'admin@empresa.com');

-- 2. Crear las credenciales de acceso en usuarios_sistema
-- Reemplaza el password_hash con el generado por bcrypt en la app
INSERT INTO usuarios_sistema (id_usuario, username, password_hash, id_rol, activo)
VALUES (
    (SELECT id_usuario FROM usuarios WHERE numero_sap = '0000001'),
    'admin',
    'REEMPLAZAR_CON_HASH_BCRYPT',  -- <-- reemplaza esto
    (SELECT id_rol FROM roles WHERE nombre_rol = 'admin'),
    1
);
GO
