import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import '../widgets/my_button.dart';
import '../widgets/my_color.dart';
import '../widgets/my_image.dart';
import '../widgets/my_text.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();

    return Scaffold(
      backgroundColor: primaryBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MyText(hintText:  'Sign in', fontSize: 24, colors: white,fontWeight: FontWeight.bold),
            const SizedBox(height: 20),
            const MyImage(imageName: 'asset/images/firebase.png', width: 100, height: 100),
            const SizedBox(height: 30),
            MyButton(padding: 14, foregroundColor: red, fontSize: 16, textButton: 'Login with Google', images: 'asset/images/google_logo.png', height: 20, textButtonColor: white,
              onPressed: ()async {
                await authController.loginWithGoogle();
              },)
          ],
        ),
      ),
    );
  }
}

