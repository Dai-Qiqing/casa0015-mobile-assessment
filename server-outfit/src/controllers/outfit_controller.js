const { DatabaseAdapter } = require('../database/db');
const { PICTURE_URL } = require('../config/env');
const recordController = require('./record_controller');

class OutfitController {
    // 穿搭列表
    async getOutfits(req, res) {
        try {
            const { userId, key, category } = req.body;

            const keyFilter = key ?? null;
            const categoryFilter = category ?? null;

            const outfits = await DatabaseAdapter.query(`
                SELECT 
                    o.id,
                    o.name,
                    o.description,
                    o.views,
                    o.picture,
                    o.category,
                    CASE 
                        WHEN f.id IS NULL THEN 0
                        ELSE 1
                    END AS favorite,
                    o.created_at,
                    o.update_at
                FROM 
                    outfit o
                LEFT JOIN 
                    favorite f ON o.id = f.outfit_id AND f.user_id = ?
                WHERE 
                (? IS NULL OR (name LIKE CONCAT('%', ?, '%') OR description LIKE CONCAT('%', ?, '%')))
                AND (? IS NULL OR category = ?)
                `, [userId, keyFilter, keyFilter, keyFilter, categoryFilter, categoryFilter]);

            console.log('Found outfits:', outfits.length);

            const results = outfits.map(row => {
                return {
                    ...row,
                    picture: `${PICTURE_URL}${row.picture}`,
                };
            });

            res.json({
                code: 200,
                message: '获取穿搭列表成功',
                data: results
            });
        } catch (error) {
            console.error('获取穿搭列表过程发生错误:', error);
            res.status(500).json({
                code: 500,
                message: error.message || '获取穿搭列表失败',
                details: process.env.NODE_ENV === 'development' ? error.toString() : undefined
            });
        }
    }

    // 推荐穿搭
    async getRecommendations(req, res) {
        try {
            const { userId } = req.body;

            const recommendations = await DatabaseAdapter.query(`
                SELECT 
                    o.id,
                    o.name,
                    o.description,
                    o.views,
                    o.picture,
                    o.category,
                    CASE 
                        WHEN f.id IS NULL THEN 0
                        ELSE 1
                    END AS favorite,
                    o.created_at,
                    o.update_at
                FROM 
                    outfit o
                LEFT JOIN 
                    favorite f ON o.id = f.outfit_id AND f.user_id = ?
                ORDER BY o.views DESC;
            `,
                [userId]
            );

            console.log('Found recommendations:', recommendations.length);

            const results = recommendations.map(row => {
                return {
                    ...row,
                    picture: `${PICTURE_URL}${row.picture}`,
                };
            });

            res.json({
                code: 200,
                message: '获取热门搭配列表成功',
                data: results
            });
        } catch (error) {
            console.error('获取热门搭配列表过程发生错误:', error);
            res.status(500).json({
                code: 500,
                message: error.message || '获取热门搭配列表失败',
                details: process.env.NODE_ENV === 'development' ? error.toString() : undefined
            });
        }
    }

    // 更新浏览量
    async updateOutfitViews(req, res) {
        try {
            const { outfitId } = req.body;

            await DatabaseAdapter.query(`
                UPDATE outfit
                SET views = views + 1, update_at = CURRENT_TIMESTAMP
                WHERE id = ?
            `, [outfitId]);

            res.json({
                code: 200,
                message: '更新浏览量成功',
            });
        } catch (error) {
            console.error('更新浏览量过程发生错误:', error);
            res.status(500).json({
                code: 500,
                message: error.message || '更新浏览量失败',
                details: process.env.NODE_ENV === 'development' ? error.toString() : undefined
            });
        }
    }

    // 新增穿搭
    async addOutfit(req, res) {
        try {
            if (!req.file) {
                return res.status(400).send('请上传图片');
            }

            const imagePath = `${req.file.filename}`;

            const { userId, name, description, category } = req.body;

            const result = await DatabaseAdapter.query(`
                INSERT INTO outfit (name, description, views, picture, category) 
                VALUES (?, ?, ?, ?, ?)
            `,
                [name, description, 0, imagePath, category]
            );

            // 添加到发布历史表
            await DatabaseAdapter.query(`
                INSERT INTO record (user_id, outfit_id)
                    VALUES (?, ?)
                `,
                [userId, result.insertId]
            );

            res.json({
                code: 200,
                message: '新增穿搭成功',
            });
        } catch (error) {
            console.error('新增穿搭过程发生错误:', error);
            res.status(500).json({
                code: 500,
                message: error.message || '新增穿搭失败',
                details: process.env.NODE_ENV === 'development' ? error.toString() : undefined
            });
        }
    }
}

module.exports = new OutfitController();
