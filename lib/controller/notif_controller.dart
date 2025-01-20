import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_project/routes/myapp_route.dart';
import 'package:get/get.dart';

import 'navbar_controller.dart';

class NotifController extends GetxController {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    final fCMToken = await _firebaseMessaging.getToken();

    print('Token: $fCMToken');

    initPushNotifications();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    final NavBarController navBarController = Get.find();
    navBarController.changeTabIndex(1);
    Get.toNamed(MyappRoute.navbar);
  }

  Future initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
