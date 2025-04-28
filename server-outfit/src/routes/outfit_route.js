const express = require('express');
const router = express.Router();

const outfitController = require('../controllers/outfit_controller');

const { upload } = require('../middleware/upload');

router.post('/list', outfitController.getOutfits);
router.post('/recommendation', outfitController.getRecommendations);
router.post('/updateViews', outfitController.updateOutfitViews);
router.post('/add', upload.single('picture'), outfitController.addOutfit);

module.exports = router;