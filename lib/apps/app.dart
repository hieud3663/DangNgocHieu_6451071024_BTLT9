import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view/1/task_list_view.dart';
import '../view/2/login_view.dart';
import '../view/3/student_list_view.dart';
import '../view/dashboard/dashboard_screen.dart';
import '../controllers/task_controller.dart';
import '../controllers/auth_controller.dart';
import '../controllers/student_controller.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskController()),
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => StudentController()),
      ],
      child: MaterialApp(
        title: 'Dashboard App',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const DashboardScreen(),
          '/tasks': (context) => const TaskListView(),
          '/auth': (context) => const LoginView(),
          '/students': (context) => const StudentListView(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        builder: (context, child) => Stack(
          children: [
            child!,
            Positioned(
              top: MediaQuery.of(context).padding.top + 6,
              left: 10,
              child: const Text(
                '6451071024 - Dang Ngoc Hieu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
