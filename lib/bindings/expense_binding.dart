import 'package:firebase_project/controller/expense_controller.dart';
import 'package:get/get.dart';

class ExpenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ExpenseController());
  }
}
