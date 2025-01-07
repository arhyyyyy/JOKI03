import 'package:flutter/material.dart';
import 'package:projectgeprekdiba/color.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // hapus tombol kembali
        title: const Text('Daftar Menu', style: TextStyle(color: Colors.white)),
        backgroundColor: myCustomColor,
      ),
      body: ListView(
        children: [
          MenuItem(
            image: 'assets/menu1.jpg',
            title: 'Ayam Geprek Biasa',
            description: 'Ayam geprek + nasi.',
            price: 18000,
          ),
          MenuItem(
            image: 'assets/menu2.jpg',
            title: 'Ayam Geprek Spesial',
            description: 'Ayam geprek + mie goreng.',
            price: 20000,
          ),
          MenuItem(
            image: 'assets/menu3.jpg',
            title: 'Ayam Geprek Lengkap',
            description: 'Ayam geprek + nasi + mie goreng.',
            price: 25000,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Handle cart checkout
        },
        label: const Text('Checkout', style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.shopping_cart, color: Colors.white),
        backgroundColor: myCustomColor,
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final int price;

  const MenuItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Image.asset(image, width: 50, height: 50),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Text('Rp $price', style: const TextStyle(color: Color(0xFFFF7417), fontWeight: FontWeight.bold)),
        onTap: () {
          // Add item to cart
        },
      ),
    );
  }
}