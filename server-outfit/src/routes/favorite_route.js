const express = require('express');
const router = express.Router();

const favoriteController = require('../controllers/favorite_controller');

router.get('/list', favoriteController.getFavorites);
router.post('/delete', favoriteController.deleteFavorites);
router.post('/add', favoriteController.addFavorite);

module.exports = router;