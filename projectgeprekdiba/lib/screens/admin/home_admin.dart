import 'package:flutter/material.dart';
import 'kelola_menu.dart'; 
import 'kelola_pesanan.dart';
import 'kelola_ulasan.dart';
import 'profil_admin.dart';
import '../../color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HomeAdmin',
      home: HomePageAdmin(),
    );
  }
}

class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({super.key});

  @override
  _HomePageAdminState createState() => _HomePageAdminState();
}

class _HomePageAdminState extends State<HomePageAdmin> {
  int _selectedIndex = 0;

  // Daftar pilihan untuk halaman
  static final List<Widget> _widgetOptions = <Widget>[
    KelolaBerandaAdminPage(),
    KelolaMenuPage(),
    KelolaPesananPage(),
    KelolaUlasanPage(),
    ProfilAdminPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Kelola Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Kelola Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rate_review),
            label: 'Kelola Ulasan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: myCustomColor,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

class KelolaBerandaAdminPage extends StatelessWidget {
  const KelolaBerandaAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // hapus tombol kembali
        title: const Text('Beranda', style: TextStyle(color: Colors.white)),
        backgroundColor: myCustomColor,
      ),
      body: Center( 
        child: Column( 
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          
          children: [
          Text(
          'Halo, Admin.',
          style: TextStyle(fontSize: 24, color: Colors.black),),
          Text(
          'Selamat Datang di Aplikasi Penjualan Ayam Geprek Diba!',
          style: TextStyle(fontSize: 24, color: myCustomColor[500]),
        ),])
      ),
    );
  }
}
