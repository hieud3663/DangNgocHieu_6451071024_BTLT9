import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note.dart';

class NoteRepository {
  final CollectionReference _notesCollection =
      FirebaseFirestore.instance.collection('notes');

  Stream<List<Note>> getNotes() {
    return _notesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Note.fromFirestore(doc)).toList();
    });
  }

  Future<void> addNote(Note note) async {
    await _notesCollection.add(note.toFirestore());
  }

  Future<void> updateNote(Note note) async {
    await _notesCollection.doc(note.id).update(note.toFirestore());
  }

  Future<void> deleteNote(String id) async {
    await _notesCollection.doc(id).delete();
  }
}