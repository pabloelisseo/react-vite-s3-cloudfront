import { createBrowserRouter } from 'react-router';

import { paths } from '@/config/paths';

export const routes = [
  {
    path: '/',
    async lazy() {
      const { default: Component } = await import('./pages/landing');
      return { Component };
    },
  },
  {
    path: paths.app.profile.path,
    async lazy() {
      const { default: Component } = await import('./pages/profile');
      return { Component };
    },
  },
  {
    path: '*',
    async lazy() {
      const { default: Component } = await import('./pages/not-found');
      return { Component };
    },
  },
];

export const appRouter = createBrowserRouter(routes);
