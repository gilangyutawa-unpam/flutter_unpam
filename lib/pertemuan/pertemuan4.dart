import 'package:flutter/material.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';

class Pertemuan4Page extends StatelessWidget {
  const Pertemuan4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f0f0f),
      appBar: AppBar(
        title: const Text("Pertemuan 4"),
        centerTitle: true,
        backgroundColor: const Color(0xff0f0f0f),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xff1c1c1c),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.amber.withOpacity(0.2)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _btn(
                  "Submit",
                  Icons.check_circle_outline,
                  () => _showConfirm(context, true),
                ),
                const SizedBox(height: 15),
                _btn(
                  "Delete",
                  Icons.delete_outline,
                  () => _showConfirm(context, false),
                ),
                const SizedBox(height: 15),
                _btn(
                  "Show Dialog",
                  Icons.auto_awesome,
                  () => _showFancyDialog(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= BUTTON =================
  Widget _btn(String text, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.black),
      label: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // ================= CONFIRM DIALOG (FIT) =================
  void _showConfirm(BuildContext context, bool isSubmit) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
        backgroundColor: Colors.transparent,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xff1c1c1c),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.amber.withOpacity(0.3)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSubmit ? Icons.check_circle : Icons.warning,
                  color: Colors.amber,
                  size: 50,
                ),
                const SizedBox(height: 15),
                Text(
                  isSubmit ? "Submit Data?" : "Hapus Data?",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  isSubmit
                      ? "Apakah kamu yakin ingin submit?"
                      : "Data akan dihapus permanen.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.amber),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "No",
                          style: TextStyle(color: Colors.amber),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          isSubmit
                              ? _showSuccess(context)
                              : _showError(context);
                        },
                        child: const Text("Yes"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= FANCY DIALOG (FIT) =================
  void _showFancyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
        backgroundColor: Colors.transparent,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xff1c1c1c),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.amber.withOpacity(0.3)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.auto_awesome, color: Colors.amber, size: 60),
                const SizedBox(height: 15),
                const Text(
                  "Keren Banget 😎",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Sekarang dialog lo udah compact & elegan.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Mantap"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= TOAST =================
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
}
