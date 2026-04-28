import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/student.dart';

class StudentRepository {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('students');

  Stream<List<Student>> getStudentsStream() {
    return _collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Student.fromFirestore(doc)).toList();
    });
  }

  Future<void> addStudent(String name, int age, String major) async {
    await _collection.add({
      'name': name,
      'age': age,
      'major': major,
    });
  }

  Future<void> deleteStudent(String id) async {
    await _collection.doc(id).delete();
  }
}
