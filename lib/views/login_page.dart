import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import '../utils/modals.dart';
import '../utils/theme.dart';
import '../widgets/button_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: Get.width,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Track your everyday spending.',
                  style: AppTheme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 28.0),
                  child: Text(
                    'Aplikasi untuk mencatat dan reminder tentang budget dan pengeluaranmu.',
                    style: AppTheme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                // MyButton(
                //   padding: 14,
                //   foregroundColor: red,
                //   fontSize: 16,
                //   textButton: 'Login with Go',
                //   images: 'assets/images/google_logo.png',
                //   height: 20,
                //   textButtonColor: white,
                //   onPressed: () async {
                //     await authController.loginWithGoogle();
                //   },
                // ),
                
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 32, left: 20, right: 20, top: 20
            ),
            child: Obx(()=>
              ButtonWidget('Login dengan Google',
                    variant: ButtonVariant.primary,
                    loading: authController.isLoading.value,
                    prefixIcon:
                        Image.asset('assets/icons/google.png', width: 20),
                    onPressed: () async {
                      await login(context, authController);
                    }))
          )
        ],
      ),
    );
  }

  Future login(BuildContext context, AuthController authController) async {
    try {
      await authController.loginWithGoogle();
    } on Exception catch (e) {
      await ModalUtils.loginError(context, e, () async {
        await login(context, authController);
      });
    }
  }
}
