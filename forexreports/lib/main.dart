import 'package:flutter/material.dart';
import 'package:forexreports/database/database_helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:forexreports/screens/login_screen.dart'; // Import LoginScreen

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize sqflite_common_ffi for desktop platforms
  if (!kIsWeb) {
    sqfliteFfiInit(); // Initialize ffi
    databaseFactory =
        databaseFactoryFfi; // Set the database factory for desktop
  }

  // Explicitly initialize the database
  final dbHelper = DatabaseHelper.instance;
  final db = await dbHelper.database; // Ensures the database is opened
  print('Database initialized at: ${db.path}');

  // Add test accounts to the database
  await dbHelper.addTestAccounts();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
