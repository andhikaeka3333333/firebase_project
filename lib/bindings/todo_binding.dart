import 'package:firebase_project/controller/todo_controller.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TodoController());
  }
}
