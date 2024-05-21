const express = require('express');
const createConnection = require('../configs/database.config.js'); //Import la fonction créer un lien vers un base de données
const handler = require('../services/handler.js');

const router = express.Router();

router.get('/login/:pseudo', (req, res) => {
	const db = createConnection();
	const pseudo = req.params.pseudo;
	const query = 'SELECT * FROM `users` WHERE pseudo = ? LIMIT 1;';

	db.query(query, [pseudo], (error, results) => {
		handler.handleReponse(res, error, results);
	});
	db.end();
});

router.post('/signup', (req, res) => {
	const db = createConnection();
	const datas = [req.body.pseudo];

	const query = 'INSERT INTO `users`(`pseudo`) VALUES (?)';

	db.query(query, datas, (error, results) => {
		handler.handleReponse(res, error, null, 'Creation succeed!');
	});
	db.end();
});

/**
 * FOODS
 */

router.get('/foods', (req, res) => {
	const db = createConnection();
	const query = 'SELECT * FROM `foods`;';

	db.query(query, (error, results) => {
		handler.handleReponse(res, error, results);
	});
	db.end();
});

router.get('/foods/:type', (req, res) => {
	const db = createConnection();
	const query = 'SELECT * FROM `foods` WHERE type = ?;';
	const type = req.params.type;

	db.query(query, [type], (error, results) => {
		handler.handleReponse(res, error, results);
	});
	db.end();
});

router.get('/food/:id', (req, res) => {
	const db = createConnection();
	const query = 'SELECT * FROM `foods` WHERE id = ?;';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
	db.end();
});

/**
 * DAYS
 */

router.get('/days/:id', (req, res) => {
	const db = createConnection();
	const query = 'SELECT * FROM `days` WHERE id_user = ?;';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
	db.end();
});

router.get('/day/:id', (req, res) => {
	const db = createConnection();
	const query = 'SELECT * FROM `days` WHERE id = ?;';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
	db.end();
});

/**
 * MEALS
 */

router.get('/meals', (req, res) => {
	const db = createConnection();
	const datas = [req.query.id_user, req.query.the_date];
	const query = 'SELECT * FROM `meals` WHERE id_user = ? AND the_date = ?;';

	db.query(query, datas, (error, results) => {
		handler.handleReponse(res, error, results);
	});
	db.end();
});

router.get('/meal/:id', (req, res) => {
	const db = createConnection();
	const query = 'SELECT * FROM `meals` WHERE id = ?;';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
	db.end();
});

router.get('/foodsPerMeal/:id', (req, res) => {
	const db = createConnection();
	const id = req.params.id;
	const query = 'SELECT F.*, DF.quantity FROM `day_foods` as DF INNER JOIN `foods` AS F ON F.id = DF.id_food WHERE id_meal = ?;';

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
	db.end();
});

router.get('/foodsPerDay', (req, res) => {
	const db = createConnection();
	const datas = [req.query.id_user, req.query.the_date];
	const query = 'SELECT F.*, DF.quantity FROM `day_foods` as DF INNER JOIN `foods` AS F ON F.id = DF.id_food WHERE id_user = ? AND the_date = ?;';

	db.query(query, datas, (error, results) => {
		handler.handleReponse(res, error, results);
	});
	db.end();
});

/**
 * workouts
 */

router.get('/workouts', (req, res) => {
	const db = createConnection();
	const datas = [req.query.id_user, req.query.the_date];
	const query = 'SELECT * FROM `workouts` WHERE id_user = ? AND the_date = ?;';

	db.query(query, datas, (error, results) => {
		handler.handleReponse(res, error, results);
	});
	db.end();
});

router.get('/workout/:id', (req, res) => {
	const db = createConnection();
	const query = 'SELECT * FROM `workouts` WHERE id = ?;';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
	db.end();
});

router.post('/workout', (req, res) => {
	const db = createConnection();
	const datas = [req.body.start_min, req.body.duration_min, req.body.type, req.body.name, req.body.the_date, req.body.id_user];

	console.log(datas);

	const query = 'INSERT INTO `workouts`(`start_min`, `duration_min`, `type`, `name`, `the_date`, `id_user`) VALUES (?, ?, ?, ?, ?, ?)';

	db.query(query, datas, (error, results) => {
		handler.handleReponse(res, error, null, 'Creation succeed!');
	});
	db.end();
});

router.put('/workout/:id', (req, res) => {
	const db = createConnection();
	const id = req.params.id;
	const datas = [req.body.start_min, req.body.duration_min, req.body.type, req.body.name, req.body.the_date, id];

	const query = 'UPDATE `workouts` SET `start_min` = ?, `duration_min` = ?, `type` = ?, `name` = ?, `the_date` = ? WHERE `id` = ?;';

	db.query(query, datas, (error, results) => {
		handler.handleReponse(res, error, null, 'Modification succeed!');
	});
	db.end();
});

router.delete('/workout/:id', (req, res) => {
	const db = createConnection();
	const query = 'DELETE FROM `workouts` WHERE id = ?;';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, null, 'Delete succeed!');
	});
	db.end();
});

