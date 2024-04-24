const handleReponse = (res, error, results, successMessage) => {
	if (error) {
		res.status(500).json({ error: 'An error occurred \n' + error });
	} else {
		res.status(200).json(successMessage ? { message: successMessage } : results);
	}
};

module.exports = {
	handleReponse,
};
