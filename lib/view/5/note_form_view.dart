import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/note_controller.dart';
import '../../data/models/note.dart';
import '../../widget/inputdecoration_custom.dart';
import '../../widget/button_custom.dart';

class NoteFormView extends StatefulWidget {
  const NoteFormView({super.key});

  @override
  State<NoteFormView> createState() => _NoteFormViewState();
}

class _NoteFormViewState extends State<NoteFormView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  Note? _existingNote;
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is Note) {
        _existingNote = args;
        _titleController.text = _existingNote!.title;
        _contentController.text = _existingNote!.content;
      }
      _isInit = true;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      final noteController = Provider.of<NoteController>(context, listen: false);
      if (_existingNote == null) {
        noteController.addNote(_titleController.text, _contentController.text);
      } else {
        noteController.updateNote(_existingNote!.id, _titleController.text, _contentController.text);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = _existingNote != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Sửa ghi chú' : 'Thêm ghi chú'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecorationCustom(
                  labelText: 'Tiêu đề',
                  hintText: 'Nhập tiêu đề...',
                ).build(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Vui lòng nhập tiêu đề';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TextFormField(
                  controller: _contentController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecorationCustom(
                    labelText: 'Nội dung',
                    hintText: 'Nhập nội dung...',
                  ).build(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập nội dung';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              ButtonCustom(
                text: isEditing ? 'Cập nhật' : 'Lưu',
                onPressed: _saveNote,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
