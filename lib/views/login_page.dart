import 'package:firebase_project/utils/theme.dart';
import 'package:firebase_project/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../controller/auth_controller.dart';
import '../utils/theme.dart';
import '../widgets/button_widget.dart';
import '../widgets/my_color.dart';

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
      await showErrorModal(context, e, () async {
        await login(context, authController);
      });
    }
  }

  Future showErrorModal(BuildContext context, Exception e, Function onRetry) {
    return showMaterialModalBottomSheet(
        context: context,
        backgroundColor: AppTheme.backgroundSecondaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) => SingleChildScrollView(
              controller: ModalScrollController.of(context),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 20.0,
                  right: 20.0,
                  bottom: 32.0,
                ),
                child: Column(
                  children: [
                    Image.asset('assets/icons/drag.png', height: 8),
                    const SizedBox(height: 20),
                    Text(
                      'Oops.. Ada masalah!',
                      style: AppTheme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Terjadi kesalahan ketika mencoba membuatmu login. Silahkan coba lagi.',
                      style:
                          AppTheme.textTheme.labelMedium.copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      e.toString(),
                      style: AppTheme.textTheme.labelSmall
                          .copyWith(color: AppTheme.white60),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ButtonWidget('Coba lagi', variant: ButtonVariant.primary,
                        onPressed: () {
                      onRetry();
                      Navigator.pop(context);
                    }),
                  ],
                ),
              ),
            ));
  }
}
