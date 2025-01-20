import 'package:firebase_project/bindings/navbar_binding.dart';
import 'package:firebase_project/bindings/expense_binding.dart';
import 'package:firebase_project/navbar/navbar.dart';
import 'package:firebase_project/views/notification_page.dart';
import 'package:firebase_project/views/expense_list_page.dart';
import 'package:get/get.dart';

import '../bindings/auth_binding.dart';
import '../bindings/notif_binding.dart';
import '../views/home_page.dart';
import '../views/login_page.dart';


class MyappRoute {
  static const login = '/login';
  static const home = '/home';
  static const expense = '/expense';
  static const navbar = '/navbar';
  static const notif = '/notification';
}

class AppPages {
  static final pages = [
    GetPage(
      name: MyappRoute.login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: MyappRoute.navbar,
      page: () => Navbar(),
      binding: NavbarBinding(),
    ),
    GetPage(
      name: MyappRoute.home,
      page: () => const HomePage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: MyappRoute.expense,
      page: () => ExpenseListPage(),
      binding: ExpenseBinding(),
    ),
    GetPage(
      name: MyappRoute.notif,
      page: () => const NotificationPage(),
      binding: NotifBinding(),
    ),
  ];
}



