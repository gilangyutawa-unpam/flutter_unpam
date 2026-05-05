import 'package:flutter/material.dart';
import 'package:flutter_unpam/ui/produk_detail.dart';

class ProdukForm extends StatefulWidget {
  const ProdukForm({super.key}); // ✅ HARUS const

  @override
  State<ProdukForm> createState() => _ProdukFormState();
}

class _ProdukFormState extends State<ProdukForm> {
  final TextEditingController kodeController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();

  void submit() {
    if (kodeController.text.isEmpty ||
        namaController.text.isEmpty ||
        hargaController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Semua data harus diisi!")));
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProdukDetail(
          kodeProduk: kodeController.text,
          namaProduk: namaController.text,
          hargaProduk: hargaController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Produk")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: kodeController,
              decoration: const InputDecoration(labelText: "Kode Produk"),
            ),
            TextField(
              controller: namaController,
              decoration: const InputDecoration(labelText: "Nama Produk"),
            ),
            TextField(
              controller: hargaController,
              decoration: const InputDecoration(labelText: "Harga Produk"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: submit, child: const Text("Simpan")),
          ],
        ),
      ),
    );
  }
}
