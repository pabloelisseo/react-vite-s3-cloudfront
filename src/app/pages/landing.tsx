import DefaultLayout from '@/layout/DefaultLayout';

const Landing = () => {
  return (
    <DefaultLayout>
      <div className="flex flex-col items-center text-center">
        <h1 className="bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-4xl font-bold text-transparent dark:from-indigo-400 dark:to-purple-400 md:text-5xl">
          Welcome to Our App
        </h1>
        <p className="mt-6 max-w-2xl text-lg text-gray-600 dark:text-gray-300">
          Welcome to the landing page of the app. Discover amazing features and possibilities 
          that await you in this beautifully crafted experience.
        </p>
      </div>
    </DefaultLayout>
  );
};

export default Landing;
