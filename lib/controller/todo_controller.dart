import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxList<Map<String, dynamic>> todos = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodos();
  }

  void fetchTodos() {
    _firestore.collection('todos').snapshots().listen((snapshot) {
      todos.value = snapshot.docs
          .map((doc) => {'id': doc.id, 'title': doc['title'], 'completed': doc['completed']})
          .toList();
    });
  }

  Future<void> addTodo(String title) async {
    await _firestore.collection('todos').add({
      'title': title,
      'completed': false,
    });
  }

  Future<void> updateTodo(String id, bool completed) async {
    await _firestore.collection('todos').doc(id).update({
      'completed': completed,
    });
  }

  Future<void> deleteTodo(String id) async {
    await _firestore.collection('todos').doc(id).delete();
  }
}
