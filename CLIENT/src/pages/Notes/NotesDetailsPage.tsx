import { Link } from 'react-router-dom';
import { IconButton, Input, Button, Box } from '@mui/material';
import { red, green } from '@mui/material/colors';
import Textarea from '@mui/joy/Textarea';

import ArrowBackIcon from '@mui/icons-material/ArrowBack';

import SaveIcon from '@mui/icons-material/Save';
import DeleteIcon from '@mui/icons-material/Delete';

function NotesDetailsPage() {
	return (
		<>
			<IconButton aria-label="add" size="large" sx={{ marginY: 1 }} component={Link} to="/notes">
				<ArrowBackIcon fontSize="inherit" />
			</IconButton>
			<Input sx={{ width: '80%', margin: '32px 0 16px 0' }} placeholder="Title.."></Input>
			<Textarea sx={{ width: '95%', height: '100%', overflowY: 'auto', overflowX: 'hidden' }} placeholder="..."></Textarea>
			<Box sx={{ width: '100%', display: 'flex', justifyContent: 'space-evenly', marginTop: 2 }}>
				<Button component="label" variant="contained" color="success" startIcon={<SaveIcon />} sx={{ width: '150px', backgroundColor: green[500] }}>
					Save
				</Button>
				<Button component="label" variant="contained" color="error" startIcon={<DeleteIcon />} sx={{ width: '150px', backgroundColor: red[500] }}>
					Delete
				</Button>
			</Box>
		</>
	);
}

export default NotesDetailsPage;
