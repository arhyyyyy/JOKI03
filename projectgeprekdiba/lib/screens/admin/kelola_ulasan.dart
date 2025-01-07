import 'package:flutter/material.dart';
import 'package:projectgeprekdiba/color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kelola Ulasan',
      theme: ThemeData(
        primarySwatch: myCustomColor,
        scaffoldBackgroundColor: Colors.black, // Background hitam
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // Teks putih
        ),
      ),
      home: KelolaUlasanPage(),
    );
  }
}

class KelolaUlasanPage extends StatefulWidget {
  const KelolaUlasanPage({super.key});

  @override
  _KelolaUlasanPageState createState() => _KelolaUlasanPageState();
}

class _KelolaUlasanPageState extends State<KelolaUlasanPage> {
  List<Ulasan> ulasanList = [
    Ulasan('Ayam Geprek Spesial', 'Sila', 'assets/sila.jpg',
        'Ayamnya enak banget!', 5),
    Ulasan('Ayam Geprek Biasa', 'Indah', 'assets/wiwin.jpg',
        'Harganya pas di kantong, cocok buat anak kos haha', 4),
    Ulasan('Ayam Geprek Lengkap', 'Wiwin', 'assets/indah.jpg',
        'Sambalnya memang enak dan pedasnya pas', 4),
  ];

  // Fungsi untuk menghapus ulasan
  void _hapusUlasan(int index) {
    setState(() {
      ulasanList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // hapus tombol kembali
        title: Text('Kelola Ulasan', style: TextStyle(color: Colors.white)),
        backgroundColor: myCustomColor,
      ),
      body: ListView.builder(
        itemCount: ulasanList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            color: Colors.grey[800], // Card background abu
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(ulasanList[index].userImage),
                    radius: 30,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ulasanList[index].username,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Ulasan: ${ulasanList[index].content}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Rating: ${ulasanList[index].rating} ★',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.delete, color: myCustomColor),
                    onPressed: () => _hapusUlasan(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Ulasan {
  final String dishName;
  final String username;
  final String userImage;
  final String content;
  final int rating;

  Ulasan(
      this.dishName, this.username, this.userImage, this.content, this.rating);
}
