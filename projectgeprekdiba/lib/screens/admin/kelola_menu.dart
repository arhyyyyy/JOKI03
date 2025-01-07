import 'package:flutter/material.dart';
import '../../color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kelola Menu',
      home: KelolaMenuPage(),
    );
  }
}

class KelolaMenuPage extends StatefulWidget {
  const KelolaMenuPage({super.key});

  @override
  _KelolaMenuPageState createState() => _KelolaMenuPageState();
}

class _KelolaMenuPageState extends State<KelolaMenuPage> {
  List<Menu> menuList = [
    Menu('Ayam Geprek Biasa', 'assets/menu1.jpg', 18000,
        'Ayam geprek + nasi'),
    Menu('Ayam Geprek Spesial', 'assets/menu2.jpg', 20000,
        'Ayam geprek + mie goreng'),
    Menu('Ayam Geprek Lengkap', 'assets/menu3.jpg', 25000,
        'Ayam geprek + nasi + mie goreng'),
    ];

  // Fungsi untuk menambah menu
  void _addMenu() {
    setState(() {
      menuList.add(Menu(
          'Menu Baru', 'assets/default.jpg', 10000, 'Keterangan menu baru'));
    });
  }

  // Fungsi untuk mengedit menu
  void _editMenu(int index) {
    setState(() {
      menuList[index] = Menu(
          'Menu Diedit', 'assets/default.jpg', 18000, 'Keterangan menu diedit');
    });
  }

  // Fungsi untuk menghapus menu
  void _deleteMenu(int index) {
    setState(() {
      menuList.removeAt(index);
    });
  }

  // Pilihan untuk Dropdown (1-5)
  String _selectedMenuQuantity = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // hapus tombol kembali
        title: Text('Kelola Menu', style: TextStyle(color: Colors.white)),
        backgroundColor: myCustomColor,
      ),
      body: ListView.builder(
        itemCount: menuList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            color: Colors.grey[800],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Image.asset(
                    menuList[index].imagePath,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        menuList[index].name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Harga: Rp ${menuList[index].price}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      // Keterangan menu
                      Text(
                        'Keterangan: ${menuList[index].description}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      // Dropdown untuk jumlah menu (1-5)
                      DropdownButton<String>(
                        value: _selectedMenuQuantity,
                        icon: Icon(Icons.arrow_drop_down, color: myCustomColor),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        dropdownColor: Colors.grey[800],
                        underline: Container(
                          height: 2,
                          color: myCustomColor,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedMenuQuantity = newValue!;
                          });
                        },
                        items: <String>['1', '2', '3', '4', '5']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              'Level Pedas: $value',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.edit, color: myCustomColor),
                    onPressed: () => _editMenu(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: myCustomColor),
                    onPressed: () => _deleteMenu(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMenu,
        backgroundColor: myCustomColor,
        tooltip: 'Tambah Menu',
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class Menu {
  final String name;
  final String imagePath;
  final int price;
  final String description;

  Menu(this.name, this.imagePath, this.price, this.description);
}
