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

/**
 * FOODS
 */

router.get('/foods', (req, res) => {
	const query = 'SELECT * FROM `foods`;';

	db.query(query, (error, results) => {
		handler.handleReponse(res, error, results);
	});
});

router.get('/foods/:type', (req, res) => {
	const query = 'SELECT * FROM `foods` WHERE type = ?;';
	const type = req.params.type;

	db.query(query, [type], (error, results) => {
		handler.handleReponse(res, error, results);
	});
});

router.get('/food/:id', (req, res) => {
	const query = 'SELECT * FROM `foods` WHERE id = ?;';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
});

/**
 * DAYS
 */

router.get('/days/:id', (req, res) => {
	const query = 'SELECT * FROM `days` WHERE id_user = ?;';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
});

router.get('/day/:id', (req, res) => {
	const query = 'SELECT * FROM `days` WHERE id = ?;';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
});

/**
 * MEALS
 */

router.get('/meals/:id', (req, res) => {
	const query = 'SELECT * FROM `meals` WHERE id_day = ?;';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
});

router.get('/meal/:id', (req, res) => {
	const query = 'SELECT * FROM `meals` WHERE id = ?;';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
});

/**
 * workouts
 */

router.get('/workouts/:id', (req, res) => {
	const query = 'SELECT * FROM `workouts` WHERE id_day = ?;';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
});

router.get('/workout/:id', (req, res) => {
	const query = 'SELECT * FROM `workouts` WHERE id = ?;';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
});

module.exports = router;
