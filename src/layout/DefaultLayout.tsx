import { paths } from '@/config/paths';
import React from 'react';


export default function DefaultLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="flex min-h-screen w-screen flex-col items-center bg-gradient-to-br from-indigo-50 to-purple-50 p-4 dark:from-dark-4 dark:to-dark-3 md:p-6">
      <div className="w-full max-w-7xl">
        <header className="relative flex h-16 w-full items-center justify-between rounded-xl bg-white/80 px-6 shadow-lg backdrop-blur-sm transition-colors dark:bg-dark-2/80 dark:shadow-dark-1/10">
          <button
            onClick={() => window.history.back()}
            className="flex items-center gap-2 rounded-lg px-3 py-2 text-indigo-600 transition-all hover:bg-indigo-50 hover:text-indigo-700 dark:text-indigo-400 dark:hover:bg-white-1/10 dark:hover:text-indigo-300"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              strokeWidth={1.5}
              stroke="currentColor"
              className="h-6 w-6"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                d="M10.5 19.5L3 12m0 0l7.5-7.5M3 12h18"
              />
            </svg>
            Back
          </button>
          
          <div className="absolute left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2">
            <img src="/cloud.png" alt="Logo" className="h-16 w-16" />
          </div>

          <nav className="flex items-center gap-6">
            <a
              href={paths.home.getHref()}
              className="rounded-lg px-3 py-2 text-indigo-600 transition-all hover:bg-indigo-50 hover:text-indigo-700 dark:text-indigo-400 dark:hover:bg-white-1/10 dark:hover:text-indigo-300"
            >
              Landing
            </a>
            <a
              href={paths.app.profile.getHref()}
              className="rounded-lg px-3 py-2 text-indigo-600 transition-all hover:bg-indigo-50 hover:text-indigo-700 dark:text-indigo-400 dark:hover:bg-white-1/10 dark:hover:text-indigo-300"
            >
              Profile
            </a>
          </nav>
        </header>
      </div>
      <main className="mt-4 flex w-full max-w-7xl flex-1 gap-2 rounded-xl">
        <div className="w-full rounded-xl bg-white/80 p-8 shadow-lg backdrop-blur-sm transition-colors dark:bg-dark-2/80 dark:shadow-dark-1/10">
          {children}
        </div>
      </main>
    </div>
  );
}
