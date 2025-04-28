const { DatabaseAdapter } = require('../database/db');
const { PICTURE_URL } = require('../config/env');

class FavoriteController {
    // 获取收藏列表
    async getFavorites(req, res) {
        try {
            const { userId } = req.query;

            const favorites = await DatabaseAdapter.query(`
                SELECT 
                    f.id,
                    o.name,
                    o.description,
                    o.views,
                    o.picture,
                    o.category,
                    Date(f.update_at) AS update_at
                FROM favorite f
                JOIN outfit o ON f.outfit_id = o.id
                WHERE user_id = ?
                `,
                [userId]
            );

            console.log('Found favorites:', favorites.length);

            const results = favorites.map(row => {
                return {
                    ...row,
                    picture: `${PICTURE_URL}${row.picture}`,
                };
            });

            res.json({
                code: 200,
                message: '获取收藏列表成功',
                data: results
            });
        } catch (error) {
            console.error('获取收藏列表过程发生错误:', error);
            res.status(500).json({
                code: 500,
                message: error.message || '获取收藏列表失败',
                details: process.env.NODE_ENV === 'development' ? error.toString() : undefined
            });
        }
    }

    // 删除收藏
    async deleteFavorites(req, res) {
        try {
            const { userId, ids } = req.body;

            let sql = `DELETE FROM favorite WHERE user_id = ?`;
            let values = [userId];

            if (ids && ids.length > 0) {
                // 转换 ids 数组为 SQL 中 IN 子句的格式
                const placeholders = ids.map(() => '?').join(', ')
                sql += ` AND id IN (${placeholders})`;
                values = [userId, ...ids];
            }

            await DatabaseAdapter.query(sql, values);

            res.json({
                code: 200,
                message: '删除收藏成功'
            });
        } catch (error) {
            console.error('删除收藏过程发生错误:', error);
            res.status(500).json({
                code: 500,
                message: error.message || '删除收藏失败',
                details: process.env.NODE_ENV === 'development' ? error.toString() : undefined
            });
        }
    }

    // 新增收藏
    async addFavorite(req, res) {
        try {
            const { userId, outfitId } = req.body;

            // 先查询是否已经存在该收藏
            const existingFavorite = await DatabaseAdapter.query(`
                SELECT * FROM favorite
                WHERE user_id = ? AND outfit_id = ?
                `,
                [userId, outfitId]
            );

            if (existingFavorite.length > 0) {
                // 如果已存在，则删除该收藏记录
                await DatabaseAdapter.query(`
                    DELETE FROM favorite 
                    WHERE user_id = ? AND outfit_id = ?
                    `,
                    [userId, outfitId]
                );

                res.json({
                    code: 200,
                    message: '取消收藏成功'
                });
            } else {
                await DatabaseAdapter.query(`
                    INSERT INTO favorite (user_id, outfit_id)
                    VALUES (?, ?)
                    `,
                    [userId, outfitId]
                );

                res.json({
                    code: 200,
                    message: '添加收藏成功'
                });
            }
        } catch (error) {
            console.error('添加收藏过程发生错误:', error);
            res.status(500).json({
                code: 500,
                message: error.message || '添加收藏失败',
                details: process.env.NODE_ENV === 'development' ? error.toString() : undefined
            });
        }
    }
}

module.exports = new FavoriteController();
