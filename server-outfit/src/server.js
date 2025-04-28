const express = require('express');
const cors = require('cors');
const path = require('path');
const databaseInitializer = require('./database/db_initializer');
const authRoutes = require('./routes/auth_route');
const outfitRoutes = require('./routes/outfit_route');
const recordRoutes = require('./routes/record_route');
const favoriteRoutes = require('./routes/favorite_route');
const bodyParser = require('body-parser');
const { DB_TYPE } = require('./database/db');
const { PORT, HOST, BASE_URL } = require('./config/env');

const app = express();

app.use(cors());
app.use(express.json());
// 使用 body-parser 解析请求体
app.use(bodyParser.json());

// 添加数据库重置路由（仅在开发环境使用）
if (process.env.NODE_ENV === 'development') {
    app.post('/api/database/reset', async (req, res) => {
        try {
            await databaseInitializer.resetDatabase();
            res.json({ message: '数据库重置成功' });
        } catch (error) {
            res.status(500).json({ error: '数据库重置失败' });
        }
    });
}

// 初始化数据库
databaseInitializer.initializeDatabase().then(() => {
    console.log(`数据库 ${DB_TYPE} 初始化完成`);
}).catch(err => {
    console.error('数据库初始化失败:', err);
    process.exit(1);
});

app.use('/api/auth', authRoutes);
app.use('/api/outfit', outfitRoutes);
app.use('/api/record', recordRoutes);
app.use('/api/favorite', favoriteRoutes);
// 提供图片文件访问
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

app.listen(PORT, HOST, () => {
    console.log(`服务器运行在 ${BASE_URL}`);
});