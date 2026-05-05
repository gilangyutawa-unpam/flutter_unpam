import 'package:flutter/material.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';

class ListPage extends StatelessWidget {
  ListPage({super.key});

  final List<Map<String, String>> data = [
    {"title": "Pertemuan 1", "subtitle": "Pengenalan Android"},
    {"title": "Pertemuan 2", "subtitle": "Widget & Button"},
    {"title": "Pertemuan 3", "subtitle": "Activity & Intent"},
    {"title": "Pertemuan 4", "subtitle": "Toast & AlertDialog"},
    {"title": "Pertemuan 5", "subtitle": "ListView"},
    {"title": "Pertemuan 6", "subtitle": "Checkbox"},
    {"title": "Pertemuan 7", "subtitle": "Radio Button"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("List Pertemuan")),

      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];

          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.book, color: Colors.white),
              ),
              title: Text(item["title"]!),
              subtitle: Text(item["subtitle"]!),
              trailing: const Icon(Icons.arrow_forward_ios),

              onTap: () {
                _showToast(context, item);
              },
            ),
          );
        },
      ),
    );
  }

  // ================= CHERRY TOAST =================
  void _showToast(BuildContext context, Map<String, String> item) {
    CherryToast.success(
      title: Text(item["title"]!),
      description: Text(item["subtitle"]!),
      animationType: AnimationType.fromTop,
      autoDismiss: true,
    ).show(context);
  }
}
