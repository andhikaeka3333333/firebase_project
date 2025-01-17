import 'package:firebase_project/routes/myapp_route.dart';
import 'package:firebase_project/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import '../utils/theme.dart';
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundSecondaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        border: Border.all(
                          color: AppTheme.white10,
                          width: 1,
                        ),
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
                                  radius: 44,
                                  backgroundColor: AppTheme.white90,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(user.photoURL ?? ''),
                                    radius: 40,
                                    backgroundColor: AppTheme.white60,
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.displayName ?? 'No Name',
                                        style: AppTheme.textTheme.labelLarge
                                            .copyWith(height: 1.2),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        user.email ?? 'No Email',
                                        style: AppTheme.textTheme.labelSmall,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        'Bergabung Jan 2025',
                                        style: AppTheme.textTheme.labelSmall,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            ButtonWidget('Edit Profil',
                                onPressed: () {},
                                prefixIcon: const Icon(Icons.edit, size: 20.0),
                                variant: ButtonVariant.outline,
                                textStyle: AppTheme.textTheme.bodyMedium
                                    .copyWith(
                                        color: AppTheme.textPrimaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16, height: 1.3)
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    ButtonWidget('Logout',
                        onPressed: () async {
                          await authController.logout();
                        },
                        variant: ButtonVariant.danger,
                        prefixIcon: const Icon(Icons.logout, size: 20.0),
                    ),
                  ],
                ),
              )
            ],
          );
        }

        // if null, then user should log in back
        Get.offNamed(MyappRoute.login);
        return Container();
      }),
    );
  }
}
