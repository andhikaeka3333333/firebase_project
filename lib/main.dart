import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/controller/notif_controller.dart';
import 'package:firebase_project/routes/myapp_route.dart';
import 'package:firebase_project/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/auth_controller.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotifController().initNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return GetMaterialApp(
      title: 'Menyala Abangku',
      initialRoute: authController.user.value != null ? MyappRoute.navbar : MyappRoute.login,
      theme: AppTheme.getThemeData(),
      getPages: AppPages.pages,
    );
  }
}




// import 'package:firebase_project/views/todo_list_page.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:get/get.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'To-Do-App',
//       home: Scaffold(
//           body: TodoListPage()
//       ),
//     );
//   }
// }
