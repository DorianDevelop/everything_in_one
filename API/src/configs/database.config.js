const mysql = require('mysql');
require('dotenv').config();

const pool = mysql.createPool({
	host: process.env.DB_HOST,
	port: '3306',
	user: process.env.DB_USER,
	password: process.env.DB_PASS,
	database: 'modu',
	waitForConnections: true,
	connectionLimit: 10,
	queueLimit: 0,
	acquireTimeout: 60000,
	connectTimeout: 60000,
	idleTimeout: 60000,
});

module.exports = pool;
