import 'package:flutter/material.dart';
import 'package:flutter_unpam/pertemuan/pertemuan3.dart';
import 'package:flutter_unpam/pertemuan/pertemuan4.dart';
import 'package:flutter_unpam/pertemuan/list_page.dart';
import 'package:flutter_unpam/pertemuan/pertemuan6.dart';
import 'package:flutter_unpam/pertemuan/pertemuan7.dart';
import 'package:flutter_unpam/pertemuan/pertemuan8.dart';
import 'package:flutter_unpam/pertemuan/pertemuan9.dart';
import 'package:flutter_unpam/pertemuan/pertemuan10.dart';

class BerandaPage extends StatelessWidget {
  BerandaPage({super.key});

  final List<Map<String, dynamic>> items = [
    {"title": "Pertemuan 1"},
    {"title": "Pertemuan 2"},
    {"title": "Pertemuan 3"},
    {"title": "Pertemuan 4"},
    {"title": "Pertemuan 5"},
    {"title": "Pertemuan 6"},
    {"title": "Pertemuan 7"},
    {"title": "Pertemuan 8"},
    {"title": "Pertemuan 9"},
    {"title": "Pertemuan 10"},
  ];

  void navigate(BuildContext context, String title) {
    if (title == "Pertemuan 3") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Pertemuan3Page()),
      );
    } else if (title == "Pertemuan 4") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Pertemuan4Page()),
      );
    } else if (title == "Pertemuan 5") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ListPage()),
      );
    } else if (title == "Pertemuan 6") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Pertemuan6Page()),
      );
    } else if (title == "Pertemuan 7") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Pertemuan7Page()),
      );
    } else if (title == "Pertemuan 8") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Pertemuan8Page()),
      );
    } else if (title == "Pertemuan 9") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Pertemuan9Page()),
      );
    } else if (title == "Pertemuan 10") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Pertemuan10()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("$title belum dibuat")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f0f0f),

      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        backgroundColor: const Color(0xff0f0f0f),
        elevation: 0,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),

        itemCount: items.length,

        itemBuilder: (context, index) {
          final item = items[index];

          return InkWell(
            onTap: () => navigate(context, item["title"]),

            child: Container(
              margin: const EdgeInsets.only(bottom: 15),

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: const Color(0xff1c1c1c),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.amber.withOpacity(0.2)),
              ),

              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.amber,

                    child: Icon(Icons.menu_book, color: Colors.black),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Text(
                      item["title"],

                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.white54,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
