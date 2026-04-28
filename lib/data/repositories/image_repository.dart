import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/shared_image.dart';

class ImageRepository {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('images');

  Stream<List<SharedImage>> getImagesStream() {
    return _collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => SharedImage.fromFirestore(doc)).toList();
    });
  }

  Future<void> addImage(String imageUrl, String description) async {
    await _collection.add({
      'imageUrl': imageUrl,
      'description': description,
    });
  }

  Future<void> deleteImage(String id) async {
    await _collection.doc(id).delete();
  }
}
