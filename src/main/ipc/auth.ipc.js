const { ipcMain } = require('electron')
const bcrypt = require('bcrypt')
const { findUserByUsername } = require('../../../database/queries/auth.queries')
const { createDashboardWindow } = require('../windows')

function registerAuthHandlers() {

    ipcMain.handle('auth:login', async (event, { username, password }) => {
        try {
            const user = await findUserByUsername(username)

            if (!user)
                return { success: false, message: 'Usuario o contraseña incorrectos' }

            if (!user.activo)
                return { success: false, message: 'Usuario inactivo. Contacta al administrador' }

            const valid = await bcrypt.compare(password, user.password_hash)
            if (!valid)
                return { success: false, message: 'Usuario o contraseña incorrectos' }

            createDashboardWindow()
            return { success: true }

        } catch (err) {
            console.error('Error en auth:login:', err)
            return { success: false, message: 'Error de conexión con el servidor' }
        }
    })

    ipcMain.handle('auth:logout', async () => {
        // El cierre de ventana es manejado por el renderer llamando window.close()
        return { success: true }
    })

}

module.exports = { registerAuthHandlers }
