import * as React from 'react';
import { useLocation, Link, Outlet } from 'react-router-dom';
//import Textarea from '@mui/joy/Textarea';
import { ListItem, ListItemText, Stack, Box, IconButton } from '@mui/material';
import { grey } from '@mui/material/colors';

import AddIcon from '@mui/icons-material/Add';

function generate(element: React.ReactElement) {
	return [0, 1, 2].map((value) =>
		React.cloneElement(element, {
			key: value,
		})
	);
}

function NotesMainPage() {
	return (
		<Box className="noteContent">
			{useLocation().pathname === '/notes/details' ? (
				<Outlet />
			) : (
				<>
					<IconButton aria-label="add" size="large" sx={{ marginY: 1 }} component={Link} to="/notes/details">
						<AddIcon fontSize="inherit" />
					</IconButton>
					<Stack spacing={2} sx={{ width: '90%' }}>
						{generate(
							<ListItem sx={{ borderRadius: '10px', backgroundColor: grey[200], cursor: 'pointer' }}>
								<ListItemText primary="Single-line item" secondary={'Test'} />
							</ListItem>
						)}
					</Stack>
				</>
			)}
		</Box>
	);
}

export default NotesMainPage;
