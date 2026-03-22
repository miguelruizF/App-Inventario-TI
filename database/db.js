const sql = require('mssql')

const config = {
    user: 'sa',
    password: 'mortal_12',
    server: '192.168.100.20',
    database: 'InventarioTI',
    options: {
        encrypt: false,
        trustServerCertificate: true
    }
}

async function connectDB() {
    try {
        await sql.connect(config)
        console.log("Conexion exitosa a SQL Server")
    } catch (err) {
        console.log("Error de conexion:", err)
    }
}

const bcrypt = require('bcrypt');
bcrypt.hash('Admin1234!', 10).then(hash => console.log(hash));

module.exports = { connectDB }