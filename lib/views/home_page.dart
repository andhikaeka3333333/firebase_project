import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import '../utils/theme.dart';
import '../widgets/my_button.dart';
import '../widgets/my_color.dart';
import '../widgets/my_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundSecondaryColor,
        title: const MyText(
          text: 'Profile Page',
          fontSize: 20,
          colors: white,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        final user = authController.user.value;
        if (user != null) {
          return Stack(
            children: [
              Image.asset(
                'assets/images/background.png',
                width: Get.width,
              ),
              Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    width: 400,
                    height: 240,
                    decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 10.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(user.photoURL ?? ''),
                                  radius: 45,
                                  backgroundColor: Colors.grey[200],
                                ),
                              ),
                              SizedBox(width: 30),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.displayName ?? 'No Name',
                                      style: AppTheme.textTheme.labelLarge,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      user.email ?? 'No Email',
                                      style: AppTheme.textTheme.labelSmall,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Bergabung sejak 2017',
                                      style: AppTheme.textTheme.labelSmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Center(
                            child: MyButton(
                              padding: 14,
                              foregroundColor: white,
                              fontSize: 16,
                              textButton: 'Keluar Akun',
                              height: 20,
                              textButtonColor: white,
                              onPressed: () => authController.logout(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        } else {
          return const Center(
            child: MyText(
              text: 'No user logged in',
              fontSize: 20,
              colors: Colors.orange,
            ),
          );
        }
      }),
    );
  }
}
