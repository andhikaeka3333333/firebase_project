import 'package:firebase_project/utils/modals.dart';
import 'package:firebase_project/widgets/button_widget.dart';
import 'package:firebase_project/widgets/my_text.dart';
import 'package:firebase_project/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../controller/expense_controller.dart';
import '../models/expense_model.dart';
import '../utils/theme.dart';

class TodoListPage extends StatelessWidget {
  TodoListPage({super.key});

  bool modalOpened = false;

  @override
  Widget build(BuildContext context) {
    final ExpenseController controller = Get.find();
    final TextEditingController titleController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundSecondaryColor,
        title: const MyText(
          text: "Expense List",
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
            onPressed: () => showCreateUpdateModal(context,
                controller: controller,
                titleController: titleController,
                priceController: priceController,
                onSubmit: (context, controller, titleController,
                        priceController) =>
                    addExpense(
                        context, controller, titleController, priceController)),
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
          Flex(
            direction: Axis.vertical,
            children: [
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
                                title: Text(todo.title,
                                    style: AppTheme.textTheme.labelMedium),
                                subtitle: Text("Rp. ${todo.price}",
                                    style: AppTheme.textTheme.labelSmall
                                        .copyWith(color: AppTheme.white60)),
                                leading: SizedBox(
                                  width: 28,
                                  child: Checkbox(
                                      activeColor: AppTheme.primaryColor,
                                      checkColor: AppTheme.white100,
                                      value: todo.checked,
                                      onChanged: (value) {
                                        controller.updateExpense(todo.copyWith(
                                            checked: value ?? todo.checked));
                                      }),
                                ),
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
                                                text: todo.title);
                                        final TextEditingController
                                            editPriceController =
                                            TextEditingController(
                                                text: todo.price.toString());

                                        showCreateUpdateModal(context,
                                            controller: controller,
                                            titleController:
                                                editTitleController,
                                            priceController:
                                                editPriceController,
                                            onSubmit: (context,
                                                    controller,
                                                    titleController,
                                                    priceController) =>
                                                updateExpense(
                                                    todo,
                                                    context,
                                                    controller,
                                                    titleController,
                                                    priceController),
                                            isUpdate: true);
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete,
                                          color: AppTheme.errorColorLight),
                                      onPressed: () {
                                        showDeleteModal(context,
                                            controller: controller,
                                            onSubmit: (context, controller) =>
                                                deleteExpense(
                                                    todo, context, controller));
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
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> addExpense(
      BuildContext context,
      ExpenseController controller,
      TextEditingController titleController,
      TextEditingController priceController) async {
    if (FocusManager.instance.primaryFocus != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    } else {
      FocusScope.of(context).unfocus();
    }

    if (titleController.text.isEmpty || priceController.text.isEmpty) {
      if (titleController.text.isEmpty) {
        controller.titleError.value = "Judul tidak boleh kosong";
      }
      if (priceController.text.isEmpty) {
        controller.priceError.value = "Harga tidak boleh kosong";
      }
      return;
    }
    controller.clearInputErrors();

    try {
      await controller.addExpense(titleController.text, priceController.text);
    } on Exception catch (e) {
      // do task with Future after 100 ms
      Future.delayed(const Duration(milliseconds: 200), () async {
        await ModalUtils.dataError(context, "menambahkan", e);
      });
    }

    titleController.clear();
    priceController.clear();
    if (modalOpened) {
      Get.back();
    }
  }

  Future<void> updateExpense(
      ExpenseModel data,
      BuildContext context,
      ExpenseController controller,
      TextEditingController titleController,
      TextEditingController priceController) async {
    if (FocusManager.instance.primaryFocus != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    } else {
      FocusScope.of(context).unfocus();
    }

    if (titleController.text.isEmpty || priceController.text.isEmpty) {
      if (titleController.text.isEmpty) {
        controller.titleError.value = "Judul tidak boleh kosong";
      }
      if (priceController.text.isEmpty) {
        controller.priceError.value = "Harga tidak boleh kosong";
      }
      return;
    }
    controller.clearInputErrors();

    try {
      await controller.updateExpense(data.copyWith(
        title: titleController.text,
        price: priceController.text,
      ));
    } on Exception catch (e) {
      // do task with Future after 100 ms
      Future.delayed(const Duration(milliseconds: 200), () async {
        await ModalUtils.dataError(context, "mengupdate", e);
      });
    }

    titleController.clear();
    priceController.clear();
    if (modalOpened) {
      Get.back();
    }
  }

  Future<void> deleteExpense(ExpenseModel data, BuildContext context,
      ExpenseController controller) async {
    try {
      await controller.deleteExpense(data);
    } on Exception catch (e) {
      // do task with Future after 100 ms
      Future.delayed(const Duration(milliseconds: 200), () async {
        await ModalUtils.dataError(context, "menghapus", e);
      });
    }

    if (modalOpened) {
      Get.back();
    }
  }

  void showCreateUpdateModal(BuildContext context,
      {required ExpenseController controller,
      required TextEditingController titleController,
      required TextEditingController priceController,
      required dynamic onSubmit,
      bool isUpdate = false}) {
    if (modalOpened) return;
    modalOpened = true;
    showMaterialModalBottomSheet(
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
                      !isUpdate ? 'Pengeluaran Baru' : 'Edit Pengeluaran',
                      style: AppTheme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 32),
                    Obx(() => TextFieldWidget('Judul/Catatan',
                        prefixIcon: const Icon(Icons.note_alt_rounded),
                        error: controller.titleError.value,
                        controller: titleController)),
                    const SizedBox(height: 20),
                    Obx(() => TextFieldWidget('Harga',
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
                        error: controller.priceError.value,
                        controller: priceController)),
                    const SizedBox(height: 32),
                    Obx(() => ButtonWidget(
                        !isUpdate ? 'Tambah Pengeluaran' : 'Simpan Perubahan',
                        variant: ButtonVariant.primary,
                        prefixIcon: Icon(!isUpdate ? Icons.add : Icons.edit,
                            size: 20.0),
                        loading: !isUpdate
                            ? controller.isLoadingAdd.value
                            : controller.isLoadingUpdate.value,
                        onPressed: () => onSubmit(context, controller,
                            titleController, priceController))),
                  ],
                ),
              ),
            )).whenComplete(() => modalOpened = false);
  }

  void showDeleteModal(BuildContext context,
      {required ExpenseController controller, required dynamic onSubmit}) {
    if (modalOpened) return;
    modalOpened = true;
    showMaterialModalBottomSheet(
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
                      'Yakin menghapus?',
                      style: AppTheme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Catatan yang sudah terhapus tidak dapat dikembalikan!',
                      style:
                          AppTheme.textTheme.labelMedium.copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    ButtonWidget('Tidak, kembali',
                        variant: ButtonVariant.outline,
                        prefixIcon: const Icon(Icons.arrow_back, size: 20.0),
                        onPressed: () => Navigator.pop(context)),
                    const SizedBox(height: 20),
                    Obx(() => ButtonWidget('Ya, Hapus Pengeluaran',
                        variant: ButtonVariant.danger,
                        prefixIcon: const Icon(Icons.delete, size: 20.0),
                        loading: controller.isLoadingDelete.value,
                        onPressed: () => onSubmit(context, controller))),
                  ],
                ),
              ),
            )).whenComplete(() => modalOpened = false);
  }
}
