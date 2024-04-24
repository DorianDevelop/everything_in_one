import * as React from 'react';

import { useLocation, Link } from 'react-router-dom';
import { BottomNavigation, BottomNavigationAction } from '@mui/material';
import { red, blue, green, grey } from '@mui/material/colors';

import FastfoodIcon from '@mui/icons-material/Fastfood';
import FitnessCenterIcon from '@mui/icons-material/FitnessCenter';
import AccessTimeIcon from '@mui/icons-material/AccessTime';
import DescriptionIcon from '@mui/icons-material/Description';

//import CalendarMonthIcon from '@mui/icons-material/CalendarMonth';
//import HomeIcon from '@mui/icons-material/Home';
//import QueryStatsIcon from '@mui/icons-material/QueryStats';

const transformString = (str: string): string => {
	const pathParts = str.split('/');

	return '/' + pathParts[1];
};

function Menu() {
	return (
		<BottomNavigation value={transformString(useLocation().pathname)} sx={{ height: 70 }}>
			<BottomNavigationAction
				sx={{
					color: red[500] + ' !important',
				}}
				component={Link}
				to="/diet"
				value="/diet"
				label="Diet"
				icon={<FastfoodIcon />}
			/>
			<BottomNavigationAction
				sx={{
					color: blue[500] + ' !important',
				}}
				component={Link}
				to="/workouts"
				value="/workouts"
				label="Workouts"
				icon={<FitnessCenterIcon />}
			/>
			<BottomNavigationAction
				sx={{
					color: green[500] + ' !important',
				}}
				component={Link}
				to="/hours"
				value="/hours"
				label="Hours"
				icon={<AccessTimeIcon />}
			/>
			<BottomNavigationAction
				sx={{
					color: grey[900] + ' !important',
				}}
				component={Link}
				to="/notes"
				value="/notes"
				label="Notes"
				icon={<DescriptionIcon />}
			/>
		</BottomNavigation>
	);
}

export default Menu;
