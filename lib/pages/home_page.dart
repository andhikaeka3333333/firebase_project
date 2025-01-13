import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_project/widgets/my_color.dart';
import '../controller/auth_controller.dart';
import '../widgets/my_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 4,
        title:const MyText(hintText: 'Home', fontSize: 20, colors: white,fontWeight: FontWeight.bold,),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {

            },
          ),
        ],
      ),
      body: Center(
        child: Obx(() {
          final user = authController.user.value;
          if (user != null) {
            return Center(
              child: Container(
                width: 350,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFA726), Color(0xFFFFD54F)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 65,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user.photoURL ?? ''),
                            radius: 60,
                            backgroundColor: Colors.grey[200],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.camera_alt, size: 20, color: Colors.orange),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    MyText(hintText:    user.displayName ?? 'No Name', fontSize: 24, colors: white,fontWeight: FontWeight.bold,shadows: [Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(1, 2),),],),
                    const SizedBox(height: 5),
                    MyText(hintText: user.email ?? 'No Email', fontSize: 16, colors: white,fontWeight: FontWeight.w500,),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {

                          },
                          icon: const Icon(Icons.edit, size: 18,color: white,),
                          label: const MyText(hintText: 'Edit Profile',fontSize: 15,colors: white,),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFA726),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: () => authController.logout(),
                          icon: const Icon(Icons.logout, size: 18,color: white,),
                          label: const MyText(hintText: 'Logout',fontSize: 15,colors: white,),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF57C00),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: MyText(
                hintText: 'No user logged in',fontSize: 20,colors: Colors.orange,
              ),
            );
          }
        }),
      ),
    );
  }
}
