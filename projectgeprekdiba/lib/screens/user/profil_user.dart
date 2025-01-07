import 'package:flutter/material.dart';
import 'package:projectgeprekdiba/color.dart';
import 'package:projectgeprekdiba/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil User',
      theme: ThemeData(
        primarySwatch: myCustomColor,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: ProfilUserPage(),
    );
  }
}

class ProfilUserPage extends StatefulWidget {
  const ProfilUserPage({super.key});

  @override
  _ProfilUserPageState createState() => _ProfilUserPageState();
}

class _ProfilUserPageState extends State<ProfilUserPage> {
  // Data user (dapat diubah saat pengeditan)
  String _userName = 'User Name';
  String _userEmail = 'user@contoh.com';
  final String _userProfileImage = 'assets/wiwin.jpg';

  // Controller untuk mengedit nama dan email
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Fungsi untuk mengedit nama dan email
  void _editProfile() {
    setState(() {
      _userName = _nameController.text;
      _userEmail = _emailController.text;
    });
  }

  // Fungsi untuk logout
  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Apakah Anda yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              // Di sini bisa menambahkan logika untuk logout (seperti menghapus session)
              Navigator.pop(context); // Tutup dialog
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => LoginPage()));
            },
            child: Text('Ya'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // hapus tombol kembali
          title: Text('Profil User', style: TextStyle(color: Colors.white)),
          backgroundColor: myCustomColor,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Card(
                    color: myCustomColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 50.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 50), // Space for the CircleAvatar
                          Text(
                            _userName,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          SizedBox(height: 3),
                          Text(
                            _userEmail,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -50,
                    left: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        _userProfileImage,
                      ),
                      radius: 60,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                  onPressed: () {
                    _nameController.text = _userName;
                    _emailController.text = _userEmail;
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Edit Profil'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: _nameController,
                              decoration: InputDecoration(labelText: 'Nama'),
                            ),
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(labelText: 'Email'),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () {
                              _editProfile();
                              Navigator.pop(context);
                            },
                            child: Text('Simpan'),
                          ),
                        ],
                      ),
                    );
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: myCustomColor),
                  child: Text('Edit Profil',
                      style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _logout,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: myCustomColor),
                  child: Text('Logout', style: TextStyle(color: Colors.white)),
                ),
              ]),
            ]),
          ),
        ));
  }
}
