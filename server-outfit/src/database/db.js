const mysql = require('mysql2/promise');

// MySQL 连接配置
const mysqlPool = mysql.createPool({
    host: 'localhost',
    //   host: '8.141.3.32',
    port: 3306,
    //   port: 33060,
    user: 'root',
    password: '12345678',
    //   password: 'admin',
    database: 'outfit'
});

class DatabaseAdapter {
    static async query(sql, params = []) {
        console.log(sql)
        const [rows] = await mysqlPool.execute(sql, params);
        return rows;
    }

    static async getConnection() {
        return await mysqlPool.getConnection();
    }

    static async transaction(callback) {
        const connection = await mysqlPool.getConnection();
        await connection.beginTransaction();

        try {
            await callback(connection);
            await connection.commit();
        } catch (error) {
            await connection.rollback();
            throw error;
        } finally {
            connection.release();
        }
    }
}

module.exports = {
    DatabaseAdapter
};
