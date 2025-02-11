import { createRoot } from 'react-dom/client';

import './css/style.css';
import { App } from './app/index';

const root = document.getElementById('root');
if (!root) throw new Error('No root element found');

createRoot(root).render(<App />);
