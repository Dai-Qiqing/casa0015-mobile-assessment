const express = require('express');
const router = express.Router();

const recordController = require('../controllers/record_controller');

router.get('/list', recordController.getRecords);
router.get('/date', recordController.getRecordDates);
router.post('/add', recordController.addRecord);

module.exports = router;