const { BrowserWindow } = require('electron')
const path = require('path')

const PRELOAD = path.join(__dirname, '..', '..', 'preload.js')

let loginWindow     = null
let dashboardWindow = null

function createLoginWindow() {
    loginWindow = new BrowserWindow({
        width:     420,
        height:    520,
        resizable: false,
        webPreferences: {
            preload:          PRELOAD,
            contextIsolation: true,
            nodeIntegration:  false
        }
    })

    loginWindow.loadFile(
        path.join(__dirname, '..', 'renderer', 'login', 'login.html')
    )

    loginWindow.on('closed', () => { loginWindow = null })
}

function createDashboardWindow() {
    dashboardWindow = new BrowserWindow({
        width:     1280,
        height:    720,
        minWidth:  900,
        minHeight: 600,
        webPreferences: {
            preload:          PRELOAD,
            contextIsolation: true,
            nodeIntegration:  false
        }
    })

    dashboardWindow.loadFile(
        path.join(__dirname, '..', 'renderer', 'dashboard', 'dashboard.html')
    )

    dashboardWindow.on('closed', () => { dashboardWindow = null })

    // Cerrar la ventana de login al abrir el dashboard
    if (loginWindow) loginWindow.close()
}

module.exports = { createLoginWindow, createDashboardWindow }
