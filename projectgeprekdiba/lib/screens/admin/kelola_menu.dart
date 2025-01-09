import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../color.dart';

class KelolaMenuPage extends StatefulWidget {
  const KelolaMenuPage({super.key});

  @override
  _KelolaMenuPageState createState() => _KelolaMenuPageState();
}

class _KelolaMenuPageState extends State<KelolaMenuPage> {
  List<Menu> menuList = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchMenuData();
  }

  // URL untuk Firebase Realtime Database
  final String databaseUrl = 'https://backendmobile-927b9-default-rtdb.asia-southeast1.firebasedatabase.app/menu.json';

  // Fungsi untuk mengambil data menu dari Firebase
  Future<void> _fetchMenuData() async {
    try {
      final response = await http.get(Uri.parse(databaseUrl));
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> data = json.decode(response.body);
          if (data.isNotEmpty) {
            final List<Menu> loadedMenuList = [];
            data.forEach((id, menuData) {
              loadedMenuList.add(Menu(
                menuData['name'],
                menuData['imagePath'],
                menuData['price'],
                menuData['description'],
                id: id,
              ));
            });
            if (mounted) {
              setState(() {
                menuList = loadedMenuList;
              });
            }
          } else {
            if (mounted) {
              setState(() {
                menuList = [];
              });
            }
          }
        } else {
          if (mounted) {
            setState(() {
              menuList = [];
            });
          }
        }
      } else {
        if (mounted) {
          setState(() {
            menuList = [];
          });
        }
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          menuList = [];
        });
      }
    }
  }

  // Fungsi untuk menambah menu
  void _addMenu() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Menu'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama Menu'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                final newMenu = Menu(
                  _nameController.text,
                  'assets/default.jpg',
                  int.parse(_priceController.text),
                  _descriptionController.text,
                );

                final response = await http.post(
                  Uri.parse(databaseUrl),
                  body: json.encode({
                    'name': newMenu.name,
                    'imagePath': newMenu.imagePath,
                    'price': newMenu.price,
                    'description': newMenu.description,
                  }),
                );

                if (response.statusCode == 200) {
                  _fetchMenuData(); // Reload data after adding
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  throw Exception('Failed to add menu');
                }
              },
              child: Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk mengedit menu
  void _editMenu(String id) async {
    final menu = menuList.firstWhere((menu) => menu.id == id);

    _nameController.text = menu.name;
    _descriptionController.text = menu.description;
    _priceController.text = menu.price.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Menu'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama Menu'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Deskripsi'),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Harga'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                final editedMenu = Menu(
                  _nameController.text,
                  'assets/default.jpg',
                  int.parse(_priceController.text),
                  _descriptionController.text,
                  id: id,
                );

                final url = 'https://backendmobile-927b9-default-rtdb.asia-southeast1.firebasedatabase.app/menu/$id.json';

                final response = await http.patch(
                  Uri.parse(url),
                  body: json.encode({
                    'name': editedMenu.name,
                    'imagePath': editedMenu.imagePath,
                    'price': editedMenu.price,
                    'description': editedMenu.description,
                  }),
                );

                if (response.statusCode == 200) {
                  _fetchMenuData(); // Reload data after editing
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  throw Exception('Failed to edit menu');
                }
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk menghapus menu
  void _deleteMenu(String id) async {
    final url = 'https://backendmobile-927b9-default-rtdb.asia-southeast1.firebasedatabase.app/menu/$id.json';

    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      _fetchMenuData(); // Reload data after deletion
    } else {
      throw Exception('Failed to delete menu');
    }
  }

  String _selectedMenuQuantity = '1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
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
                        Text(
                          'Keterangan: ${menuList[index].description}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
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
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: myCustomColor),
                    onPressed: () => _editMenu(menuList[index].id),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: myCustomColor),
                    onPressed: () => _deleteMenu(menuList[index].id),
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
  final String id;

  Menu(this.name, this.imagePath, this.price, this.description, {this.id = ''});
}
