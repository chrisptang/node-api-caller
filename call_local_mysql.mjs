import mysql from 'mysql2/promise';

const dbConfig = {
    host: '127.0.0.1',
    user: 'root',
    password: 'localmysql',
    database: 'local'
}

// Function to generate a random string of a specific length
function generateRandomString(length) {
    let result = '';
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    const charactersLength = characters.length;
    for (let i = 0; i < length; i++) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
}

const generateBatchInsertQuery = (rows) => {
    const values = rows.map(
        ({ name, note, amount, quantity }) =>
            `('${name}', '${note}', ${amount}, ${quantity})`
    ).join(',');

    return `INSERT INTO orders (name, note, amount, quantity) VALUES ${values};`;
};

// Function to insert rows into the 'orders' table
async function insertRows() {
    let connection = null;
    try {
        // MySQL connection configuration
        connection = await mysql.createConnection(dbConfig);

        // Connect to the MySQL server
        await connection.connect();
        console.log('Connected to MySQL server.');

        // Generate 500,000 rows of data and insert
        let rowsToInsert = [];
        for (let i = 1; i <= 500000; i++) {
            const name = `Name ${i}`;
            const note = generateRandomString(512); // Random string of length 512
            const amount = Math.random() * 10000; // Random amount between 0 and 9999
            const quantity = Math.floor(Math.random() * 100); // Random quantity between 0 and 99

            rowsToInsert.push({ name, note, amount, quantity });
            if (rowsToInsert.length >= 1000) {
                console.log(`batch insert:${rowsToInsert.length}`);
                const query = generateBatchInsertQuery(rowsToInsert);
                const result = await connection.query(query);
                console.log(`batch insert result:${result}`);
                rowsToInsert = []
            }
        }
        console.log("DONE")
    } catch (error) {
        console.error('Error inserting rows:', error);
    } finally {
        // Close the MySQL connection
        if (connection) { connection.end(); }
        console.log('MySQL connection closed.');
    }
}

// Call the insertRows function
// insertRows();

// Function to execute queries
async function executeQueries(threadName, connection) {
    for (let i = 0; i < 10 * 1; i++) {
        try {
            let start_at = new Date().getTime();
            const quantity = Math.floor(Math.random() * 99);
            const randomStr = generateRandomString(10);
            const [rows] = await connection.query(`select 
            id,name,amount,quantity,concat(name,'${randomStr}') as random_note,quantity+${quantity} as randomQuantity
            from local.orders 
            where quantity >= ${quantity} 
            order by randomQuantity desc limit ${quantity + 3}`);
            console.log(new Date(), `${threadName} - Query ${i + 1}: ${rows.length} rows returned, time cost:${new Date().getTime() - start_at}ms.`);
        } catch (error) {
            console.error(`${threadName} - Query ${i + 1} error: ${error.message}`);
        }
    }
}

// Function to start threads
async function startThreads() {
    const connections = [], threads = [];
    for (let i = 0; i < 4; i++) {
        const connection = await mysql.createConnection(dbConfig);
        const thread = executeQueries(`Thread ${i + 1}`, connection);
        connections[connections.length] = connection;
        threads[threads.length] = thread;
    }

    await Promise.all(threads);

    // Close connections after all threads have finished
    connections.forEach(async connection => {
        await connection.end();
    });

    console.log('All threads completed.');
}

// Start the threads
startThreads().catch(console.error);