import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import '../color.dart';

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({super.key});

  @override
  _RegisterUserScreenState createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _profileImage;

  Future<void> _registerUser() async {
    final String name = _nameController.text.trim();
    final String password = _passwordController.text.trim();

    if (name.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nama dan password harus diisi!')),
      );
      return;
    }

    final url = Uri.parse(
        'https://backendmobile-927b9-default-rtdb.asia-southeast1.firebasedatabase.app/users.json');

    final Map<String, dynamic> userData = {
      'name': name,
      'password': password,
      'profileImage': _profileImage ?? '',
    };

    try {
      final response = await http.post(
        url,
        body: json.encode(userData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registrasi berhasil!')),
        );
        _nameController.clear();
        _passwordController.clear();
        setState(() {
          _profileImage = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registrasi gagal. Silakan coba lagi.')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $error')),
      );
    }
  }

  Future<void> _pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      String? filePath = result.files.single.path;
      if (filePath != null) {
        setState(() {
          _profileImage = filePath;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Foto profil berhasil dipilih!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Pemilihan foto gagal.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tidak ada file yang dipilih.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: myCustomColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Nama",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFF8348)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: myCustomColor),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFFF8348)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: myCustomColor),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _profileImage != null
                      ? "Foto profil dipilih"
                      : "Belum memilih foto",
                  style: TextStyle(fontSize: 11, color: Colors.black54),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    await _pickFile(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: myCustomColor,
                  ),
                  child: Text("Pilih Foto", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: myCustomColor,
              ),
              onPressed: _registerUser,
              child: Text("Daftar", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

  Future<void> _pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg','png','jpeg'],
    );

    if (result != null) {
      String? filePath = result.files.single.path;
      if (filePath != null && (!filePath.endsWith('.jpg') || !filePath.endsWith('png') || !filePath.endsWith('jpeg'))) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hanya file dengan ekstensi .jpg, .png, atau .jpeg yang diperbolehkan!')),
        );
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File path: $filePath')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No file selected')),
    );
  }
}
