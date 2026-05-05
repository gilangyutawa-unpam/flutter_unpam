import 'package:flutter/material.dart';

class ProdukDetail extends StatelessWidget {
  final String kodeProduk;
  final String namaProduk;
  final String hargaProduk;

  const ProdukDetail({
    super.key,
    required this.kodeProduk,
    required this.namaProduk,
    required this.hargaProduk,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detail Produk',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Kode Produk  : ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(kodeProduk),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Nama Produk  : ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(namaProduk),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Harga Produk : ', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(hargaProduk),
              ],
            ),
          ],
        ),
      ),
    );
  }
}