router.get('/next_workout_id', (req, res) => {
	const db = createConnection();
	const queryID = 'SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_name = "workouts" AND table_schema = "modu";';

	const queryHelp = 'SET information_schema_stats_expiry = 0;';
	db.query(queryHelp, (error, results) => {
		if (error) {
			console.error(error);
			res.status(500).json({ error: 'An error occurred \n' + error });
		} else {
			db.query(queryID, (error, results) => {
				if (error) {
					res.status(500).json({ error: 'An error occurred \n' + error });
				} else {
					res.status(200).json(results);
				}
			});
		}
	});
	db.end();
});

/**
 * notes
 */

router.get('/notes/:id', (req, res) => {
	const db = createConnection();
	const query = 'SELECT * FROM `notes` WHERE id_user = ?;';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
	db.end();
});

router.get('/note/:id', (req, res) => {
	const db = createConnection();
	const query = 'SELECT * FROM `notes` WHERE id = ?;';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
	db.end();
});

router.post('/note/:id', (req, res) => {
	const db = createConnection();
	const id = req.params.id;
	const datas = [id, req.body.title, req.body.description];

	const query = 'INSERT INTO `notes`(`id_user`, `title`, `description`) VALUES (?, ?, ?)';

	db.query(query, datas, (error, results) => {
		handler.handleReponse(res, error, null, 'Creation succeed!');
	});
	db.end();
});

router.put('/note/:id', (req, res) => {
	const db = createConnection();
	const id = req.params.id;
	const datas = [req.body.title, req.body.description, id];

	const query = 'UPDATE notes SET `title` = ?, `description` = ? WHERE `id` = ?';

	db.query(query, datas, (error, results) => {
		handler.handleReponse(res, error, null, 'Modification succeed!');
	});
	db.end();
});

router.delete('/note/:id', (req, res) => {
	const db = createConnection();
	const query = 'DELETE FROM `notes` WHERE id = ?';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, null, 'Delete succeed!');
	});
	db.end();
});

/**
 * hours
 */

router.get('/hours/:id', (req, res) => {
	const db = createConnection();
	const query = 'SELECT * FROM `hours` WHERE id_user = ?;';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
	db.end();
});

router.post('/hour/:id', (req, res) => {
	const db = createConnection();
	const id = req.params.id;
	const datas = [id, req.body.input_hour];

	const query = 'INSERT INTO `hours`(`id_user`, `input_hour`) VALUES (?, ?)';

	db.query(query, datas, (error, results) => {
		handler.handleReponse(res, error, null, 'Creation succeed!');
	});
	db.end();
});

router.delete('/hour/:id', (req, res) => {
	const db = createConnection();
	const query = 'DELETE FROM hours WHERE id_user = ? ORDER BY id DESC LIMIT 1';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, null, 'Delete succeed!');
	});
	db.end();
});

router.delete('/hours/:id', (req, res) => {
	const db = createConnection();
	const query = 'DELETE FROM `hours` WHERE id_user = ?';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, null, 'Delete succeed!');
	});
	db.end();
});

/**
 * workout_exercices
 */

router.get('/workout_exercices/:id', (req, res) => {
	const db = createConnection();
	const query = 'SELECT WE.* FROM `workout_exercices` as WE INNER JOIN `exercices` as E on E.id = WE.id_exercice WHERE WE.id_workout = ?; ';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
	db.end();
});

router.post('/workout_exercices', (req, res) => {
	const db = createConnection();
	const datas = [req.body.id_exercice, req.body.id_workout, req.body.sets_number, req.body.notes, req.body.the_order];

	const query = 'INSERT INTO `workout_exercices`(`id_exercice`, `id_workout`, `sets_number`, `notes`, `the_order`) VALUES (?, ?, ?, ?, ?)';

	db.query(query, datas, (error, results) => {
		handler.handleReponse(res, error, null, 'Creation succeed!');
	});
	db.end();
});

router.put('/workout_exercices/:id', (req, res) => {
	const db = createConnection();
	const id = req.params.id;
	const datas = [req.body.id_exercice, req.body.id_workout, req.body.sets_number, req.body.notes, req.body.the_order, id];

	const query = 'UPDATE `workout_exercices` SET `id_exercice` = ?, `id_workout` = ?, `sets_number` = ?, `notes` = ?, `the_order` = ? WHERE `id` = ?';

	db.query(query, datas, (error, results) => {
		handler.handleReponse(res, error, null, 'Modification succeed!');
	});
	db.end();
});

router.put('/workout_exercices_order/:id', (req, res) => {
	const db = createConnection();
	const id = req.params.id;
	const datas = [req.body.the_order, id];

	const query = 'UPDATE `workout_exercices` SET `the_order` = ? WHERE `id` = ?';

	db.query(query, datas, (error, results) => {
		handler.handleReponse(res, error, null, 'Modification succeed!');
	});
	db.end();
});

router.delete('/workout_exercices/:id', (req, res) => {
	const db = createConnection();
	const query = 'DELETE FROM `workout_exercices` WHERE id = ?;';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, null, 'Delete succeed!');
	});
	db.end();
});

