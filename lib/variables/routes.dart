enum Routes {home, profile, library}

const Map <Routes, int> routeNumber = {
  Routes.home: 0,
  Routes.profile: 1,
  Routes.library: 2,
};

const Map <Routes, String> routeString = {
  Routes.home: '/home',
  Routes.profile: '/profile',
  Routes.library: '/library',
};

const String netPicture = 'https://anylang.net/sites/default/files/covers/1984.jpg';