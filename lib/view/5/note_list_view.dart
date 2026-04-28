import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/note_controller.dart';
import '../../data/models/note.dart';

class NoteListView extends StatelessWidget {
  const NoteListView({super.key});

  @override
  Widget build(BuildContext context) {
    final noteController = Provider.of<NoteController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài 5: Ghi chú Offline'),
      ),
      body: StreamBuilder<List<Note>>(
        stream: noteController.notesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          }

          final notes = snapshot.data ?? [];

          if (notes.isEmpty) {
            return const Center(child: Text('Chưa có ghi chú nào. Mất mạng vẫn có thể tạo nhé!'));
          }

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: ListTile(
                  title: Text(note.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    note.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => noteController.deleteNote(note.id),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/note-form',
                      arguments: note,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/note-form');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
