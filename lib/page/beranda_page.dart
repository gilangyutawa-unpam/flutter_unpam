import 'package:flutter/material.dart';
import 'package:flutter_unpam/pertemuan/pertemuan3.dart';
import 'package:flutter_unpam/pertemuan/pertemuan4.dart';
import 'package:flutter_unpam/pertemuan/list_page.dart';
import 'package:flutter_unpam/pertemuan/pertemuan6.dart';
import 'package:flutter_unpam/pertemuan/pertemuan7.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  final List<Map<String, dynamic>> items = const [
    {"title": "Pertemuan 1", "color": Colors.red},
    {"title": "Pertemuan 2", "color": Colors.orange},
    {"title": "Pertemuan 3", "color": Colors.yellow},
    {"title": "Pertemuan 4", "color": Colors.teal},
    {"title": "Pertemuan 5", "color": Colors.blue},
    {"title": "Pertemuan 6", "color": Colors.green},
    {"title": "Pertemuan 7", "color": Colors.purple},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return InkWell(
            onTap: () {
              final title = item["title"].toString().trim();

              if (title == "Pertemuan 3") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Pertemuan3Page(),
                  ),
                );
              } else if (title == "Pertemuan 4") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Pertemuan4Page(),
                  ),
                );
              } else if (title == "Pertemuan 5") {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListPage()),
                );
              } else if (title == "Pertemuan 6") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Pertemuan6Page(),
                  ),
                );
              } else if (title == "Pertemuan 7") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Pertemuan7Page(),
                  ),
                );
              } else {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("$title belum dibuat")));
              }
            },

            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 5),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: item["color"].withOpacity(0.2),
                    child: Icon(Icons.menu_book, color: item["color"]),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    item["title"],
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
