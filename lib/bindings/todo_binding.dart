import 'package:firebase_project/controller/todo_controller.dart';
import 'package:get/get.dart';

class TodoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TodoController());
  }
}
