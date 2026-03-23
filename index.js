const { app } = require('electron')
const { connectDB } = require('./database/db')
const { createLoginWindow } = require('./src/main/windows')
const { registerAuthHandlers } = require('./src/main/ipc/auth.ipc')

app.whenReady().then(async () => {
    await connectDB()
    registerAuthHandlers()
    createLoginWindow()
})

app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') app.quit()
})