router.get('/next_workout_exercices_id', (req, res) => {
	const db = createConnection();
	const queryID = 'SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_name = "workout_exercices" AND table_schema = "modu";';

	const queryHelp = 'SET information_schema_stats_expiry = 0;';
	db.query(queryHelp, (error, results) => {
		if (error) {
			console.error(error);
			res.status(500).json({ error: 'An error occurred \n' + error });
		} else {
			db.query(queryID, (error, results) => {
				if (error) {
					res.status(500).json({ error: 'An error occurred \n' + error });
				} else {
					res.status(200).json(results);
				}
			});
		}
	});
	db.end();
});

/**
 * sets
 */

router.get('/set/:id', (req, res) => {
	const db = createConnection();
	const query = 'SELECT * FROM `sets` WHERE id = ?; ';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
	db.end();
});

router.get('/set_exercice_workout/:id', (req, res) => {
	const db = createConnection();
	const query = 'SELECT * FROM `sets` WHERE id_workout_exercice = ?; ';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
	db.end();
});

router.post('/set', (req, res) => {
	const db = createConnection();
	const datas = [req.body.id_workout_exercice, req.body.reps_number, req.body.weight_used, req.body.feelings];

	const query = 'INSERT INTO `sets`(`id_workout_exercice`, `reps_number`, `weight_used`, `feelings`) VALUES (?, ?, ?, ?)';

	db.query(query, datas, (error, results) => {
		handler.handleReponse(res, error, null, 'Creation succeed!');
	});
	db.end();
});

router.put('/set/:id', (req, res) => {
	const db = createConnection();
	const id = req.params.id;
	const datas = [req.body.reps_number, req.body.weight_used, req.body.feelings, id];

	const query = 'UPDATE `sets` SET `reps_number` = ?, `weight_used` = ?, `feelings` = ? WHERE `id` = ?';

	db.query(query, datas, (error, results) => {
		handler.handleReponse(res, error, null, 'Modification succeed!');
	});
	db.end();
});

router.delete('/set/:id', (req, res) => {
	const db = createConnection();
	const query = 'DELETE FROM `sets` WHERE id = ?;';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, null, 'Delete succeed!');
	});
	db.end();
});

/**
 * exercices
 */

router.get('/exercices', (req, res) => {
	const db = createConnection();
	const query = 'SELECT * FROM `exercices` ORDER BY name ASC; ';

	db.query(query, (error, results) => {
		handler.handleReponse(res, error, results);
	});
	db.end();
});

router.get('/exercice/:id', (req, res) => {
	const db = createConnection();
	const query = 'SELECT * FROM `exercices` WHERE id = ?; ';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
	db.end();
});

router.post('/exercice', (req, res) => {
	const db = createConnection();
	const datas = [req.body.name, req.body.online_image];

	const query = 'INSERT INTO `exercices`(`name`, `online_image`) VALUES (?, ?)';

	db.query(query, datas, (error, results) => {
		handler.handleReponse(res, error, null, 'Creation succeed!');
	});
	db.end();
});

router.put('/exercice/:id', (req, res) => {
	const db = createConnection();
	const id = req.params.id;
	const datas = [req.body.name, req.body.online_image, id];

	const query = 'UPDATE `exercices` SET `name` = ?, `online_image` = ? WHERE `id` = ?;';

	db.query(query, datas, (error, results) => {
		handler.handleReponse(res, error, null, 'Modification succeed!');
	});
	db.end();
});

router.delete('/exercice/:id', (req, res) => {
	const db = createConnection();
	const query = 'DELETE FROM `exercices` WHERE id = ?;';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, null, 'Delete succeed!');
	});
	db.end();
});

/**
 * muscles
 */

router.get('/muscles', (req, res) => {
	const db = createConnection();
	const query = 'SELECT * FROM `muscles`; ';

	db.query(query, (error, results) => {
		handler.handleReponse(res, error, results);
	});
	db.end();
});

/**
 * exercice_muscles
 */

router.get('/exercice_muscles/:id', (req, res) => {
	const db = createConnection();
	const query = 'SELECT * FROM `exercice_muscles` WHERE id_exercice = ?; ';
	const id = req.params.id;

	db.query(query, [id], (error, results) => {
		handler.handleReponse(res, error, results);
	});
	db.end();
});

router.post('/exercice_muscles', (req, res) => {
	const db = createConnection();
	const datas = [req.body.id_exercice, req.body.id_muscle, req.body.role];

	const query = 'INSERT INTO `exercice_muscles`(`id_exercice`, `id_muscle`, `role`) VALUES (?, ?, ?)';

	db.query(query, datas, (error, results) => {
		handler.handleReponse(res, error, null, 'Creation succeed!');
	});
	db.end();
});

router.delete('/exercice_muscles', (req, res) => {
	const db = createConnection();
	const datas = [req.query.id_exercice, req.query.id_muscle];
	const query = 'DELETE FROM `exercice_muscles` WHERE id_exercice = ? AND id_muscle = ?;';

	db.query(query, datas, (error, results) => {
		handler.handleReponse(res, error, null, 'Delete succeed!');
	});
	db.end();
});

module.exports = router;
