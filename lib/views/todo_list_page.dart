import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/todo_controller.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.put(TodoController());
    final TextEditingController textController = TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xffb5cfec),
      appBar: AppBar(
        backgroundColor: Color(0xff4da1a9),
        title: const Text(
          'To-Do List',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: controller.todos.length,
                  itemBuilder: (context, index) {
                    final todo = controller.todos[index];
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
                          tileColor: todo['completed']
                              ? Colors.green.shade50
                              : Colors.white,
                          title: Text(
                            todo['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              decoration: todo['completed']
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          leading: Checkbox(
                            activeColor: Color(0xff4da1a9),
                            checkColor: Colors.white,
                            value: todo['completed'],
                            onChanged: (value) {
                              controller.updateTodo(todo['id'], value!);
                            },
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
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
                                  controller.deleteTodo(todo['id']);
                                  Get.back();
                                },
                              );
                            },
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
                    controller: textController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xfff6f4f0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xfff6f4f0)),
                      ),
                      labelText: "Add a new task",
                      labelStyle: TextStyle(color: Color(0xfff6f4f0)),
                      border: OutlineInputBorder(),
                    ),
                    cursorColor: Color(0xfff6f4f0),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      controller.addTodo(textController.text);
                      textController.clear();
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
