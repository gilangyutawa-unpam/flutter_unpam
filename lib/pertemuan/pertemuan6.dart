import 'package:flutter/material.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';

class Pertemuan6Page extends StatefulWidget {
  const Pertemuan6Page({super.key});

  @override
  State<Pertemuan6Page> createState() => _Pertemuan6PageState();
}

class _Pertemuan6PageState extends State<Pertemuan6Page> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nimController = TextEditingController();
  final TextEditingController kelasController = TextEditingController();

  bool membaca = false;
  bool olahraga = false;
  bool musik = false;
  bool game = false;
  bool traveling = false;
  bool ngoding = false;
  bool desain = false;
  bool fotografi = false;
  bool memasak = false;

  bool setuju = false;

  List<String> getSelectedHobi() {
    List<String> hasil = [];
    if (membaca) hasil.add("Membaca");
    if (olahraga) hasil.add("Olahraga");
    if (musik) hasil.add("Musik");
    if (game) hasil.add("Game");
    if (traveling) hasil.add("Traveling");
    if (ngoding) hasil.add("Ngoding");
    if (desain) hasil.add("Desain");
    if (fotografi) hasil.add("Fotografi");
    if (memasak) hasil.add("Memasak");
    return hasil;
  }

  // ================= KONFIRMASI (FIT DIALOG) =================
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
                  "Pastikan semua data sudah benar.",
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
    if (namaController.text.isEmpty ||
        nimController.text.isEmpty ||
        kelasController.text.isEmpty) {
      CherryToast.error(
        title: const Text("Error"),
        description: const Text("Semua data wajib diisi!"),
        animationType: AnimationType.fromTop,
      ).show(context);
      return;
    }

    if (getSelectedHobi().isEmpty) {
      CherryToast.warning(
        title: const Text("Oops"),
        description: const Text("Pilih minimal 1 hobi!"),
        animationType: AnimationType.fromTop,
      ).show(context);
      return;
    }

    CherryToast.success(
      title: const Text("Berhasil 🎉"),
      description: Text(
        "Nama: ${namaController.text}\n"
        "NIM: ${nimController.text}\n"
        "Kelas: ${kelasController.text}\n"
        "Hobi: ${getSelectedHobi().join(", ")}",
      ),
      animationType: AnimationType.fromBottom,
    ).show(context);
  }

  void resetForm() {
    setState(() {
      namaController.clear();
      nimController.clear();
      kelasController.clear();
      membaca = false;
      olahraga = false;
      musik = false;
      game = false;
      traveling = false;
      ngoding = false;
      desain = false;
      fotografi = false;
      memasak = false;
      setuju = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f0f0f),

      appBar: AppBar(
        title: const Text("Form Checkbox"),
        centerTitle: true,
        backgroundColor: const Color(0xff0f0f0f),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ================= DATA =================
            _card(
              Column(
                children: [
                  _input("Nama Lengkap", namaController),
                  const SizedBox(height: 10),
                  _input("NIM", nimController),
                  const SizedBox(height: 10),
                  _input("Kelas", kelasController),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // ================= HOBI (GRID FIT) =================
            _card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Hobi", style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 10,
                    runSpacing: 5,
                    children: [
                      _check(
                        "Membaca",
                        membaca,
                        (v) => setState(() => membaca = v!),
                      ),
                      _check(
                        "Olahraga",
                        olahraga,
                        (v) => setState(() => olahraga = v!),
                      ),
                      _check("Musik", musik, (v) => setState(() => musik = v!)),
                      _check("Game", game, (v) => setState(() => game = v!)),
                      _check(
                        "Traveling",
                        traveling,
                        (v) => setState(() => traveling = v!),
                      ),
                      _check(
                        "Ngoding",
                        ngoding,
                        (v) => setState(() => ngoding = v!),
                      ),
                      _check(
                        "Desain",
                        desain,
                        (v) => setState(() => desain = v!),
                      ),
                      _check(
                        "Fotografi",
                        fotografi,
                        (v) => setState(() => fotografi = v!),
                      ),
                      _check(
                        "Memasak",
                        memasak,
                        (v) => setState(() => memasak = v!),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ================= SETUJU =================
            Row(
              children: [
                Checkbox(
                  value: setuju,
                  activeColor: Colors.amber,
                  onChanged: (v) => setState(() => setuju = v!),
                ),
                const Expanded(
                  child: Text(
                    "Saya menyetujui syarat dan ketentuan",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // ================= BUTTON =================
            ElevatedButton(
              onPressed: setuju ? konfirmasiSimpan : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("DAFTAR SEKARANG"),
            ),

            const SizedBox(height: 10),

            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.amber),
              ),
              onPressed: resetForm,
              child: const Text("Reset", style: TextStyle(color: Colors.amber)),
            ),
          ],
        ),
      ),
    );
  }

  // ================= WIDGET =================
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

  Widget _input(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
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

  Widget _check(String text, bool value, Function(bool?) onChanged) {
    return FilterChip(
      label: Text(text),
      selected: value,
      onSelected: onChanged,
      selectedColor: Colors.amber,
      checkmarkColor: Colors.black,
      backgroundColor: const Color(0xff2a2a2a),
      labelStyle: TextStyle(color: value ? Colors.black : Colors.white),
    );
  }
}
