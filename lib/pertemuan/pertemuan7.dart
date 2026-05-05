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
  ];

  // ================= KONFIRMASI =================
  void konfirmasiSimpan() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Konfirmasi"),
          content: const Text("Yakin ingin menyimpan data?"),
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

  // ================= RESET =================
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
      appBar: AppBar(
        title: const Text("Form Radio & Chip"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ================= INPUT =================
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
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: umurController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Umur",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ================= JENIS KELAMIN =================
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  const ListTile(title: Text("Jenis Kelamin")),
                  RadioListTile(
                    title: const Text("Laki-laki"),
                    value: "Laki-laki",
                    groupValue: jenisKelamin,
                    onChanged: (v) => setState(() => jenisKelamin = v!),
                  ),
                  RadioListTile(
                    title: const Text("Perempuan"),
                    value: "Perempuan",
                    groupValue: jenisKelamin,
                    onChanged: (v) => setState(() => jenisKelamin = v!),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // ================= PEKERJAAN =================
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Pekerjaan"),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      children: listPekerjaan.map((item) {
                        return ChoiceChip(
                          label: Text(item),
                          selected: pekerjaan == item,
                          selectedColor: Colors.teal.shade200,
                          onSelected: (_) {
                            setState(() => pekerjaan = item);
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ================= TIPE =================
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  const ListTile(title: Text("Tipe Pekerjaan")),
                  RadioListTile(
                    title: const Text("Full Time"),
                    value: "Full Time",
                    groupValue: tipePekerjaan,
                    onChanged: (v) => setState(() => tipePekerjaan = v!),
                  ),
                  RadioListTile(
                    title: const Text("Part Time"),
                    value: "Part Time",
                    groupValue: tipePekerjaan,
                    onChanged: (v) => setState(() => tipePekerjaan = v!),
                  ),
                  RadioListTile(
                    title: const Text("Freelance"),
                    value: "Freelance",
                    groupValue: tipePekerjaan,
                    onChanged: (v) => setState(() => tipePekerjaan = v!),
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
                      backgroundColor: Colors.teal,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Simpan Data"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: resetForm,
                    child: const Text("Reset"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
