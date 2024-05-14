const mysql = require('mysql');
require('dotenv').config();

const createConnection = (dbName) => {
	const connection = mysql.createConnection({
		host: process.env.DB_HOST,
		port: '3306',
		user: process.env.DB_USER,
		password: process.env.DB_PASS,
		database: dbName,
	});

	//Création de la connection, avec message d'erreur si raté
	connection.connect((error) => {
		if (error) {
			console.error('Error connecting to the database:', error);
		}
	});

	return connection;
};

module.exports = createConnection;
