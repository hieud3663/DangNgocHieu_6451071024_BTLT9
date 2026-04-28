import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/image_controller.dart';

class SharedImageFormView extends StatefulWidget {
  const SharedImageFormView({super.key});

  @override
  State<SharedImageFormView> createState() => _SharedImageFormViewState();
}

class _SharedImageFormViewState extends State<SharedImageFormView> {
  final _urlController = TextEditingController();
  final _descController = TextEditingController();

  void _saveImage() async {
    final imageUrl = _urlController.text.trim();
    final description = _descController.text.trim();

    if (imageUrl.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng điền đủ URL và Mô tả')),
      );
      return;
    }

    final controller = context.read<ImageController>();
    await controller.addImage(imageUrl, description);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã thêm ảnh!')),
      );
      Navigator.pop(context); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm Ảnh Chia Sẻ'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Icon(Icons.add_photo_alternate, size: 80, color: Colors.teal),
              const SizedBox(height: 24),
              TextField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'URL hiển thị ảnh (https://...)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.link),
                ),
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Mô tả hình ảnh',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('LƯU', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
