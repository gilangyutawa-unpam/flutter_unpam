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
      backgroundColor: const Color(0xff0f0f0f),

      appBar: AppBar(
        title: const Text("List Pertemuan"),
        centerTitle: true,
        backgroundColor: const Color(0xff0f0f0f),
        elevation: 0,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];

          return InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => _showConfirm(context, item),

            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xff1c1c1c),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber.withOpacity(0.2)),
              ),

              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.amber,
                    child: Icon(Icons.book, color: Colors.black),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item["title"]!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item["subtitle"]!,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
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

  // ================= CONFIRM DIALOG =================
  void _showConfirm(BuildContext context, Map<String, String> item) {
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
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.amber.withOpacity(0.3)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.help_outline, color: Colors.amber, size: 50),

                const SizedBox(height: 15),

                Text(
                  item["title"]!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  item["subtitle"]!,
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
                          _showToast(context, item);
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
