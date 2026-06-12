// lib/produk/list_product.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

// ========================================================
// PERBAIKAN IMPORT (Menggunakan Relative Path agar Lebih Aman)
// ========================================================
import '../model/Product.dart'; // Jika file model menggunakan huruf kecil, ubah menjadi '../model/product.dart'
import 'add_product.dart';
import 'detail_product.dart';
import '../service/api_service.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  // Menggunakan 'dynamic' sementara jika class Product benar-benar tidak terbaca,
  // namun tetap mempertahankan struktur utama agar tidak error.
  List<dynamic> _products = [];
  bool _isLoading = true;
  bool _isRefreshing = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  // ========================================================
  // 1. FUNGSI AMBIL DATA PRODUK
  // ========================================================
  Future<void> _fetchProducts() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final fetchedProducts = await ApiService.getProducts();
      if (!mounted) return;
      setState(() {
        _products = fetchedProducts;
        _isLoading = false;
        _isRefreshing = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception: ', '');
        _isLoading = false;
        _isRefreshing = false;
      });
    }
  }

  // ========================================================
  // 2. FUNGSI REFRESH DATA (PULL TO REFRESH)
  // ========================================================
  Future<void> _refreshProducts() async {
    setState(() {
      _isRefreshing = true;
    });
    await _fetchProducts();
  }

  // ========================================================
  // 3. FUNGSI HAPUS PRODUK
  // ========================================================
  Future<void> _deleteProduct(dynamic product) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Produk'),
        content: Text('Yakin ingin menghapus "${product.name ?? ''}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 12),
              Text('Menghapus produk ... '),
            ],
          ),
          duration: Duration(seconds: 2),
        ),
      );

      try {
        // Ditambahkan null-safety check (!) untuk mengatasi error receiver can be null
        await ApiService.deleteProduct(product.id!);

        if (!mounted) return;
        setState(() {
          _products.removeWhere((p) => p.id == product.id);
        });

        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Produk berhasil dihapus'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menghapus: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  // ========================================================
  // 4. FUNGSI HELPER / UTILITY
  // ========================================================
  String _formatPrice(int price) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(price);
  }

  Color getStockColor(int stock) {
    if (stock <= 0) return Colors.red;
    if (stock < 10) return Colors.orange;
    return Colors.green;
  }

  String getStockText(int stock) {
    if (stock <= 0) return 'Habis';
    if (stock < 10) return 'Terbatas';
    return 'Tersedia';
  }

  // ========================================================
  // 5. WIDGET BUILD (UTAMA)
  // ========================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Produk'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _fetchProducts,
            tooltip: 'Refresh',
          ),
          if (_products.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  '${_products.length}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            // Jika nama class di file add_product.dart bukan AddProduct, sesuaikan di sini
            MaterialPageRoute(builder: (context) => const AddProduct()),
          );
          if (result == true) {
            _fetchProducts();
          }
        },
        tooltip: 'Tambah Produk',
        child: const Icon(Icons.add),
      ),
    );
  }

  // ========================================================
  // 6. UI BODY BUILDER
  // ========================================================
  Widget _buildBody() {
    if (_isLoading && !_isRefreshing) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Memuat daftar produk ... '),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              'Terjadi Kesalahan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red[700],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _fetchProducts,
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (_products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Belum Ada Produk',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tekan tombol + untuk menambah produk',
              style: TextStyle(color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshProducts,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return _buildProductCard(product);
        },
      ),
    );
  }

  // ========================================================
  // 7. WIDGET CARD PER ITEM PRODUK
  // ========================================================
  Widget _buildProductCard(dynamic product) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () async {
          final result = await Navigator.push(
            context,
            // Jika nama class di file detail_product.dart bukan DetailProduct, sesuaikan di sini
            MaterialPageRoute(
              builder: (context) => DetailProduct(product: product),
            ),
          );

          if (result == true) {
            _fetchProducts();
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar produk
              _buildProductImage(product),

              const SizedBox(width: 12),

              // Informasi produk (Nama, Harga, Label Stok)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatPrice(product.price ?? 0),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: getStockColor(
                              product.stock ?? 0,
                            ).withAlpha((255 * 0.1).round()),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.inventory,
                                size: 14,
                                color: getStockColor(product.stock ?? 0),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${getStockText(product.stock ?? 0)}: ${product.stock ?? 0}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: getStockColor(product.stock ?? 0),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Tombol aksi (Edit & Delete)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue, size: 22),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddProduct(product: product),
                        ),
                      );

                      if (result == true) {
                        _fetchProducts();
                      }
                    },
                    tooltip: 'Edit produk',
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    splashRadius: 20,
                  ),
                  const SizedBox(height: 4),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red, size: 22),
                    onPressed: () => _deleteProduct(product),
                    tooltip: 'Hapus produk',
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    splashRadius: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ========================================================
  // 8. WIDGET TAMPILAN GAMBAR PRODUK
  // ========================================================
  Widget _buildProductImage(dynamic product) {
    if (product.image != null && product.image.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: ApiService.getImageUrl(product.image),
          width: 70,
          height: 70,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.broken_image, size: 30, color: Colors.grey[400]),
                const SizedBox(height: 4),
                Text(
                  'Error',
                  style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_not_supported, size: 35, color: Colors.grey[400]),
            const SizedBox(height: 4),
            Text(
              'No image',
              style: TextStyle(fontSize: 10, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }
  }
}
