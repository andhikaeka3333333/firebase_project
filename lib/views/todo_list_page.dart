import 'package:firebase_project/widgets/button_widget.dart';
import 'package:firebase_project/widgets/my_button.dart';
import 'package:firebase_project/widgets/my_text.dart';
import 'package:firebase_project/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 4.0,
          right: 4.0,
        ),
        child: SizedBox(
          width: 64,
          height: 64,
          child: FloatingActionButton(
            onPressed: () => showCreateModal(context,
                controller: controller,
                titleController: titleController,
                priceController: priceController),
            backgroundColor: AppTheme.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.add,
              color: AppTheme.white100,
              size: 36,
              weight: 2,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            width: Get.width,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(() => ListView.builder(
                    itemCount: controller.expenses.length,
                    itemBuilder: (context, index) {
                      final todo = controller.expenses[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.backgroundSecondaryColor,
                            borderRadius: const BorderRadius.all(
                                Radius.circular(12.0)),
                            border: Border.all(
                              color: AppTheme.white10,
                              width: 1,
                            ),
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            title: Text(todo['title'],
                                style: AppTheme.textTheme.labelMedium),
                            subtitle: Text("Rp. ${todo['price']}",
                                style: AppTheme.textTheme.labelSmall
                                    .copyWith(color: AppTheme.white60)),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit,
                                      color: AppTheme.white90),
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
                                      backgroundColor:
                                          const Color(0xff4da1a9),
                                      cancelTextColor: Colors.white,
                                      confirmTextColor: Colors.white,
                                      titleStyle: const TextStyle(
                                          color: Colors.white),
                                      title: "Edit Expense",
                                      content: Column(
                                        children: [
                                          TextFormField(
                                            style: const TextStyle(
                                                color: Color(0xfff6f4f0)),
                                            controller: editTitleController,
                                            decoration:
                                                const InputDecoration(
                                              enabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Color(0xfff6f4f0)),
                                              ),
                                              focusedBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Color(0xfff6f4f0)),
                                              ),
                                              labelText: "Produk",
                                              labelStyle: TextStyle(
                                                  color: Color(0xfff6f4f0)),
                                              border: OutlineInputBorder(),
                                            ),
                                            cursorColor:
                                                const Color(0xfff6f4f0),
                                          ),
                                          const SizedBox(height: 20),
                                          TextFormField(
                                            style: const TextStyle(
                                                color: Color(0xfff6f4f0)),
                                            controller: editPriceController,
                                            decoration:
                                                const InputDecoration(
                                              enabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Color(0xfff6f4f0)),
                                              ),
                                              focusedBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Color(0xfff6f4f0)),
                                              ),
                                              labelText: "Produk",
                                              labelStyle: TextStyle(
                                                  color: Color(0xfff6f4f0)),
                                              border: OutlineInputBorder(),
                                            ),
                                            cursorColor:
                                                const Color(0xfff6f4f0),
                                          ),
                                        ],
                                      ),
                                      textCancel: "Cancel",
                                      textConfirm: "Save",
                                      onCancel: () {},
                                      onConfirm: () {
                                        if (editTitleController
                                                .text.isNotEmpty &&
                                            editPriceController
                                                .text.isNotEmpty) {
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
                                  icon: const Icon(Icons.delete,
                                      color: AppTheme.errorColorLight),
                                  onPressed: () {
                                    Get.defaultDialog(
                                      title: "Confirmation",
                                      middleText:
                                          "Are you sure you want to delete '${todo['title']}'?",
                                      backgroundColor: Colors.white,
                                      titleStyle: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      middleTextStyle:
                                          const TextStyle(fontSize: 16),
                                      textCancel: "No",
                                      textConfirm: "Yes",
                                      cancelTextColor: Colors.black,
                                      confirmTextColor: Colors.white,
                                      buttonColor: Colors.red,
                                      onCancel: () {},
                                      onConfirm: () {
                                        controller
                                            .deleteExpense(todo['id']);
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
          )
        ],
      ),
    );
  }

  Future<void> addExpense(
      BuildContext context,
      TodoController controller,
      TextEditingController titleController,
      TextEditingController priceController) async {
    if (FocusManager.instance.primaryFocus != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    } else {
      FocusScope.of(context).unfocus();
    }

    if (titleController.text.isNotEmpty && priceController.text.isNotEmpty) {
      try {
        await controller.addExpense(titleController.text, priceController.text);
      } on Exception catch (e) {
        // do task with Future after 100 ms
        Future.delayed(const Duration(milliseconds: 200), () async {
          await showErrorModal(context, e);
        });
      }
      Navigator.pop(context);
      titleController.clear();
      priceController.clear();
    }
  }

  Future showCreateModal(BuildContext context,
      {required TodoController controller,
      required TextEditingController titleController,
      required TextEditingController priceController}) {
    return showMaterialModalBottomSheet(
        context: context,
        backgroundColor: AppTheme.backgroundSecondaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (modalContext) => SingleChildScrollView(
              controller: ModalScrollController.of(modalContext),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 20.0,
                  left: 20.0,
                  right: 20.0,
                  bottom: 32.0 + MediaQuery.of(modalContext).viewInsets.bottom,
                ),
                child: Column(
                  children: [
                    Image.asset('assets/icons/drag.png', height: 8),
                    const SizedBox(height: 20),
                    Text(
                      'Pengeluaran Baru',
                      style: AppTheme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 32),
                    TextFieldWidget('Judul/Catatan',
                        prefixIcon: const Icon(Icons.note_alt_rounded),
                        controller: titleController),
                    const SizedBox(height: 20),
                    TextFieldWidget('Harga',
                        prefixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Rp',
                                style: AppTheme.textTheme.labelMedium.copyWith(
                                  fontSize: 16,
                                ))
                          ],
                        ),
                        controller: priceController),
                    const SizedBox(height: 32),
                    ButtonWidget('Tambah Pengeluaran',
                        variant: ButtonVariant.primary,
                        prefixIcon: const Icon(Icons.add, size: 20.0),
                        loading: controller.isLoadingAdd.value,
                        onPressed: () => addExpense(context, controller,
                            titleController, priceController)),
                  ],
                ),
              ),
            ));
  }

  Future showErrorModal(BuildContext context, Exception e) {
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
                      'Terjadi kesalahan ketika menambahkan data, namun data akan disinkronkan kembali setelah tersambung kembali.',
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
                    ButtonWidget('Oke mengerti', variant: ButtonVariant.primary,
                        onPressed: () {
                      Navigator.pop(context);
                    }),
                  ],
                ),
              ),
            ));
  }
}
