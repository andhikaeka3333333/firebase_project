import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<Map<String, dynamic>> expenses = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() {
    _firestore.collection('expenses').snapshots().listen((snapshot) {
      expenses.value = snapshot.docs
          .map((doc) => {'id': doc.id, 'title': doc['title'], 'price': doc['price']})
          .toList();
    });
  }

  Future<void> addExpense(String title, String price) async {
    await _firestore.collection('expenses').add({
      'title': title,
      'price': price,
    });
  }

  // Future<void> updateExpense(String id, String price) async {
  //   await _firestore.collection('expenses').doc(id).update({
  //     'completed': completed,
  //   });
  // }

  Future<void> deleteExpense(String id) async {
    await _firestore.collection('expenses').doc(id).delete();
  }
}
