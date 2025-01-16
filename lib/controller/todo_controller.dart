import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<Map<String, dynamic>> expenses = <Map<String, dynamic>>[].obs;

  Rx<bool> isLoadingAdd = Rx<bool>(false);

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
    await _firestore.collection('expenses').doc(id).delete();
  }

  Future<void> updateExpense(
      String id, String newTitle, String newPrice) async {
    await _firestore.collection('expenses').doc(id).update({
      'title': newTitle,
      'price': newPrice,
    });
  }
}
