import 'package:flutter/material.dart';
import 'package:forexreports/util/app_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.dark,
      appBar: AppBar(
        title: const Text('Forex Reports'),
        backgroundColor: AppTheme.accent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to Forex Reports",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _mainButton(() => null, 'Create New Report'),
                Row(
                  children: [
                    _actionButton(() => null, Icons.file_upload, 'Upload File'),
                    const SizedBox(width: 8),
                    _actionButton(() => null, Icons.folder, 'Open Folder'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Center(
                child: const Text(
                  'No Reports Found',
                  style: TextStyle(
                    color: AppTheme.medium,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => null,
        backgroundColor: AppTheme.accent,
        child: const Icon(Icons.add),
      ),
    );
  }

  ElevatedButton _mainButton(Function()? onPressed, String text) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _buttonStyle(),
      child: Text(text),
    );
  }

  Widget _actionButton(Function()? onPressed, IconData icon, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: IconButton(
        onPressed: onPressed,
        splashRadius: 20,
        splashColor: AppTheme.accent,
        icon: Icon(
          icon,
          color: AppTheme.medium,
        ),
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: AppTheme.accent,
      foregroundColor: AppTheme.dark,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      disabledBackgroundColor: AppTheme.disabledBackgroundColor,
      disabledForegroundColor: AppTheme.disabledForegroundColor,
    );
  }
}
