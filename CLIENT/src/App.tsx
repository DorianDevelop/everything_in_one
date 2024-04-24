import React from 'react';
import { Outlet } from 'react-router-dom';
import './App.css';

import Menu from './components/Menu';

function App() {
	return (
		<div className="App">
			<section id="contentWrapper">
				<div className="content">
					<Outlet />
				</div>
				<Menu />
			</section>
		</div>
	);
}

export default App;
