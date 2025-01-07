import 'package:flutter/material.dart';
import 'package:projectgeprekdiba/color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kelola Pesanan',
      theme: ThemeData(
        primarySwatch: myCustomColor,
        scaffoldBackgroundColor: Colors.black, // Background hitam
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white), // Teks putih
        ),
      ),
      home: KelolaPesananPage(),
    );
  }
}

class KelolaPesananPage extends StatefulWidget {
  const KelolaPesananPage({super.key});

  @override
  _KelolaPesananPageState createState() => _KelolaPesananPageState();
}

class _KelolaPesananPageState extends State<KelolaPesananPage> {
  List<Pesanan> pesananList = [
    Pesanan('Ayam Geprek Biasa', 'assets/menu1.jpg', 'Diproses', 18000),
    Pesanan('Ayam Geprek Spesial', 'assets/menu2.jpg', 'Dikirim', 20000),
    Pesanan('Ayam Geprek Lengkap', 'assets/menu3.jpg', 'Selesai', 25000),
    Pesanan('Ayam Geprek Biasa', 'assets/menu1.jpg', 'Selesai', 18000),
    Pesanan('Ayam Geprek Lengkap', 'assets/menu3.jpg', 'Diterima', 25000),
  ];

  final Map<String, int> statusOrder = {
    'Diproses': 0,
    'Dikirim': 1,
    'Diterima': 2,
    'Selesai': 3,
  };

  @override
  Widget build(BuildContext context) {
    // Urutkan pesanan berdasarkan status
    pesananList.sort(
        (a, b) => statusOrder[a.status]!.compareTo(statusOrder[b.status]!));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // hapus tombol kembali
        title: Text('Kelola Pesanan', style: TextStyle(color: Colors.white)),
        backgroundColor: myCustomColor,
      ),
      body: ListView.builder(
        itemCount: pesananList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            color: Colors.grey[800], // Card background hitam
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset(
                    pesananList[index].imagePath,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pesananList[index].name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Harga: Rp ${pesananList[index].price}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Status: ${pesananList[index].status}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (status) {
                      setState(() {
                        pesananList[index].status = status;
                        pesananList.sort((a, b) => statusOrder[a.status]!
                            .compareTo(statusOrder[b.status]!));
                      });
                    },
                    icon: Icon(Icons.more_vert, color: myCustomColor),
                    itemBuilder: (context) {
                      return ['Diproses', 'Dikirim', 'Diterima', 'Selesai']
                          .map((status) => PopupMenuItem<String>(
                                value: status,
                                child: Text(status),
                              ))
                          .toList();
                    },
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

class Pesanan {
  final String name;
  final String imagePath;
  String status;
  final int price;

  Pesanan(this.name, this.imagePath, this.status, this.price);
}
