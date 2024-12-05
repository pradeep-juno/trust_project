import 'package:get/get.dart';
import 'package:jk_event/screens/home_screen.dart';

import '../screens/login_screen.dart';

class AppRouter {
  static const LOGIN_SCREEN = '/login-screen';
  static const HOME_SCREEN = '/home-screen';

  static var routes = [
    GetPage(
      name: LOGIN_SCREEN,
      page: () => LoginScreen(),
    ),
    GetPage(name: HOME_SCREEN, page: () => HomeScreen()),
  ];
}
