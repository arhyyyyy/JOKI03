import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../color.dart';
import 'admin/home_admin.dart';
import 'user/home_user.dart';
import 'register_user_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<bool> isSelected = [true, false];
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showSnackBar(context, "Username dan password harus diisi.");
      return;
    }

    // Logika khusus untuk Admin (hardcoded username dan password)
    if (username == "Admin" && password == "Admin123") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePageAdmin()),
      );
      return; // Langsung keluar dari fungsi setelah berhasil login sebagai Admin
    }

    // URL untuk memeriksa user di Firebase
    final url = Uri.parse(
        'https://backendmobile-927b9-default-rtdb.asia-southeast1.firebasedatabase.app/users.json');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        bool found = false;

        // Iterasi setiap user dalam database
        data.forEach((key, value) {
          // Cek jika username dan password sesuai
          if (value['name'] == username && value['password'] == password) {
            found = true;
            
            // Arahkan ke halaman User
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePageUser()),
            );
          }
        });

        if (!found) {
          _showSnackBar(context, "Username atau password salah.");
        }
      } else {
        _showSnackBar(context, "Terjadi kesalahan pada server. Coba lagi.");
      }
    } catch (e) {
      _showSnackBar(context, "Terjadi kesalahan: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo di tengah
                  Center(
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage('assets/admin_profile.jpg'),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Pilihan login sebagai Admin atau User
                  Center(
                    child: ToggleButtons(
                      isSelected: isSelected,
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < isSelected.length; i++) {
                            isSelected[i] = i == index;
                          }
                        });
                      },
                      borderRadius: BorderRadius.circular(10),
                      selectedColor: Colors.white,
                      fillColor: myCustomColor,
                      color: Colors.grey.shade600,
                      textStyle: TextStyle(fontSize: 14, color: Colors.black),
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text("User"),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text("Admin"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),

                  // Username input
                  TextField(
                    controller: _usernameController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Username",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: myCustomColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: myCustomColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Password input
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Password",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: myCustomColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: myCustomColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // Button Masuk
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: myCustomColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      await _login(context);
                    },
                    child: Text("Masuk", style: TextStyle(color: Colors.white)),
                  ),

                  SizedBox(height: 10),
                  Center(
                      child: Column(children: [
                    Text(
                      "Belum punya akun?",
                      style: TextStyle(color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterUserScreen()),
                        );
                      },
                      child: Text(
                        "Tekan Teks Ini Untuk Mendaftar",
                        style: TextStyle(
                          color: Color(0xFFFF7417),
                          decorationThickness: 1.5,
                        ),
                      ),
                    ),
                  ])),
                ])));
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
