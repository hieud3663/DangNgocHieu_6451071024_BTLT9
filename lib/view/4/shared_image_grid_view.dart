import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/image_controller.dart';
import '../../data/models/shared_image.dart';
import 'shared_image_form_view.dart';

class SharedImageGridView extends StatelessWidget {
  const SharedImageGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ImageController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery Chia Sẻ'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<SharedImage>>(
        stream: controller.getImagesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Chưa có ảnh nào được chia sẻ.'));
          }

          final images = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.8, // Điều chỉnh tỉ lệ hiển thị ảnh chữ nhật
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              final img = images[index];
              return Card(
                elevation: 3,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      img.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        color: Colors.black.withValues(alpha: 0.6),
                        child: Text(
                          img.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white, fontSize: 13),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () async {
                          // Xác nhận xoá
                          bool confirm = await showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Xác nhận xóa'),
                                  content: const Text('Bạn có chắc muốn xóa ảnh này?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, false),
                                      child: const Text('Hủy'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => Navigator.pop(context, true),
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                      child: const Text('Xóa', style: TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ) ??
                              false;
                          if (confirm) {
                            await controller.deleteImage(img.id);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Xóa ảnh thành công')),
                              );
                            }
                          }
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white70,
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(Icons.delete, color: Colors.red, size: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SharedImageFormView()),
          );
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
