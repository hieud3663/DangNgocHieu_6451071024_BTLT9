import 'package:flutter/material.dart';
import '../../data/models/dashboard_item.dart';
import '../../../widget/dashboard_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      DashboardItem(
        icon: Icons.checklist_outlined,
        iconColor: Colors.blue,
        label: 'Bai 1: To-do List',
        onTap: () => Navigator.pushNamed(context, '/tasks'),
      ),
      DashboardItem(
        icon: Icons.security_outlined,
        iconColor: Colors.orange,
        label: 'Bai 2: Authentication',
        onTap: () => Navigator.pushNamed(context, '/auth'),
      ),
      DashboardItem(
        icon: Icons.school_outlined,
        iconColor: Colors.purple,
        label: 'Bai 3: DSSV (Firestore)',
        onTap: () => Navigator.pushNamed(context, '/students'),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: items.map((item) => DashboardCard(item: item)).toList(),
        ),
      ),
    );
  }
}
