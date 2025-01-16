import 'package:firebase_project/controller/navbar_controller.dart';
import 'package:firebase_project/utils/theme.dart';
import 'package:firebase_project/views/home_page.dart';
import 'package:firebase_project/views/todo_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Navbar extends StatelessWidget {
  Navbar({super.key});

  final NavBarController navBarController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(builder: (context) {
      return Scaffold(
        body: IndexedStack(
          index: navBarController.tabIndex,
          children: const [TodoListPage(), HomePage()],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: AppTheme.white10,
                width: 1,
              ),
            ),
          ),
          child: SizedBox(
            height: 68,
            child: BottomNavigationBar(
              backgroundColor: AppTheme.backgroundSecondaryColor,
              selectedItemColor: AppTheme.primaryColorLight,
              unselectedItemColor: AppTheme.white60,
              currentIndex: navBarController.tabIndex,
              onTap: navBarController.changeTabIndex,
              items: [
                _bottombarItem(Icons.home_rounded, "Home"),
                _bottombarItem(CupertinoIcons.person_crop_circle_fill, "Profile"),
              ],
            ),
          ),
        ),
      );
    });
  }
}

_bottombarItem(IconData icon, String label) {
  return BottomNavigationBarItem(icon: Icon(icon), label: label);
}