import 'package:flutter/material.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Pertemuan4Page(),
    );
  }
}

class Pertemuan4Page extends StatelessWidget {
  const Pertemuan4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pertemuan 4'), elevation: 2),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ SUBMIT (SUCCESS TOAST)
            _buildCustomButton(
              text: 'Submit',
              color: Colors.green,
              icon: Icons.check_circle_outline,
              onPressed: () => _showSuccess(context),
            ),
            const SizedBox(height: 20),

            // ✅ DELETE (ERROR TOAST)
            _buildCustomButton(
              text: 'Delete',
              color: Colors.redAccent,
              icon: Icons.delete_outline,
              onPressed: () => _showError(context),
            ),
            const SizedBox(height: 20),

            // ✅ DIALOG
            _buildCustomButton(
              text: 'Show Dialog',
              color: Colors.grey,
              icon: Icons.info_outline,
              onPressed: () => _showDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  // ================= BUTTON =================
  Widget _buildCustomButton({
    required String text,
    required Color color,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 5,
      ),
    );
  }

  // ================= CHERRY TOAST =================
  void _showSuccess(BuildContext context) {
    CherryToast.success(
      title: const Text("Success"),
      description: const Text("Berhasil Disubmit!"),
      animationType: AnimationType.fromTop,
    ).show(context);
  }

  void _showError(BuildContext context) {
    CherryToast.error(
      title: const Text("Deleted"),
      description: const Text("Data berhasil dihapus!"),
      animationType: AnimationType.fromBottom,
    ).show(context);
  }

  // ================= DIALOG =================
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Informasi"),
        content: const Text("Ini adalah dialog yang keren!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
