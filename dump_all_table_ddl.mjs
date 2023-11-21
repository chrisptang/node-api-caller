import mysql from 'mysql2/promise';

const args = process.argv.slice(2); // Remove first two elements

// Printing the arguments
console.log(args);

// Create a MySQL connection pool
const pool_cosfo = mysql.createPool({
    host: 'mysql-8.summerfarm.net',
    port: 3307,
    user: 'dev4',
    password: 'xianmu619',
    database: 'cosfodb',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

const pool_xianmu = mysql.createPool({
    host: 'mysql-xm.summerfarm.net',
    port: 3308,
    user: 'dev4',
    password: 'xianmu619',
    database: 'xianmudb',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

// Connect to the MySQL server
async function connectToServer(pool = pool_cosfo) {
    try {
        const connection = await pool.getConnection();
        console.log('Connected to MySQL server');

        // Retrieve all tables from the cosfodb database
        const [tables] = await connection.query('SHOW TABLES');
        // console.log(`Tables in ${args && args[0] ? args[0] : "cosfodb"}:`);

        // // Print the tables' names
        let table_key = Object.keys(tables[0])[0];

        // Print the DDL for each table
        for (const table of tables) {
            const tableName = table[table_key];
            // console.log("table_key", table_key, JSON.stringify(table), tableName);
            const [ddl] = await connection.query('SHOW CREATE TABLE ??', [tableName]);
            console.log('DDL for table:', tableName);
            console.log(ddl[0]['Create Table']);
            console.log('---');
        }

        // Release the connection
        connection.release();
    } catch (err) {
        console.error('Error connecting to MySQL server:', err);
    } finally {
        // End the connection pool
        pool.end();
    }
}

// Call the function to connect to the server
connectToServer(args && args[0] === 'xianmu' ? pool_xianmu : pool_cosfo);
