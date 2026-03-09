const { app } = require('electron')
const { connectDB } = require('./database/db')

app.whenReady().then(() => {

    connectDB()

})