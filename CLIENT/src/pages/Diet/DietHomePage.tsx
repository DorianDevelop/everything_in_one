import { useLocation, Link, Outlet } from 'react-router-dom';
import { BottomNavigation, BottomNavigationAction } from '@mui/material';
import { red, grey } from '@mui/material/colors';

import CalendarMonthIcon from '@mui/icons-material/CalendarMonth';
import HomeIcon from '@mui/icons-material/Home';
import QueryStatsIcon from '@mui/icons-material/QueryStats';

function DietHomePage() {
	return (
		<>
			{useLocation().pathname !== '/diet' ? <Outlet /> : <h1>Diet</h1>}

			<BottomNavigation value={useLocation().pathname} sx={{ borderBottom: 1, height: 60, width: '75%', borderColor: grey[400] }}>
				<BottomNavigationAction
					sx={{
						color: red[500] + ' !important',
					}}
					component={Link}
					to="/diet"
					value="/diet"
					label="Diet"
					icon={<HomeIcon />}
				/>
				<BottomNavigationAction
					sx={{
						color: red[500] + ' !important',
					}}
					component={Link}
					to="/diet/schedules"
					value="/diet/schedules"
					label="Schedules"
					icon={<CalendarMonthIcon />}
				/>
				<BottomNavigationAction
					sx={{
						color: red[500] + ' !important',
					}}
					component={Link}
					to="/diet/stats"
					value="/diet/stats"
					label="Stats"
					icon={<QueryStatsIcon />}
				/>
			</BottomNavigation>
		</>
	);
}

export default DietHomePage;
