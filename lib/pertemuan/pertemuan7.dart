import 'package:flutter/material.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';

class Pertemuan7Page extends StatefulWidget {
  const Pertemuan7Page({super.key});

  @override
  State<Pertemuan7Page> createState() => _Pertemuan7PageState();
}

class _Pertemuan7PageState extends State<Pertemuan7Page> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController umurController = TextEditingController();

  String jenisKelamin = "";
  String pekerjaan = "";
  String tipePekerjaan = "";

  final List<String> listPekerjaan = [
    "Admin",
    "Guru",
    "Programmer",
    "Desainer",
    "Content Creator",
    "UI/UX",
  ];

  // ================= KONFIRMASI (FIT) =================
  void konfirmasiSimpan() {
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
                const Text(
                  "Simpan Data?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Pastikan semua sudah benar.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
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
                          simpanData();
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

  // ================= SIMPAN =================
  void simpanData() {
    if (namaController.text.isEmpty || umurController.text.isEmpty) {
      CherryToast.error(
        title: const Text("Error"),
        description: const Text("Nama & umur wajib diisi!"),
        animationType: AnimationType.fromTop,
      ).show(context);
      return;
    }

    if (jenisKelamin.isEmpty || pekerjaan.isEmpty || tipePekerjaan.isEmpty) {
      CherryToast.warning(
        title: const Text("Perhatian"),
        description: const Text("Semua pilihan harus dipilih!"),
        animationType: AnimationType.fromTop,
      ).show(context);
      return;
    }

    CherryToast.success(
      title: const Text("Berhasil 🎉"),
      description: Text(
        "Nama: ${namaController.text}\n"
        "Umur: ${umurController.text} tahun\n"
        "Jenis Kelamin: $jenisKelamin\n"
        "Pekerjaan: $pekerjaan\n"
        "Tipe: $tipePekerjaan",
      ),
      animationType: AnimationType.fromBottom,
    ).show(context);
  }

  void resetForm() {
    setState(() {
      namaController.clear();
      umurController.clear();
      jenisKelamin = "";
      pekerjaan = "";
      tipePekerjaan = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f0f0f),

      appBar: AppBar(
        title: const Text("Form Radio & Chip"),
        centerTitle: true,
        backgroundColor: const Color(0xff0f0f0f),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ================= INPUT =================
            _card(
              Column(
                children: [
                  _input("Nama Lengkap", namaController),
                  const SizedBox(height: 10),
                  _input("Umur", umurController, isNumber: true),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // ================= JENIS KELAMIN =================
            _card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Jenis Kelamin",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 10,
                    children: [
                      _choice(
                        "Laki-laki",
                        jenisKelamin,
                        (v) => setState(() => jenisKelamin = v),
                      ),
                      _choice(
                        "Perempuan",
                        jenisKelamin,
                        (v) => setState(() => jenisKelamin = v),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // ================= PEKERJAAN =================
            _card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pekerjaan",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 10,
                    runSpacing: 5,
                    children: listPekerjaan.map((item) {
                      return _choice(
                        item,
                        pekerjaan,
                        (v) => setState(() => pekerjaan = v),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // ================= TIPE =================
            _card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tipe Pekerjaan",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 10,
                    children: [
                      _choice(
                        "Full Time",
                        tipePekerjaan,
                        (v) => setState(() => tipePekerjaan = v),
                      ),
                      _choice(
                        "Part Time",
                        tipePekerjaan,
                        (v) => setState(() => tipePekerjaan = v),
                      ),
                      _choice(
                        "Freelance",
                        tipePekerjaan,
                        (v) => setState(() => tipePekerjaan = v),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ================= BUTTON =================
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: konfirmasiSimpan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Simpan Data"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.amber),
                    ),
                    onPressed: resetForm,
                    child: const Text(
                      "Reset",
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ================= COMPONENT =================
  Widget _card(Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff1c1c1c),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.amber.withOpacity(0.2)),
      ),
      child: child,
    );
  }

  Widget _input(
    String hint,
    TextEditingController controller, {
    bool isNumber = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: const Color(0xff2a2a2a),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _choice(String text, String selected, Function(String) onTap) {
    final isActive = selected == text;

    return ChoiceChip(
      label: Text(text),
      selected: isActive,
      onSelected: (_) => onTap(text),
      selectedColor: Colors.amber,
      backgroundColor: const Color(0xff2a2a2a),
      labelStyle: TextStyle(color: isActive ? Colors.black : Colors.white),
    );
  }
}
