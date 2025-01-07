import 'package:flutter/material.dart';
import 'package:projectgeprekdiba/color.dart';

class HistoriPesananPage extends StatelessWidget {
  const HistoriPesananPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // hapus tombol kembali
        title: const Text('Histori Pesanan', style: TextStyle(color: Colors.white)),
        backgroundColor: myCustomColor,
      ),
      body: ListView(
        children: [
          PesananItem(
            title: 'Ayam Geprek Spesial',
            price: 20000,
            status: 'Diproses',
          ),
          PesananItem(
            title: 'Ayam Geprek Istimewa',
            price: 30000,
            status: 'Dikirim',
          ),
          PesananItem(
            title: 'Ayam Geprek Premium',
            price: 35000,
            status: 'Diterima',
          ),
          PesananItem(
            title: 'Ayam Geprek Lengkap',
            price: 25000,
            status: 'Selesai',
          ),
        ],
      ),
    );
  }
}

class PesananItem extends StatelessWidget {
  final String title;
  final int price;
  final String status;

  const PesananItem({
    super.key,
    required this.title,
    required this.price,
    required this.status,
  });

  // Fungsi untuk mendapatkan progress berdasarkan status
  double getProgress(String status) {
    switch (status) {
      case 'Diproses':
        return 0.3;
      case 'Dikirim':
        return 0.6;
      case 'Diterima':
        return 0.9;
      case 'Selesai':
        return 1.0;
      default:
        return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = getProgress(status);

    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text('Harga: Rp $price'),
            const SizedBox(height: 5),
            Text(
              status,
              style: TextStyle(
                color: myCustomColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: myCustomColor,
            ),
          ],
        ),
      ),
    );
  }
}
