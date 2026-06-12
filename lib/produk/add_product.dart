// lib/produk/add_product.dart
import 'package:flutter/material.dart';
import 'package:flutter_unpam/service/api_service.dart';

class AddProduct extends StatefulWidget {
  final dynamic product; // Menampung objek produk saat mode Edit

  const AddProduct({super.key, this.product});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _imageController = TextEditingController();

  bool _isLoading = false;
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    // Deteksi jika data produk ada, maka masuk ke Mode Edit
    if (widget.product != null) {
      _isEditMode = true;

      // Mengantisipasi pembacaan dari object model maupun map json dinamis
      _nameController.text =
          widget.product.name ?? widget.product['name'] ?? '';
      _descriptionController.text =
          widget.product.descriptions ?? widget.product['descriptions'] ?? '';
      _priceController.text =
          (widget.product.price ?? widget.product['price'] ?? 0).toString();
      _stockController.text =
          (widget.product.stock ?? widget.product['stock'] ?? 0).toString();
      _imageController.text =
          widget.product.image ?? widget.product['image'] ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final idProduct = widget.product != null
          ? (widget.product.id ?? widget.product['id'])
          : null;
      final String? inputImage = _imageController.text.isEmpty
          ? null
          : _imageController.text;

      if (_isEditMode) {
        // OPSI A: Jika ApiService minta named parameter biasa tapi nama 'image' salah,
        // Kita coba kirim tanpa menyertakan parameter image/imageUrl terlebih dahulu untuk tes:
        await ApiService.updateProduct(
          id: idProduct,
          name: _nameController.text,
          descriptions: _descriptionController.text,
          price: int.parse(_priceController.text),
          stock: int.parse(_stockController.text),
        );
      } else {
        await ApiService.createProduct(
          name: _nameController.text,
          descriptions: _descriptionController.text,
          price: int.parse(_priceController.text),
          stock: int.parse(_stockController.text),
        );
      }

      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal menyimpan produk: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Produk' : 'Tambah Produk'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Produk',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Nama tidak boleh kosong'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Deskripsi Produk',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Deskripsi tidak boleh kosong'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Harga Produk',
                        border: OutlineInputBorder(),
                        prefixText: 'Rp ',
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Harga tidak boleh kosong'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _stockController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Jumlah Stok',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Stok tidak boleh kosong'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _imageController,
                      decoration: const InputDecoration(
                        labelText: 'Nama File Gambar (e.g. sepatu.jpg)',
                        border: OutlineInputBorder(),
                        helperText: 'Kosongkan jika belum ada gambar',
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _saveProduct,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        _isEditMode ? 'Perbarui Produk' : 'Simpan Produk',
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
