
const { getPool, sql } = require('../db')

/**
 * Busca un usuario del sistema por su username.
 * Retorna credenciales + rol + datos del empleado, o null si no existe.
 */
async function findUserByUsername(username) {
    const pool   = getPool()
    const result = await pool.request()
        .input('username', sql.NVarChar(50), username)
        .query(`
            SELECT
                us.id_usuario_sistema,
                us.password_hash,
                us.activo,
                r.nombre_rol,
                u.nombre,
                u.apellidos
            FROM usuarios_sistema us
            INNER JOIN roles    r ON r.id_rol    = us.id_rol
            INNER JOIN usuarios u ON u.id_usuario = us.id_usuario
            WHERE us.username = @username
        `)

    return result.recordset[0] || null
}

module.exports = { findUserByUsername }
