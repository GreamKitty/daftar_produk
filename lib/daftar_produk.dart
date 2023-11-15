import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProductListPage(),
    );
  }
}

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<Product> products = [
    Product(id: 1, name: 'Bando 08', price: 3000),
    Product(id: 2, name: 'Bando 2 cagak', price: 2000),
    Product(id: 3, name: 'Bando 20 DN', price: 1000),
    Product(id: 4, name: 'Bando 3 daun', price: 2000),
    Product(id: 5, name: 'Bando 30', price: 2000),
    Product(id: 6, name: 'Bando 35', price: 2000),
    Product(id: 7, name: 'Bando 47', price: 3000),
    Product(id: 8, name: 'Bando 50', price: 3000),
    Product(id: 9, name: 'Bando 75', price: 7000),
    Product(id: 10, name: 'Reaver Vandal', price: 190000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text('Harga: Rp ${products[index].price}'),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red, // Ganti warna ikon sesuai keinginan
              ),
              onPressed: () {
                // Panggil fungsi untuk menghapus produk
                _showDeleteDialog(context, index);
              },
            ),
            onTap: () {
              // Tambahkan aksi atau navigasi ke halaman detail jika diperlukan
              // Misalnya: Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(product: products[index])));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Panggil fungsi untuk menambahkan produk baru
          _showAddProductDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showDeleteDialog(BuildContext context, int index) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Penghapusan'),
          content: const Text('Apakah Anda yakin ingin menghapus produk ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                // Panggil fungsi untuk menghapus produk
                _deleteProduct(index);
                Navigator.pop(context);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  Future<void> _showAddProductDialog(BuildContext context) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Produk Baru'),
          content: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nama Produk'),
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Harga'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                // Panggil fungsi untuk menambahkan produk baru
                _addProduct(nameController.text, priceController.text);
                Navigator.pop(context);
              },
              child: const Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  void _addProduct(String name, String price) {
    double newPrice = double.tryParse(price) ?? 0.0;

    setState(() {
      products.add(Product(
        id: products.length + 1,
        name: name,
        price: newPrice,
      ));
    });
  }
}

class Product {
  final int id;
  final String name;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.price,
  });
}
