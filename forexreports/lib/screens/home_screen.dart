import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _output = 'Press the button to test the database.';

  Future<void> _testDatabase() async {
    // Debugging: Ensure function is being called
    print('Testing database...');

    try {
      final dbPath = await getDatabasesPath(); // Get the database path
      print('Database path: $dbPath');
      // Update the output and trigger a rebuild
      setState(() {
        _output = 'Database path: $dbPath';
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _output = 'Error: $e'; // Display error message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Building HomeScreen with output: $_output');
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Forex Reports'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _testDatabase,
              child: const Text('Test Database'),
            ),
            const SizedBox(height: 20),
            Text(
              _output, // Bind _output to the UI
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
