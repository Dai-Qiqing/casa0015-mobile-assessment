-- 用户表
CREATE TABLE IF NOT EXISTS user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 穿搭表
CREATE TABLE IF NOT EXISTS outfit (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name TEXT,
    description TEXT,
    views INT NOT NULL,
    picture TEXT NOT NULL,
    category TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- 插入 6 条默认数据
INSERT INTO outfit (name, description, views, picture, category) 
VALUES
  ('Hat', "This stylish retro baseball cap is designed to be simple and versatile, suitable for both men and women to wear on a daily basis.", 0, 'hat.png', 'Comprehensive'),
  ('Winter Outfit', 'Pink woolen hat and beige trench coat, paired with a gray hooded sweatshirt, exuding a warm winter vibe', 0, 'winter_outfit.png', 'Winter Outfit'),
  ('Sporty Outfit', 'The combination of short skirt and trench coat, paired with high boots and sunglasses, showcases a sleek urban sports style.', 0, 'sporty_outfit.png', 'Sports Outfit'),
  ('Summer Outfits', 'Blue collar top, combining comfort and fashion, perfectly suited for beach vacations', 0, 'summer_outfits.png', 'Casual'),
  ('Ress', "A striped dress, paired with white sneakers and a light colored hat, showcases a relaxed and playful summer look.", 0, 'ress.png', 'Elegant Summer Outfits'),
  ('White Sweate', 'light-colored jeans', 0, 'white_sweate.png', 'Fashionable Casual Wear');

-- 收藏表
CREATE TABLE IF NOT EXISTS favorite (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    outfit_id INT NOT NULL,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 浏览历史表
CREATE TABLE IF NOT EXISTS record (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    outfit_id INT NOT NULL,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

