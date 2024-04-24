import { useLocation, Link } from 'react-router-dom';
import { BottomNavigation, BottomNavigationAction } from '@mui/material';
import { blue, grey } from '@mui/material/colors';

import CalendarMonthIcon from '@mui/icons-material/CalendarMonth';
import HomeIcon from '@mui/icons-material/Home';
import QueryStatsIcon from '@mui/icons-material/QueryStats';

function WorkousHomePage() {
	return (
		<>
			<h1>Workout home</h1>
			<BottomNavigation value={useLocation().pathname} sx={{ borderBottom: 1, height: 60, width: '75%', borderColor: grey[400] }}>
				<BottomNavigationAction
					sx={{
						color: blue[500] + ' !important',
					}}
					component={Link}
					to="/workouts"
					value="/workouts"
					label="Workouts"
					icon={<HomeIcon />}
				/>
				<BottomNavigationAction
					sx={{
						color: blue[500] + ' !important',
					}}
					component={Link}
					to="/workouts/schedules"
					value="/workouts/schedules"
					label="Schedules"
					icon={<CalendarMonthIcon />}
				/>
				<BottomNavigationAction
					sx={{
						color: blue[500] + ' !important',
					}}
					component={Link}
					to="/workouts/stats"
					value="/workouts/stats"
					label="Stats"
					icon={<QueryStatsIcon />}
				/>
			</BottomNavigation>
		</>
	);
}

export default WorkousHomePage;
