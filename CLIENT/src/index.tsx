import React from 'react';
import ReactDOM from 'react-dom/client';
import { createBrowserRouter, RouterProvider } from 'react-router-dom';
import './index.css';
import App from './App';
import reportWebVitals from './reportWebVitals';

import '@fontsource/roboto/300.css';
import '@fontsource/roboto/400.css';
import '@fontsource/roboto/500.css';
import '@fontsource/roboto/700.css';

import DietHomePage from './pages/Diet/DietHomePage';
import DietSchedulesPage from './pages/Diet/DietSchedulesPage';
import DietStatsPage from './pages/Diet/DietStatsPage';
import WorkousHomePage from './pages/Workouts/WorkoutsHomePage';
import WorkoutsSchedulesPage from './pages/Diet/DietSchedulesPage';
import WorkoutsStatsPage from './pages/Workouts/WorkoutsStatsPage';
import HoursMainPage from './pages/HoursMainPage';
import NotesMainPage from './pages/Notes/NotesMainPage';
import NotesDetailsPage from './pages/Notes/NotesDetailsPage';

const router = createBrowserRouter([
	{
		path: '/',
		element: <App />,
		children: [
			{
				path: 'diet',
				element: <DietHomePage />,

				children: [
					{
						path: 'schedules',
						element: <DietSchedulesPage />,
					},
					{
						path: 'stats',
						element: <DietStatsPage />,
					},
				],
			},
			{
				path: 'workouts',
				element: <WorkousHomePage />,

				children: [
					{
						path: 'schedules',
						element: <WorkoutsSchedulesPage />,
					},
					{
						path: 'stats',
						element: <WorkoutsStatsPage />,
					},
				],
			},
			{
				path: 'hours',
				element: <HoursMainPage />,
			},
			{
				path: 'notes',
				element: <NotesMainPage />,
				children: [
					{
						path: 'details',
						element: <NotesDetailsPage />,
					},
				],
			},
		],
	},
]);

const root = ReactDOM.createRoot(document.getElementById('root') as HTMLElement);
root.render(
	<React.StrictMode>
		<RouterProvider router={router} />
	</React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
