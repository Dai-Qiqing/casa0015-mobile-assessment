const fs = require('fs').promises;
const path = require('path');
const { DatabaseAdapter } = require('./db');

class DatabaseInitializer {
  constructor() {
    this.sqlsPath = path.join(__dirname, './sql');
  }

  // 读取 SQL 文件
  async readSqlFiles() {
    try {
      const files = await fs.readdir(this.sqlsPath);
      const sqlFiles = files.filter(file => file.endsWith('.sql'));

      const allSqls = [];
      for (const file of sqlFiles) {
        const content = await fs.readFile(path.join(this.sqlsPath, file), 'utf8');
        const statements = content
          .split(';')
          .map(statement => statement.trim())
          .filter(statement => statement.length > 0);
        allSqls.push(...statements);
      }
      return allSqls;
    } catch (error) {
      console.error('读取 SQL 文件失败:', error);
      throw error;
    }
  }

  // 清理数据库
  async cleanDatabase() {
    const tables = [
      'user',
      'clothing',
      'outfit',
      'favorite',
      'record'
    ];

    for (const table of tables) {
      try {
        await DatabaseAdapter.query(`DROP TABLE IF EXISTS ${table}`);
        console.log(`表 ${table} 已删除`);
      } catch (error) {
        console.error(`删除表 ${table} 失败:`, error);
      }
    }
  }

  // 初始化数据库
  async initializeDatabase() {
    try {
      const sqlStatements = await this.readSqlFiles();
      for (const sql of sqlStatements) {
        try {
          await DatabaseAdapter.query(sql);
          console.log('执行 SQL 成功:', sql.substring(0, 50) + '...');
        } catch (error) {
          console.error('执行 SQL 失败:', error);
          throw error;
        }
      }
      console.log('数据库初始化完成');
    } catch (error) {
      console.error('数据库初始化失败:', error);
      throw error;
    }
  }

  // 重置数据库
  async resetDatabase() {
    try {
      console.log('开始重置数据库...');
      await this.cleanDatabase();
      console.log('数据库清理完成，开始重新初始化...');
      await this.initializeDatabase();
      console.log('数据库重置完成');
    } catch (error) {
      console.error('数据库重置失败:', error);
      throw error;
    }
  }
}

module.exports = new DatabaseInitializer(); 