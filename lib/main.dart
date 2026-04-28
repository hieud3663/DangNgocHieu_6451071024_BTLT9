import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'apps/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("Firebase init error: $e");
  }
  runApp(const MainApp());
}

@Preview(size: Size(300, 500))
Widget previewMainApp() => const MainApp();