const jwt = require('jsonwebtoken');

const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key';

function authenticateToken(req, res, next) {  
  const authHeader = req.headers['authorization'];  
  const token = authHeader && authHeader.split(' ')[1];  

  console.log('Authorization Header:', authHeader); // 调试信息  
  console.log('Token:', token); // 调试信息  

  if (!token) {  
    return res.status(401).json({ error: '未提供认证令牌' });  
  }  

  jwt.verify(token, JWT_SECRET, (err, user) => {  
    if (err) {  
      return res.status(403).json({ error: '无效的认证令牌' });  
    }  
    req.user = user;  
    next();  
  });  
}

module.exports = {
  authenticateToken
};