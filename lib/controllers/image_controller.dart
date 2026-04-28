import 'package:flutter/foundation.dart';
import '../data/models/shared_image.dart';
import '../data/repositories/image_repository.dart';

class ImageController extends ChangeNotifier {
  final ImageRepository _repository;

  ImageController({ImageRepository? repository})
      : _repository = repository ?? ImageRepository();

  Stream<List<SharedImage>> getImagesStream() {
    return _repository.getImagesStream();
  }

  Future<void> addImage(String imageUrl, String description) async {
    if (imageUrl.isEmpty || description.isEmpty) return;
    await _repository.addImage(imageUrl, description);
    notifyListeners();
  }

  Future<void> deleteImage(String id) async {
    await _repository.deleteImage(id);
    notifyListeners();
  }
}
