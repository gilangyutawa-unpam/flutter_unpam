import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../model/product.dart';

class ApiService {
  static const String baseUrl = 'http://10.19.75.224/rest-api/public/api';
  static const String storageUrl =
      'http://10.19.75.224/rest-api/public/storage';

  // ==========================
  // CLEAN & GET IMAGE URL
  // ==========================
  static String getImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return "";
    }

    String cleanPath = imagePath;

    if (cleanPath.startsWith('public/')) {
      cleanPath = cleanPath.substring(7);
    }

    while (cleanPath.contains('products/products/')) {
      cleanPath = cleanPath.replaceFirst('products/products/', 'products/');
    }

    print('Cleaning image path | Original: $imagePath | Cleaned: $cleanPath');

    String base = storageUrl.endsWith('/') ? storageUrl : '$storageUrl/';
    String path = cleanPath.startsWith('/')
        ? cleanPath.substring(1)
        : cleanPath;

    final String finalUrl = base + path;
    print('Final Url: $finalUrl');

    return finalUrl;
  }

  // ==========================
  // GET ALL PRODUCTS
  // ==========================
  static Future<List<Product>> getProducts() async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/products'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 30));

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);

        // 1. Jika response langsung berupa List
        if (decoded is List) {
          return decoded.map((json) => Product.fromJson(json)).toList();
        }

        // 2. Jika response berupa Map/Object
        if (decoded is Map<String, dynamic>) {
          if (decoded.containsKey('data') && decoded['data'] is List) {
            return (decoded['data'] as List)
                .map((json) => Product.fromJson(json))
                .toList();
          }
          if (decoded.containsKey('products') && decoded['products'] is List) {
            return (decoded['products'] as List)
                .map((json) => Product.fromJson(json))
                .toList();
          }
          if (decoded.containsKey('result') && decoded['result'] is List) {
            return (decoded['result'] as List)
                .map((json) => Product.fromJson(json))
                .toList();
          }
          // Jika object tunggal dibungkus Map
          return [Product.fromJson(decoded)];
        }

        throw Exception(
          'Format response tidak dikenali: ${decoded.runtimeType}',
        );
      } else if (response.statusCode == 404) {
        throw Exception('Endpoint tidak ditemukan: $baseUrl/products');
      } else {
        throw Exception('Gagal memuat produk: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error getProducts: $e');
      throw Exception('Error: $e');
    }
  }

  // ==========================
  // GET PRODUCT BY ID
  // ==========================
  static Future<Product> getProductById(int id) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/products/$id'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);

        if (decoded is Map<String, dynamic>) {
          if (decoded.containsKey('data') &&
              decoded['data'] is Map<String, dynamic>) {
            return Product.fromJson(decoded['data']);
          }
          return Product.fromJson(decoded);
        }
        throw Exception('Format response tidak dikenali');
      } else if (response.statusCode == 404) {
        throw Exception('Produk tidak ditemukan');
      } else {
        throw Exception('Gagal memuat produk: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // ==========================
  // REDUCE STOCK
  // ==========================
  static Future<Product> reduceStock(int productId, int quantity) async {
    try {
      final response = await http
          .patch(
            Uri.parse('$baseUrl/products/$productId/reduce-stock'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({'quantity': quantity}),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);

        if (decoded is Map<String, dynamic>) {
          if (decoded.containsKey('data') &&
              decoded['data'] is Map<String, dynamic>) {
            return Product.fromJson(decoded['data']);
          }
          return Product.fromJson(decoded);
        }
        throw Exception('Format response tidak dikenali');
      } else if (response.statusCode == 400) {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'Stok tidak mencukupi');
      } else {
        throw Exception('Gagal mengurangi stok: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // ==========================
  // DELETE PRODUCT
  // ==========================
  static Future<void> deleteProduct(int id) async {
    try {
      final response = await http
          .delete(
            Uri.parse('$baseUrl/products/$id'),
            headers: {'Content-Type': 'application/json'},
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Gagal menghapus produk: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // ==========================
  // CREATE PRODUCT (Fixed Multipart)
  // ==========================
  static Future<Product> createProduct({
    required String name,
    required String descriptions,
    required int price,
    required int stock,
    File? imageFile,
    Uint8List? imageBytes,
  }) async {
    try {
      // Mengubah ke MultipartRequest agar parameter imageBytes/imageFile bisa terkirim
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/products'),
      );

      request.headers['Accept'] = 'application/json';
      request.fields['name'] = name;
      request.fields['descriptions'] = descriptions;
      request.fields['price'] = price.toString();
      request.fields['stock'] = stock.toString();

      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', imageFile.path),
        );
      } else if (imageBytes != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'image',
            imageBytes,
            filename: 'product_${DateTime.now().millisecondsSinceEpoch}.jpg',
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Create Product Status: ${response.statusCode}');
      print('Create Product Body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is Map<String, dynamic>) {
          if (decoded.containsKey('data') &&
              decoded['data'] is Map<String, dynamic>) {
            return Product.fromJson(decoded['data']);
          }
          return Product.fromJson(decoded);
        }
        throw Exception('Format response tidak dikenali');
      } else {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'Gagal membuat produk');
      }
    } catch (e) {
      print('Create Product Error: $e');
      throw Exception('Error: $e');
    }
  }

  // ==========================
  // UPDATE PRODUCT
  // ==========================
  static Future<Product> updateProduct({
    required int id,
    String? name,
    String? descriptions,
    int? price,
    int? stock,
    File? imageFile,
    Uint8List? imageBytes,
  }) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/products/$id'),
      );

      // Menggunakan spoofing METHOD karena Laravel/PHP restful biasanya butuh ini untuk Multipart PUT
      request.fields['_method'] = 'PUT';

      if (name != null && name.isNotEmpty) request.fields['name'] = name;
      if (descriptions != null) request.fields['descriptions'] = descriptions;
      if (price != null) request.fields['price'] = price.toString();
      if (stock != null) request.fields['stock'] = stock.toString();

      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', imageFile.path),
        );
      } else if (imageBytes != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'image',
            imageBytes,
            filename: 'product_${DateTime.now().millisecondsSinceEpoch}.jpg',
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('Update Product Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        if (decoded is Map<String, dynamic>) {
          if (decoded.containsKey('data') &&
              decoded['data'] is Map<String, dynamic>) {
            return Product.fromJson(decoded['data']);
          }
          return Product.fromJson(decoded);
        }
        throw Exception('Format response tidak dikenali');
      } else {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'Gagal update produk');
      }
    } catch (e) {
      print('Update Product Error: $e');
      throw Exception('Error: $e');
    }
  }

  // ==========================
  // UPLOAD IMAGE ONLY
  // ==========================
  static Future<String> uploadImage(int productId, File imageFile) async {
    try {
      if (!await imageFile.exists()) throw Exception('File tidak ditemukan');

      final bytes = await imageFile.readAsBytes();
      if (bytes.length > 2 * 1024 * 1024)
        throw Exception('File terlalu besar (max 2MB)');

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/products/$productId/upload-image'),
      );
      request.headers['Accept'] = 'application/json';

      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          bytes,
          filename: 'product_${DateTime.now().millisecondsSinceEpoch}.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        return decoded['image_url'] ?? '';
      }
      throw Exception('Upload gagal: ${response.statusCode}');
    } catch (e) {
      print('Upload image error: $e');
      throw Exception('Gagal upload gambar: $e');
    }
  }
}
