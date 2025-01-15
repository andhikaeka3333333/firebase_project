import 'package:firebase_project/controller/navbar_controller.dart';
import 'package:firebase_project/views/home_page.dart';
import 'package:firebase_project/views/todo_list_page.dart';
import 'package:flutter/material.dart';
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
          children: const [
            HomePage(),
            TodoListPage()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.grey.shade400,
          currentIndex: navBarController.tabIndex,
          onTap: navBarController.changeTabIndex,
          items: [
            _bottombarItem(Icons.home_rounded, "Home"),
            _bottombarItem(Icons.sticky_note_2_rounded, "Expense"),
          ],
        ),
      );
    });
  }
}


_bottombarItem(IconData icon, String label) {
  return BottomNavigationBarItem(icon: Icon(icon), label: label);
}
