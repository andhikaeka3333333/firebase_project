import 'package:get/get.dart';

import '../bindings/auth_binding.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';


class MyappRoute {
  static const login = '/login';
  static const home = '/home';
}

class AppPages {
  static final pages = [
    GetPage(
      name: '/login',
      page: () => const LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/home',
      page: () => const HomePage(),
      binding: AuthBinding(),
    ),
  ];
}



