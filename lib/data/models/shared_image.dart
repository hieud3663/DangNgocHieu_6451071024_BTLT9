import 'package:cloud_firestore/cloud_firestore.dart';

class SharedImage {
  final String id;
  final String imageUrl;
  final String description;

  SharedImage({
    required this.id,
    required this.imageUrl,
    required this.description,
  });

  factory SharedImage.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return SharedImage(
      id: doc.id,
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'imageUrl': imageUrl,
      'description': description,
    };
  }
}
