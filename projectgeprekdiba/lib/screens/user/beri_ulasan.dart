import 'package:flutter/material.dart';
import 'package:projectgeprekdiba/color.dart';

class BeriUlasanPage extends StatelessWidget {
  const BeriUlasanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // hapus tombol kembali
        title: const Text('Beri Ulasan', style: TextStyle(color: Colors.white)),
        backgroundColor: myCustomColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                      backgroundImage: AssetImage('assets/menu3.jpg'),
                      radius: 42,
                ),

                  const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Menu: Ayam Geprek Lengkap',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text('Harga: Rp 25.000'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Tulis Ulasan Anda',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Logika kirim ulasan
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ulasan berhasil dikirim!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: myCustomColor,
              ),
              child: const Text(
                'Kirim Ulasan',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
