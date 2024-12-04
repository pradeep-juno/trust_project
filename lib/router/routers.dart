import 'package:get/get.dart';

import '../screens/desktop_login_screen.dart';

class AppRouter {
  static const LOGIN_SCREEN = '/login-screen';

  static var routes = [
    GetPage(
      name: LOGIN_SCREEN,
      page: () => DesktopLoginScreen(),
    )
  ];
}
