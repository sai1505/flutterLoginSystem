import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LocalUserStorage {
  static Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = "${directory.path}/users.json";
    return File(path);
  }

  static Future<bool> userExists(String email) async {
    final file = await _getFile();
    if (!await file.exists()) return false;

    final content = await file.readAsString();
    if (content.trim().isEmpty) return false;

    final List users = jsonDecode(content);

    return users.any((u) => u['email'] == email);
  }

  static Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final file = await _getFile();
    if (!await file.exists()) return null;

    final content = await file.readAsString();
    if (content.trim().isEmpty) return null;

    final List users = jsonDecode(content);

    for (var u in users) {
      if (u['email'] == email) return u;
    }
    return null;
  }

  static Future<void> saveUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final file = await _getFile();

    // Check if file exists
    if (!await file.exists()) {
      await file.create(recursive: true);
      await file.writeAsString(jsonEncode([])); // create empty array
    }

    // Read existing list
    final String content = await file.readAsString();
    final List<dynamic> users = jsonDecode(content);

    // Add new user
    final Map<String, dynamic> newUser = {
      "name": name,
      "email": email,
      "password": password,
      "createdAt": DateTime.now().toIso8601String(),
    };

    users.add(newUser);

    // Save back to file
    await file.writeAsString(jsonEncode(users));
  }
}
