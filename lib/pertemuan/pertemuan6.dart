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
  bool setuju = false;

  List<String> getSelectedHobi() {
    List<String> hasil = [];
    if (membaca) hasil.add("Membaca");
    if (olahraga) hasil.add("Olahraga");
    if (musik) hasil.add("Musik");
    if (game) hasil.add("Game");
    if (traveling) hasil.add("Traveling");
    return hasil;
  }

  // ================= KONFIRMASI =================
  void konfirmasiSimpan() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Konfirmasi"),
          content: const Text("Apakah kamu yakin ingin menyimpan data?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Tidak"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                simpanData();
              },
              child: const Text("Ya"),
            ),
          ],
        );
      },
    );
  }

  // ================= SIMPAN DATA =================
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

  // ================= RESET =================
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
      setuju = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form dengan Checkbox"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ================= DATA DIRI =================
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: namaController,
                      decoration: const InputDecoration(
                        labelText: "Nama Lengkap",
                      ),
                    ),
                    TextField(
                      controller: nimController,
                      decoration: const InputDecoration(labelText: "NIM"),
                    ),
                    TextField(
                      controller: kelasController,
                      decoration: const InputDecoration(labelText: "Kelas"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ================= HOBI =================
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Hobi (Pilih minimal 1)"),
                    CheckboxListTile(
                      title: const Text("Membaca"),
                      value: membaca,
                      onChanged: (v) => setState(() => membaca = v!),
                    ),
                    CheckboxListTile(
                      title: const Text("Olahraga"),
                      value: olahraga,
                      onChanged: (v) => setState(() => olahraga = v!),
                    ),
                    CheckboxListTile(
                      title: const Text("Musik"),
                      value: musik,
                      onChanged: (v) => setState(() => musik = v!),
                    ),
                    CheckboxListTile(
                      title: const Text("Game"),
                      value: game,
                      onChanged: (v) => setState(() => game = v!),
                    ),
                    CheckboxListTile(
                      title: const Text("Traveling"),
                      value: traveling,
                      onChanged: (v) => setState(() => traveling = v!),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ================= SETUJU =================
            CheckboxListTile(
              title: const Text("Saya menyetujui syarat dan ketentuan"),
              value: setuju,
              onChanged: (v) => setState(() => setuju = v!),
            ),

            const SizedBox(height: 15),

            // ================= BUTTON =================
            ElevatedButton(
              onPressed: setuju ? konfirmasiSimpan : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("DAFTAR SEKARANG"),
            ),

            const SizedBox(height: 10),

            OutlinedButton(onPressed: resetForm, child: const Text("Reset")),
          ],
        ),
      ),
    );
  }
}
