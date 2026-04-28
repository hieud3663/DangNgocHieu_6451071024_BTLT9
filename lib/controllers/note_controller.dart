import 'package:flutter/material.dart';
import '../data/models/note.dart';
import '../data/repositories/note_repository.dart';

class NoteController extends ChangeNotifier {
  final NoteRepository _noteRepository = NoteRepository();

  Stream<List<Note>> get notesStream => _noteRepository.getNotes();

  Future<void> addNote(String title, String content) async {
    final note = Note(id: '', title: title, content: content);
    await _noteRepository.addNote(note);
  }

  Future<void> updateNote(String id, String title, String content) async {
    final note = Note(id: id, title: title, content: content);
    await _noteRepository.updateNote(note);
  }

  Future<void> deleteNote(String id) async {
    await _noteRepository.deleteNote(id);
  }
}