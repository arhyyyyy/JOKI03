import 'package:flutter/material.dart';
import 'package:projectgeprekdiba/color.dart';

import 'menu_page.dart';
import 'histori_pesanan.dart';
import 'beri_ulasan.dart';
import 'profil_user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HomeUser',
      home: HomePageUser(),
    );
  }
}

class HomePageUser extends StatefulWidget {
  const HomePageUser({super.key});

  @override
  _HomePageUserState createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  int _selectedIndex = 0;

  // Daftar pilihan untuk halaman
  static final List<Widget> _widgetOptions = <Widget>[
    KelolaBerandaUserPage(),
    MenuPage(),
    HistoriPesananPage(),
    BeriUlasanPage(),
    ProfilUserPage()
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
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Histori Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rate_review),
            label: 'Beri Ulasan',
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

class KelolaBerandaUserPage extends StatelessWidget {
  const KelolaBerandaUserPage({super.key});

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
          'Halo, Nama User.',
          style: TextStyle(fontSize: 24, color: Colors.black),),
          Text(
          'Selamat Datang di Aplikasi Penjualan Ayam Geprek Diba!',
          style: TextStyle(fontSize: 24, color: myCustomColor[500]),
        ),])
      ),
    );
  }
}
