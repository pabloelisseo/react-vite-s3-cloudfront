import * as React from 'react';
import { ErrorBoundary } from 'react-error-boundary';


type AppProviderProps = {
  children: React.ReactNode;
};

export const AppProvider = ({ children }: AppProviderProps) => {


  return (
    <React.Suspense
      fallback={
        <div className="flex h-screen w-screen items-center justify-center">
          Loading...
        </div>
      }
    >
      <ErrorBoundary FallbackComponent={() => <div>Error</div>}>
          {children}
      </ErrorBoundary>
    </React.Suspense>
  );
};
