import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/models/expense_model.dart';
import 'package:get/get.dart';

class ExpenseController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<ExpenseModel> expenses = <ExpenseModel>[].obs;

  Rx<String?> titleError = Rx<String?>(null);
  Rx<String?> priceError = Rx<String?>(null);
  
  Rx<bool> isLoadingFetch = Rx<bool>(true);
  Rx<bool> isLoadingAdd = Rx<bool>(false);
  Rx<bool> isLoadingUpdate = Rx<bool>(false);
  Rx<bool> isLoadingDelete = Rx<bool>(false);

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() {
    final user = FirebaseAuth.instance.currentUser;
    _firestore.collection('expenses')
      .where('user', isEqualTo: user?.uid)
      .snapshots()
      .listen((snapshot) {
        expenses.value = snapshot.docs
            .map((doc) => ExpenseModel.fromJson(doc.id, doc.data()))
            .toList();
        isLoadingFetch.value = false;
      });
  }

  ExpenseModel getData(String id) {
    final data = expenses.firstWhere((element) => element.id == id);
    return data; 
  }

  Future<void> addExpense(String title, String price) async {
    isLoadingAdd.value = true;
    try {
      final user = FirebaseAuth.instance.currentUser;
      await _firestore.collection('expenses')
        .add({ 
          'title': title, 
          'price': price, 
          'checked': false, 
          'user': user?.uid
        })
        .timeout(const Duration(seconds: 10));
    } catch (e) {
      isLoadingAdd.value = false;
      rethrow;
    }
    isLoadingAdd.value = false;
  }

  Future<void> deleteExpense(ExpenseModel data) async {
    isLoadingDelete.value = true;
    try {
      await _firestore
          .collection('expenses')
          .doc(data.id)
          .delete()
          .timeout(const Duration(seconds: 10));
    } catch (e) {
      isLoadingDelete.value = false;
      rethrow;
    }
    isLoadingDelete.value = false;
  }

  Future<void> updateExpense(ExpenseModel data) async {
    isLoadingUpdate.value = true;
    try {
      await _firestore.collection('expenses')
        .doc(data.id)
        .update(data.toJson())
        .timeout(const Duration(seconds: 10));
    } catch (e) {
      isLoadingUpdate.value = false;
      rethrow;
    }
    isLoadingUpdate.value = false;
  }

  void clearInputErrors() {
    titleError.value = null;
    priceError.value = null;
  }
}
