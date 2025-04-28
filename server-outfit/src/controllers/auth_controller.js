const { DatabaseAdapter } = require('../database/db');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key';

class AuthController {
    // 注册
    async register(req, res) {
        try {
            const { username, email, password } = req.body;

            // 参数验证
            if (!username || !email || !password) {
                console.log('注册失败: 用户名或密码为空', { username, email, password });
                return res.status(400).json({ code: 400, message: '用户名和密码不能为空' });
            }

            // 用户名格式验证
            if (username.length < 3) {
                console.log('注册失败: 用户名长度不足', { username });
                return res.status(400).json({ code: 400, message: '用户名至少需要3个字符' });
            }

            // 密码格式验证
            if (password.length < 6) {
                console.log('注册失败: 密码长度不足', { username });
                return res.status(400).json({ code: 400, message: '密码至少需要6个字符' });
            }

            // 检查用户是否已存在
            try {
                const existingUser = await DatabaseAdapter.query(
                    'SELECT id FROM user WHERE username = ?',
                    [username]
                );

                if (existingUser.length) {
                    console.log('注册失败: 用户名已存在', { username });
                    return res.status(400).json({ code: 400, message: '用户名已存在' });
                }
            } catch (error) {
                console.error('查询用户失败:', error);
                throw new Error('数据库查询失败');
            }

            // 密码加密
            let hashedPassword;
            try {
                hashedPassword = await bcrypt.hash(password, 10);
            } catch (error) {
                console.error('密码加密失败:', error);
                throw new Error('密码加密失败');
            }

            // 创建用户
            try {
                const result = await DatabaseAdapter.query(
                    'INSERT INTO user (username, email, password) VALUES (?, ?, ?)',
                    [username, email, hashedPassword]
                );

                console.log('注册成功:', { username, userId: result.insertId });

                res.status(200).json({
                    code: 200,
                    message: '注册成功',
                    data: result.insertId
                });
            } catch (error) {
                console.error('创建用户失败:', error);
                throw new Error('创建用户失败');
            }

        } catch (error) {
            console.error('注册过程发生错误:', error);
            res.status(500).json({
                code: 500,
                message: error.message || '注册失败',
                details: process.env.NODE_ENV === 'development' ? error.toString() : undefined
            });
        }
    }

    // 登录
    async login(req, res) {
        try {
            const { username, password } = req.body;

            // 查找用户
            const users = await DatabaseAdapter.query(
                'SELECT * FROM user WHERE username = ?',
                [username]
            );

            if (!users.length) {
                return res.status(401).json({ error: '用户名或密码错误' });
            }

            const user = users[0];

            // 验证密码
            const isValid = await bcrypt.compare(password, user.password);
            if (!isValid) {
                return res.status(401).json({ error: '用户名或密码错误' });
            }

            // 生成 token
            const token = jwt.sign(
                { userId: user.id, username: user.username },
                JWT_SECRET,
                { expiresIn: '24h' }
            );

            res.json({
                code: 200,
                message: '登录成功',
                data: {
                    id: user.id,
                    username: user.username,
                    email: user.email,
                    token,
                }
            });
        } catch (error) {
            res.status(500).json({ error: '登录失败' });
        }
    }
}

module.exports = new AuthController();
