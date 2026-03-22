/**
 * generate-hash.js
 * Genera un hash bcrypt y lo escribe en database/deploy/02_seed.sql
 *
 * Uso:
 *   node scripts/generate-hash.js <password>
 *
 * Ejemplo:
 *   node scripts/generate-hash.js MiPassword123!
 */

const bcrypt = require('bcrypt');
const fs     = require('fs');
const path   = require('path');

const SEED_FILE    = path.join(__dirname, '..', 'database', 'deploy', '02_seed.sql');
const SALT_ROUNDS  = 10;
const PLACEHOLDER  = 'REEMPLAZAR_CON_HASH_BCRYPT';

const password = process.argv[2];

if (!password) {
    console.error('ERROR: Debes proporcionar una contraseña.');
    console.error('Uso: node scripts/generate-hash.js <password>');
    process.exit(1);
}

(async () => {
    const hash = await bcrypt.hash(password, SALT_ROUNDS);

    // Leer el archivo seed
    let content = fs.readFileSync(SEED_FILE, 'utf8');

    if (!content.includes(PLACEHOLDER)) {
        console.warn('AVISO: El placeholder no fue encontrado en 02_seed.sql.');
        console.warn('Es posible que ya haya sido reemplazado anteriormente.');
        console.log('\nHash generado (reemplázalo manualmente si es necesario):');
        console.log(hash);
        process.exit(0);
    }

    // Reemplazar el placeholder con el hash real
    content = content.replace(PLACEHOLDER, hash);
    fs.writeFileSync(SEED_FILE, content, 'utf8');

    console.log('Hash generado e insertado en database/deploy/02_seed.sql');
    console.log('Hash:', hash);
})();
