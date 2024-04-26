import * as React from 'react';
import { useLocation, Link, Outlet } from 'react-router-dom';
//import Textarea from '@mui/joy/Textarea';
import { ListItem, ListItemText, Stack, Box, IconButton } from '@mui/material';
import { grey } from '@mui/material/colors';

import AddIcon from '@mui/icons-material/Add';

interface Note {
	id: number;
	title: string;
	description: string;
}

function NotesMainPage() {
	const [notes, setNotes] = React.useState<Note[]>([]);
	React.useEffect(() => {
		const fetchNotes = async () => {
			const response = await fetch('http://localhost:3000/notes/1');
			const notes = (await response.json()) as Note[];
			setNotes(notes);
		};

		fetchNotes();
	}, []);

	return (
		<Box className="noteContent">
			{useLocation().pathname !== '/notes' ? (
				<Outlet context={[notes, setNotes]} />
			) : (
				<>
					<IconButton aria-label="add" size="large" sx={{ marginY: 1 }} component={Link} to="/notes/details">
						<AddIcon fontSize="inherit" />
					</IconButton>
					<Stack spacing={2} sx={{ width: '90%' }}>
						{notes.map((note) => (
							<ListItem key={note.id} sx={{ borderRadius: '10px', backgroundColor: grey[200], cursor: 'pointer' }} component={Link} to={'/notes/' + note.id}>
								<ListItemText primary={note.title} secondary={note.description} />
							</ListItem>
						))}
					</Stack>
				</>
			)}
		</Box>
	);
}

export default NotesMainPage;
