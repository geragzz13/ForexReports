import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app_database.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
    print('Database path: $path'); // Log the database location

    return openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onOpen: (db) {
        print('Database opened successfully.');
      },
    );
  }

  Future<void> _createDB(Database db, int version) async {
    print('Creating database schema...');
    try {
      await db.execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT UNIQUE,
          password TEXT,
          role TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE reports (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          type TEXT,
          content TEXT,
          created_at TEXT
        )
      ''');

      print('Database schema created successfully.');
    } catch (e) {
      print('Error creating database schema: $e');
    }
  }

  // Insert a new user
  Future<int> insertUser(String username, String password, String role) async {
    final db = await database;

    // Hash the password before storing it
    final hashedPassword = sha256.convert(utf8.encode(password)).toString();
    print('Inserting user: $username with hashed password: $hashedPassword');

    try {
      return await db.insert('users', {
        'username': username,
        'password': hashedPassword,
        'role': role,
      });
    } catch (e) {
      print('Error inserting user $username: $e');
      return -1; // Return -1 to indicate an error
    }
  }

  // Add test accounts
  Future<void> addTestAccounts() async {
    final db = await database;

    const testAccounts = [
      {'username': 'admin', 'password': 'admin123', 'role': 'admin'},
      {'username': 'testuser', 'password': 'test123', 'role': 'admin'}
    ];

    for (var account in testAccounts) {
      final exists = await userExists(account['username']!);
      if (!exists) {
        final result = await insertUser(
          account['username']!,
          account['password']!,
          account['role']!,
        );
        if (result > 0) {
          print('Test account ${account['username']} added successfully.');
        } else {
          print('Failed to add test account ${account['username']}.');
        }
      } else {
        print('Test account ${account['username']} already exists.');
      }
    }
  }

  // Authenticate a user
  Future<Map<String, dynamic>?> authenticateUser(
      String username, String password) async {
    final db = await database;

    // Hash the password for comparison
    final hashedPassword = sha256.convert(utf8.encode(password)).toString();
    print(
        'Authenticating user: $username with hashed password: $hashedPassword');

    try {
      final result = await db.query(
        'users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, hashedPassword],
      );

      if (result.isNotEmpty) {
        print('User $username authenticated successfully.');
        return result.first;
      } else {
        print(
            'Authentication failed for user $username. Stored hash may not match.');
        return null;
      }
    } catch (e) {
      print('Error authenticating user $username: $e');
      return null;
    }
  }

  // Fetch all users
  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    try {
      final users = await db.query('users');
      print('Fetched ${users.length} users.');
      return users;
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  // Delete all users (for testing purposes)
  Future<void> deleteAllUsers() async {
    final db = await database;
    try {
      await db.delete('users');
      print('All users deleted successfully.');
    } catch (e) {
      print('Error deleting users: $e');
    }
  }

  // Check if a user exists
  Future<bool> userExists(String username) async {
    final db = await database;
    try {
      final result = await db.query(
        'users',
        where: 'username = ?',
        whereArgs: [username],
      );
      return result.isNotEmpty;
    } catch (e) {
      print('Error checking if user $username exists: $e');
      return false;
    }
  }

  // Save a new report
  Future<int> saveReport(String type, String content) async {
    final db = await database;

    try {
      return await db.insert('reports', {
        'type': type,
        'content': content,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Error saving report: $e');
      return -1;
    }
  }

  // Fetch all reports
  Future<List<Map<String, dynamic>>> fetchReports() async {
    final db = await database;

    try {
      final reports = await db.query('reports');
      print('Fetched ${reports.length} reports.');
      return reports;
    } catch (e) {
      print('Error fetching reports: $e');
      return [];
    }
  }

  // Fetch reports by type
  Future<List<Map<String, dynamic>>> fetchReportsByType(String type) async {
    final db = await database;

    try {
      final reports = await db.query(
        'reports',
        where: 'type = ?',
        whereArgs: [type],
      );
      print('Fetched ${reports.length} reports of type $type.');
      return reports;
    } catch (e) {
      print('Error fetching reports of type $type: $e');
      return [];
    }
  }
}
