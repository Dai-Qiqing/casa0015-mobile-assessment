const { DatabaseAdapter } = require('../database/db');
const { PICTURE_URL } = require('../config/env');

class RecordController {
    // 获取浏览历史列表
    async getRecords(req, res) {
        try {
            const { userId, date } = req.query;

            const records = await DatabaseAdapter.query(`
                SELECT 
                    r.id,
                    o.name,
                    o.description,
                    o.views,
                    o.picture,
                    o.category,
                    r.update_at
                FROM record r
                JOIN outfit o ON r.outfit_id = o.id
                WHERE user_id = ? AND DATE(r.update_at) = ?
                `,
                [userId, date]
            );

            console.log('Found records:', records.length);

            const results = records.map(row => {
                return {
                    ...row,
                    picture: `${PICTURE_URL}${row.picture}`,
                };
            });

            res.json({
                code: 200,
                message: '获取浏览历史列表成功',
                data: results
            });
        } catch (error) {
            console.error('获取浏览历史列表过程发生错误:', error);
            res.status(500).json({
                code: 500,
                message: error.message || '获取浏览历史列表失败',
                details: process.env.NODE_ENV === 'development' ? error.toString() : undefined
            });
        }
    }

    // 获取浏览日期列表
    async getRecordDates(req, res) {
        try {
            const { userId } = req.query;

            const dates = await DatabaseAdapter.query(`
                SELECT 
                    DATE(update_at) AS date
                FROM record
                WHERE user_id = ?
                GROUP BY DATE(update_at)
                ORDER BY DATE(update_at) DESC
                `,
                [userId]
            );

            console.log('Found dates:', dates);

            const results = dates.map(row => {
                const currentDate = new Date(row.date);
                // 获取日期部分（如：21/04/2025）
                return currentDate.toLocaleDateString('zh-CN');
            });

            res.json({
                code: 200,
                message: '获取浏览日期列表成功',
                data: results
            });
        } catch (error) {
            console.error('获取浏览日期列表过程发生错误:', error);
            res.status(500).json({
                code: 500,
                message: error.message || '获取浏览日期列表失败',
                details: process.env.NODE_ENV === 'development' ? error.toString() : undefined
            });
        }
    }

    // 增加浏览历史
    async addRecord(req, res) {
        try {
            const { userId, outfitId } = req.body;

            await DatabaseAdapter.query(`
                INSERT INTO favorite (user_id, outfit_id)
                    VALUES (?, ?)
                `,
                [userId, outfitId]
            );

            res.json({
                code: 200,
                message: '添加浏览历史成功',
            });
        } catch (error) {
            console.error('添加浏览历史过程发生错误:', error);
            res.status(500).json({
                code: 500,
                message: error.message || '添加浏览历史失败',
                details: process.env.NODE_ENV === 'development' ? error.toString() : undefined
            });
        }
    }
}

module.exports = new RecordController();
