const PORT = process.env.PORT || 4000;
const HOST = '192.168.210.166';
const BASE_URL = `http://${HOST}:${PORT}`;
const PICTURE_URL = `${BASE_URL}/uploads/`;

module.exports = { PORT, HOST, BASE_URL, PICTURE_URL };