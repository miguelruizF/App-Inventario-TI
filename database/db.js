const sql = require('mssql')
const bcrypt = require('bcrypt')

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

let pool = null

async function connectDB() {
    try {
        pool = await sql.connect(config)
        console.log('Conexion exitosa a SQL Server')
    } catch (err) {
        console.error('Error de conexion:', err)
        throw err
    }
}

function getPool() {
    if (!pool) throw new Error('Base de datos no conectada')
    return pool
}

module.exports = { connectDB, getPool, sql }
//bcrypt.hash('mortal_12', 10).then(hash => console.log(hash));

//module.exports = { connectDB } 