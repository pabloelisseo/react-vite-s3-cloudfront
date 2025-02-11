import { RouterProvider } from 'react-router-dom';

import { AppProvider } from './provider';
import { appRouter } from './routes';

export const App = () => {
  return (
    <AppProvider>
      <RouterProvider router={appRouter} />
    </AppProvider>
  );
};
