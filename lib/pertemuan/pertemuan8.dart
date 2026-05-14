import 'package:flutter/material.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';

class Pertemuan8Page extends StatefulWidget {
  const Pertemuan8Page({super.key});

  @override
  State<Pertemuan8Page> createState() => _Pertemuan8PageState();
}

class _Pertemuan8PageState extends State<Pertemuan8Page> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController universitasController = TextEditingController();
  final TextEditingController jurusanController = TextEditingController();

  final List<String> jurusanList = [
    "Sistem Informasi",
    "Teknik Informatika",
    "Sistem Komputer",
    "Manajemen Informatika",
    "Ilmu Komunikasi",
    "Akuntansi",
  ];

  final List<String> gelarList = ["D3", "S1", "S2", "S3"];
  final List<String> tahunList = ["2021", "2022", "2023", "2024"];

  String? selectedGelar;
  String? selectedTahun;

  // ================= SIMPAN =================
  void simpanData() {
    if (namaController.text.isEmpty ||
        universitasController.text.isEmpty ||
        jurusanController.text.isEmpty) {
      CherryToast.error(
        title: const Text("Error"),
        description: const Text("Semua field wajib diisi!"),
        animationType: AnimationType.fromTop,
      ).show(context);
      return;
    }

    if (selectedGelar == null || selectedTahun == null) {
      CherryToast.warning(
        title: const Text("Perhatian"),
        description: const Text("Pilih jenjang & tahun dulu!"),
        animationType: AnimationType.fromTop,
      ).show(context);
      return;
    }

    CherryToast.success(
      title: const Text("Berhasil 🎉"),
      description: Text(
        "Nama: ${namaController.text}\n"
        "Univ: ${universitasController.text}\n"
        "Jurusan: ${jurusanController.text}\n"
        "Gelar: $selectedGelar\n"
        "Tahun: $selectedTahun",
      ),
      animationType: AnimationType.fromBottom,
    ).show(context);
  }

  void resetForm() {
    setState(() {
      namaController.clear();
      universitasController.clear();
      jurusanController.clear();
      selectedGelar = null;
      selectedTahun = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f0f0f),

      appBar: AppBar(
        title: const Text("Autocomplete & Spinner"),
        centerTitle: true,
        backgroundColor: const Color(0xff0f0f0f),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _card(
              Column(
                children: [
                  _input("Nama Lengkap", namaController),
                  const SizedBox(height: 10),
                  _input("Universitas", universitasController),
                  const SizedBox(height: 10),

                  // AUTOCOMPLETE JURUSAN
                  Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      return jurusanList.where(
                        (item) => item.toLowerCase().contains(
                          textEditingValue.text.toLowerCase(),
                        ),
                      );
                    },
                    onSelected: (value) {
                      jurusanController.text = value;
                    },
                    fieldViewBuilder:
                        (context, controller, focusNode, onEditingComplete) {
                          return TextField(
                            controller: controller,
                            focusNode: focusNode,
                            style: const TextStyle(color: Colors.white),
                            decoration: _inputStyle("Jurusan"),
                          );
                        },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // GELAR
            _card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Jenjang Pendidikan",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),

                  DropdownButtonFormField<String>(
                    value: selectedGelar,
                    hint: const Text(
                      "Pilih Jenjang Pendidikan",
                      style: TextStyle(color: Colors.white54),
                    ),
                    dropdownColor: const Color(0xff2a2a2a),
                    style: const TextStyle(color: Colors.white),
                    items: gelarList.map((item) {
                      return DropdownMenuItem(value: item, child: Text(item));
                    }).toList(),
                    onChanged: (value) {
                      setState(() => selectedGelar = value);
                    },
                    decoration: _dropdownStyle(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // TAHUN
            _card(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tahun Masuk",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),

                  DropdownButtonFormField<String>(
                    value: selectedTahun,
                    hint: const Text(
                      "Pilih Tahun Masuk",
                      style: TextStyle(color: Colors.white54),
                    ),
                    dropdownColor: const Color(0xff2a2a2a),
                    style: const TextStyle(color: Colors.white),
                    items: tahunList.map((item) {
                      return DropdownMenuItem(value: item, child: Text(item));
                    }).toList(),
                    onChanged: (value) {
                      setState(() => selectedTahun = value);
                    },
                    decoration: _dropdownStyle(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // BUTTON
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: simpanData,
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

  Widget _input(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: _inputStyle(hint),
    );
  }

  InputDecoration _inputStyle(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      filled: true,
      fillColor: const Color(0xff2a2a2a),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }

  InputDecoration _dropdownStyle() {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xff2a2a2a),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}
