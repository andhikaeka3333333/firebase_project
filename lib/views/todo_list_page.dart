import 'package:firebase_project/widgets/my_button.dart';
import 'package:firebase_project/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/todo_controller.dart';
import '../utils/theme.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.find();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundSecondaryColor,
        title: const MyText(
          text: "Expense List 💰",
          fontSize: 20,
          colors: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.expenses.length,
                  itemBuilder: (context, index) {
                    final todo = controller.expenses[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 8.0),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          title: MyText(
                            text: todo['title'],
                            fontSize: 16,
                            colors: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          subtitle: MyText(
                            text: "Rp ${todo['price']}",
                            fontSize: 16,
                            colors: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  // Buat controller baru untuk setiap dialog edit
                                  final TextEditingController
                                      editTitleController =
                                      TextEditingController(
                                          text: todo['title']);
                                  final TextEditingController
                                      editPriceController =
                                      TextEditingController(
                                          text: todo['price'].toString());

                                  Get.defaultDialog(
                                    buttonColor: const Color(0xff79d7be),
                                    backgroundColor: const Color(0xff4da1a9),
                                    cancelTextColor: Colors.white,
                                    confirmTextColor: Colors.white,
                                    titleStyle: const TextStyle(color: Colors.white),
                                    title: "Edit Expense",
                                    content: Column(
                                      children: [
                                        TextFormField(
                                          style: const TextStyle(
                                              color: Color(0xfff6f4f0)),
                                          controller: editTitleController,
                                          decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xfff6f4f0)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xfff6f4f0)),
                                            ),
                                            labelText: "Produk",
                                            labelStyle: TextStyle(
                                                color: Color(0xfff6f4f0)),
                                            border: OutlineInputBorder(),
                                          ),
                                          cursorColor: const Color(0xfff6f4f0),
                                        ),
                                        const SizedBox(height: 20),
                                        TextFormField(
                                          style: const TextStyle(
                                              color: Color(0xfff6f4f0)),
                                          controller: editPriceController,
                                          decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xfff6f4f0)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xfff6f4f0)),
                                            ),
                                            labelText: "Produk",
                                            labelStyle: TextStyle(
                                                color: Color(0xfff6f4f0)),
                                            border: OutlineInputBorder(),
                                          ),
                                          cursorColor: const Color(0xfff6f4f0),
                                        ),
                                      ],
                                    ),
                                    textCancel: "Cancel",
                                    textConfirm: "Save",
                                    onCancel: () {},
                                    onConfirm: () {
                                      if (editTitleController.text.isNotEmpty &&
                                          editPriceController.text.isNotEmpty) {
                                        controller.updateExpense(
                                          todo['id'],
                                          editTitleController.text,
                                          editPriceController.text,
                                        );
                                        Get.back();
                                      }
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  Get.defaultDialog(
                                    title: "Confirmation",
                                    middleText:
                                        "Are you sure you want to delete '${todo['title']}'?",
                                    backgroundColor: Colors.white,
                                    titleStyle:
                                        const TextStyle(fontWeight: FontWeight.bold),
                                    middleTextStyle: const TextStyle(fontSize: 16),
                                    textCancel: "No",
                                    textConfirm: "Yes",
                                    cancelTextColor: Colors.black,
                                    confirmTextColor: Colors.white,
                                    buttonColor: Colors.red,
                                    onCancel: () {},
                                    onConfirm: () {
                                      controller.deleteExpense(todo['id']);
                                      Get.back();
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Color(0xff4da1a9),
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, -2),
                  blurRadius: 6,
                )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: const TextStyle(color: Color(0xfff6f4f0)),
                    controller: titleController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xfff6f4f0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xfff6f4f0)),
                      ),
                      labelText: "Produk",
                      labelStyle: TextStyle(color: Color(0xfff6f4f0)),
                      border: OutlineInputBorder(),
                    ),
                    cursorColor: const Color(0xfff6f4f0),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    style: const TextStyle(color: Color(0xfff6f4f0)),
                    controller: priceController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xfff6f4f0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xfff6f4f0)),
                      ),
                      labelText: "Harga",
                      labelStyle: TextStyle(color: Color(0xfff6f4f0)),
                      border: OutlineInputBorder(),
                    ),
                    cursorColor: const Color(0xfff6f4f0),
                  ),
                ),
                const SizedBox(width: 8),
                MyButton(
                  backgroundColor: const Color(0xff79d7be),
                  padding: 10,
                  foregroundColor: const Color(0xff79d7be),
                  fontSize: 16,
                  textButton: "Add",
                  textButtonColor: Colors.white,
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        priceController.text.isNotEmpty) {
                      controller.addExpense(
                          titleController.text, priceController.text);
                      titleController.clear();
                      priceController.clear();
                    }
                  },
                  height: 0,
                  side: BorderSide.none,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
