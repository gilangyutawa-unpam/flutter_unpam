import 'package:flutter/material.dart';
import 'package:flutter_unpam/ui/produk_form.dart';

class Pertemuan3Page extends StatelessWidget {
  const Pertemuan3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pertemuan 3"),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProdukForm()),
            );
          },
          child: const Text("Buka Form Produk"),
        ),
      ),
    );
  }
}
