import 'package:firebase_project/bindings/navbar_binding.dart';
import 'package:firebase_project/bindings/todo_binding.dart';
import 'package:firebase_project/controller/navbar_controller.dart';
import 'package:firebase_project/navbar/navbar.dart';
import 'package:firebase_project/views/todo_list_page.dart';
import 'package:get/get.dart';

import '../bindings/auth_binding.dart';
import '../views/home_page.dart';
import '../views/login_page.dart';


class MyappRoute {
  static const login = '/login';
  static const home = '/home';
  static const todo = '/todo';
  static const navbar = '/navbar';
}

class AppPages {
  static final pages = [
    GetPage(
      name: '/login',
      page: () => const LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/navbar',
      page: () => Navbar(),
      binding: NavbarBinding(),
    ),
    GetPage(
      name: '/home',
      page: () => const HomePage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/todo',
      page: () => const TodoListPage(),
      binding: TodoBinding(),
    ),
  ];
}



