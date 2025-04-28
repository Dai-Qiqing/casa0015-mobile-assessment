const multer = require('multer');
const path = require('path');
const fs = require('fs');

// 配置图片上传路径和文件名
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        const uploadDir = path.join(__dirname, '../uploads');
        // 检查 uploads 目录是否存在，若不存在则创建
        if (!fs.existsSync(uploadDir)) {
            fs.mkdirSync(uploadDir);
        }
        cb(null, uploadDir); // 设置文件上传目录
    },
    filename: (req, file, cb) => {
        // 设置上传文件名
        const fileExtension = path.extname(file.originalname);
        const filename = Date.now() + fileExtension; // 文件名以时间戳为准
        cb(null, filename);
    },
});

// 设置 multer 上传中间件
const upload = multer({ storage });

module.exports = {
    upload
};
