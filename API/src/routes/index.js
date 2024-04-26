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

/**
 * notes
 */

router.get('/notes/:id', (req, res) => {
	const query = 'SELECT * FROM `notes` WHERE id_user = ?;';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
});

router.get('/note/:id', (req, res) => {
	const query = 'SELECT * FROM `notes` WHERE id = ?;';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
});

router.post('/note/:id', (req, res) => {
	const id = req.params.id;
	const datas = [id, req.body.title, req.body.description];

	const query = 'INSERT INTO `notes`(`id_user`, `title`, `description`) VALUES (?, ?, ?)';

	db.query(query, datas, (error, results) => {
		handler.handleReponse(res, error, null, 'Creation succeed!');
	});
});

router.put('/note/:id', (req, res) => {
	const id = req.params.id;
	const datas = [req.body.title, req.body.description, id];

	const query = 'UPDATE te SET `title` = ?, `description` = ? WHERE `id` = ?';

	db.query(query, datas, (error, results) => {
		handler.handleReponse(res, error, null, 'Modification succeed!');
	});
});

router.delete('/note/:id', (req, res) => {
	const query = 'DELETE FROM `notes` WHERE id = ?';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, null, 'Delete succeed!');
	});
});

module.exports = router;
