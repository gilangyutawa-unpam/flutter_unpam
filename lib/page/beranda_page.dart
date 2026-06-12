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
        title: const Text("Dashboard", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xff0f0f0f),
        elevation: 0,
        actions: [
          // 1. OPTION MENU (Bebas backgroundColor)
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Memilih: $value')));
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'Profile',
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.amber),
                    SizedBox(width: 8),
                    Text('Profile'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'Settings',
                child: Row(
                  children: [
                    Icon(Icons.settings, color: Colors.amber),
                    SizedBox(width: 8),
                    Text('Settings'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'Logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.amber),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          // 2. CONTEXT MENU (Bebas backgroundColor)
          return GestureDetector(
            onLongPressStart: (details) async {
              final dx = details.globalPosition.dx;
              final dy = details.globalPosition.dy;

              final String? value = await showMenu<String>(
                context: context,
                position: RelativeRect.fromLTRB(dx, dy, dx, dy),
                items: [
                  const PopupMenuItem(
                    value: 'Edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Colors.blue),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'Delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Delete'),
                      ],
                    ),
                  ),
                ],
              );

              if (!context.mounted) return;

              if (value != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$value pada ${item["title"]}')),
                );
              }
            },
            child: InkWell(
              onTap: () => navigate(context, item["title"]),
              borderRadius: BorderRadius.circular(20),
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
            ),
          );
        },
      ),

      // 3. FLOATING ACTION BUTTON (Bebas backgroundColor)
      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            backgroundColor: Colors.amber,
            onPressed: () async {
              final RenderBox button = context.findRenderObject() as RenderBox;
              final RenderBox overlay =
                  Navigator.of(context).overlay!.context.findRenderObject()
                      as RenderBox;
              final RelativeRect position = RelativeRect.fromRect(
                Rect.fromPoints(
                  button.localToGlobal(Offset.zero, ancestor: overlay),
                  button.localToGlobal(
                    button.size.bottomRight(Offset.zero),
                    ancestor: overlay,
                  ),
                ),
                Offset.zero & overlay.size,
              );

              final String? value = await showMenu<String>(
                context: context,
                position: position,
                items: [
                  const PopupMenuItem(
                    value: 'Add',
                    child: Row(
                      children: [
                        Icon(Icons.add, color: Colors.green),
                        SizedBox(width: 8),
                        Text('Add'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'Edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Colors.blue),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'Delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Delete'),
                      ],
                    ),
                  ),
                ],
              );

              if (!context.mounted) return;

              if (value != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('FAB Memilih: $value')));
              }
            },
            child: const Icon(Icons.add, color: Colors.black, size: 28),
          );
        },
      ),
    );
  }
}
