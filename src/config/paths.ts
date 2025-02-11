export const paths = {
  home: {
    path: "/",
    getHref: () => "/",
  },

  auth: {
    register: {
      path: "/auth/register",
      getHref: (redirectTo?: string | null | undefined) =>
        `/auth/register${
          redirectTo ? `?redirectTo=${encodeURIComponent(redirectTo)}` : ""
        }`,
      title: "Register",
    },
    login: {
      path: "/auth/login",
      getHref: (redirectTo?: string | null | undefined) =>
        `/auth/login${
          redirectTo ? `?redirectTo=${encodeURIComponent(redirectTo)}` : ""
        }`,
      title: "Login",
    },
  },

  app: {
    root: {
      path: "/",
      getHref: () => "/app/dashboard",
      title: "Dashboard",
    },
    profile: {
      path: "/profile",
      getHref: () => "/profile",
      title: "Profile",
    },
  },
} as const;
