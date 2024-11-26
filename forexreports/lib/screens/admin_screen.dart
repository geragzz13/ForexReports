import 'package:flutter/material.dart';
import 'user_management_screen.dart';
import 'reportsHub_screen.dart'; // Import the correct ReportHubScreen file

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _selectedIndex = 0;

  // Pages for each menu item
  final List<Widget> _pages = [
    const WeeklyReportsPage(),
    const UserManagementScreen(),
    const ReportsHubScreen(), // Ensure this is the correct screen class
  ];

  // Handle menu item tap
  void _onMenuTap(int index) {
    if (index < _pages.length) {
      setState(() {
        _selectedIndex = index;
        Navigator.pop(context); // Close the drawer
      });
    }
  }

  // Handle logout functionality
  void _logout() {
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Administrador'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menú Admin',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Reportes Semanales'),
              onTap: () => _onMenuTap(0),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Gestionar Usuarios'),
              onTap: () => _onMenuTap(1),
            ),
            ListTile(
              leading: const Icon(Icons.note_add),
              title: const Text('Crear Reporte'),
              onTap: () => _onMenuTap(2),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar Sesión'),
              onTap: _logout,
            ),
          ],
        ),
      ),
      // Display the selected page
      body: _pages[_selectedIndex],
    );
  }
}

// Placeholder for Weekly Reports Page
class WeeklyReportsPage extends StatelessWidget {
  const WeeklyReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Reportes Semanales',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Esta página mostrará los reportes semanales del administrador.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
