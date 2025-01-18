import 'package:firebase_project/controller/navbar_controller.dart';
import 'package:firebase_project/controller/expense_controller.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';

class NavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NavBarController());
    Get.put(ExpenseController());
    Get.put(AuthController());
  }
}
