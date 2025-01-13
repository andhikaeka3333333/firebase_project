import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/todo_controller.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.put(TodoController());
    final TextEditingController titleController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xffb5cfec),
      appBar: AppBar(
        backgroundColor: Color(0xff4da1a9),
        title: const Text(
          'Expenses List 💰',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
                      title: Text(
                        todo['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        "Rp " + todo['price'].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
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
                                buttonColor: Color(0xff79d7be),
                                backgroundColor: Color(0xff4da1a9),
                                cancelTextColor: Colors.white,
                                confirmTextColor: Colors.white,
                                titleStyle: TextStyle(color: Colors.white),
                                title: "Edit Expense",
                                content: Column(
                                  children: [
                                    TextFormField(
                                      style: TextStyle(color: Color(0xfff6f4f0)),
                                      controller: editTitleController,
                                      decoration: InputDecoration(
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
                                      cursorColor: Color(0xfff6f4f0),
                                    ),
                                    SizedBox(height: 20),
                                    TextFormField(
                                      style: TextStyle(color: Color(0xfff6f4f0)),
                                      controller: editPriceController,
                                      decoration: InputDecoration(
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
                                      cursorColor: Color(0xfff6f4f0),
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
                                TextStyle(fontWeight: FontWeight.bold),
                                middleTextStyle: TextStyle(fontSize: 16),
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
            decoration: BoxDecoration(
              color: Color(0xff4da1a9),
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: const Offset(0, -2),
                  blurRadius: 6,
                )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    style: TextStyle(color: Color(0xfff6f4f0)),
                    controller: titleController,
                    decoration: InputDecoration(
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
                    cursorColor: Color(0xfff6f4f0),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    style: TextStyle(color: Color(0xfff6f4f0)),
                    controller: priceController,
                    decoration: InputDecoration(
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
                    cursorColor: Color(0xfff6f4f0),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty &&
                        priceController.text.isNotEmpty) {
                      controller.addExpense(
                          titleController.text, priceController.text);
                      titleController.clear();
                      priceController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff79d7be),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(fontSize: 16, color: Color(0xfff6f4f0)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}