import DefaultLayout from '@/layout/DefaultLayout';

const NotFound = () => {
  return (
    <DefaultLayout>
      <div className="flex flex-col items-center text-center">
        <h1 className="bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-4xl font-bold text-transparent dark:from-indigo-400 dark:to-purple-400 md:text-5xl">
          404 - Page Not Found
        </h1>
        <p className="mt-6 max-w-2xl text-lg text-gray-600 dark:text-gray-300">
          Oops! The page you're looking for doesn't exist. Please check the URL or navigate
          back to the homepage.
        </p>
      </div>
    </DefaultLayout>
  );
};

export default NotFound;
