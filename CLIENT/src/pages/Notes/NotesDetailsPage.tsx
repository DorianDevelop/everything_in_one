import * as React from 'react';
import { Link, useParams } from 'react-router-dom';
import { IconButton, Input, Button, Box } from '@mui/material';
import { red, green } from '@mui/material/colors';
import Textarea from '@mui/joy/Textarea';

import ArrowBackIcon from '@mui/icons-material/ArrowBack';

import SaveIcon from '@mui/icons-material/Save';
import DeleteIcon from '@mui/icons-material/Delete';

function NotesDetailsPage() {
	const params = useParams();

	const [note, setNote] = React.useState({ title: '', description: '' });
	React.useEffect(() => {
		fetch('http://localhost:3000/note/' + params.id)
			.then((response) => response.json())
			.then((data) => {
				console.log(data);
				setNote(data[0]);
			})
			.catch((err) => {
				console.log(err.message);
			});
	}, [params]);

	const HandleSave = () => {
		const data = {
			title: note.title,
			description: note.description,
			id: params.id,
		};
		console.log(data);
	};

	const HandleDelete = () => {
		// Handle delete functionality here
		console.log('Note deleted:', note);
	};

	return (
		<>
			<IconButton aria-label="add" size="large" sx={{ marginY: 1 }} component={Link} to="/notes">
				<ArrowBackIcon fontSize="inherit" />
			</IconButton>
			<Input
				value={note.title}
				sx={{ width: '80%', margin: '32px 0 16px 0' }}
				placeholder="Title.."
				onChange={(event) => {
					setNote({ title: event.target.value, description: note.description });
				}}
			></Input>
			<Textarea
				value={note.description}
				sx={{ width: '95%', height: '100%', overflowY: 'auto', overflowX: 'hidden' }}
				placeholder="..."
				onChange={(event) => {
					setNote({ title: note.title, description: event.target.value });
				}}
			></Textarea>
			<Box sx={{ width: '100%', display: 'flex', justifyContent: 'space-evenly', marginTop: 2 }}>
				<Button component="label" variant="contained" color="success" startIcon={<SaveIcon />} sx={{ width: '150px', backgroundColor: green[500] }} onClick={HandleSave}>
					Save
				</Button>
				<Button component="label" variant="contained" color="error" startIcon={<DeleteIcon />} sx={{ width: '150px', backgroundColor: red[500] }} onClick={HandleDelete}>
					Delete
				</Button>
			</Box>
		</>
	);
}

export default NotesDetailsPage;
