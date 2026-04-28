import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_baitap_chuong11/data/services/firebase_service.dart';
import '../models/task.dart';

class TaskRepository {
  final CollectionReference _tasksCollection = FirebaseService.db.collection('tasks');

  Stream<List<Task>> getTasksStream() {
    return _tasksCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Task.fromFirestore(doc)).toList();
    });
  }

  Future<void> addTask(String title) async {
    await _tasksCollection.add({
      'title': title,
      'isDone': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateTask(Task task) async {
    await _tasksCollection.doc(task.id).update(task.toFirestore());
  }

  Future<void> deleteTask(String id) async {
    await _tasksCollection.doc(id).delete();
  }

  Future<List<Task>> getAllTasks() async {
    final querySnapshot = await _tasksCollection.orderBy('createdAt', descending: true).get();
    return querySnapshot.docs.map((doc) => Task.fromFirestore(doc)).toList();
  }

  Future<String> exportTasks(List<Task> tasks) async {
    return "Thành công xuất ${tasks.length} task (Chưa hỗ trợ json cho Firebase)";
  }

  Future<bool> importTasks() async {
    return false; 
  }
}
