import 'package:firebase_project/controller/notif_controller.dart';
import 'package:get/get.dart';

class NotifBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotifController());
  }
}
