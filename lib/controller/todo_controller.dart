import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<Map<String, dynamic>> expenses = <Map<String, dynamic>>[].obs;

  Rx<String?> titleError = Rx<String?>(null);
  Rx<String?> priceError = Rx<String?>(null);
  Rx<bool> isLoadingAdd = Rx<bool>(false);
  Rx<bool> isLoadingUpdate = Rx<bool>(false);
  Rx<bool> isLoadingDelete = Rx<bool>(false);

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() {
    _firestore.collection('expenses').snapshots().listen((snapshot) {
      expenses.value = snapshot.docs
          .map((doc) =>
              {'id': doc.id, 'title': doc['title'], 'price': doc['price']})
          .toList();
    });
  }

  Future<void> addExpense(String title, String price) async {
    isLoadingAdd.value = true;
    try {
      await _firestore.collection('expenses').add({
        'title': title,
        'price': price,
      }).timeout(const Duration(seconds: 10));
    } catch (e) {
      isLoadingAdd.value = false;
      rethrow;
    }
    isLoadingAdd.value = false;
  }

  Future<void> deleteExpense(String id) async {
    isLoadingDelete.value = true;
    try {
      await _firestore
          .collection('expenses')
          .doc(id)
          .delete()
          .timeout(const Duration(seconds: 10));
    } catch (e) {
      isLoadingDelete.value = false;
      rethrow;
    }
    isLoadingDelete.value = false;
  }

  Future<void> updateExpense(
      String id, String newTitle, String newPrice) async {
    isLoadingUpdate.value = true;
    try {
      await _firestore.collection('expenses').doc(id).update({
        'title': newTitle,
        'price': newPrice,
      }).timeout(const Duration(seconds: 10));
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
