import 'package:firebase_project/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import '../widgets/my_button.dart';
import '../widgets/my_color.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Scaffold(
      backgroundColor: primaryBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png', width: Get.width,),
          const SizedBox(height: 20),
          Text(
            'Track your everyday spending.',
            style: AppTheme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Aplikasi untuk mencatat dan reminder tentang budget dan pengeluaranmu.',
              style: AppTheme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 120),
          MyButton(
            padding: 14,
            foregroundColor: red,
            fontSize: 16,
            textButton: 'Login with Google',
            images: 'assets/images/google_logo.png',
            height: 20,
            textButtonColor: white,
            onPressed: () async {
              await authController.loginWithGoogle();
            },
          ),
        ],
      ),
    );
  }
}
