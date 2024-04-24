const express = require('express');
const createConnection = require('../configs/database.config.js'); //Import la fonction créer un lien vers un base de données
const db = createConnection('MODU'); //Créer le lien vers la base de donnée "modu"
const handler = require('../services/handler.js');

const router = express.Router();

router.get('/', (req, res) => {
	res.send({ message: 'Hello world' });
});

router.get('/users', (req, res) => {
	const query = 'SELECT * FROM `users`;';

	db.query(query, (error, results) => {
		handler.handleReponse(res, error, results);
	});
});

module.exports = router;
