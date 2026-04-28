import 'package:flutter/foundation.dart';
import '../data/models/student.dart';
import '../data/repositories/student_repository.dart';

class StudentController extends ChangeNotifier {
  final StudentRepository _repository;

  StudentController({StudentRepository? repository})
      : _repository = repository ?? StudentRepository();

  Stream<List<Student>> getStudentsStream() {
    return _repository.getStudentsStream();
  }

  Future<void> addStudent(String name, int age, String major) async {
    if (name.isEmpty || major.isEmpty || age <= 0) return;
    await _repository.addStudent(name, age, major);
    notifyListeners();
  }

  Future<void> deleteStudent(String id) async {
    await _repository.deleteStudent(id);
    notifyListeners();
  }
}
