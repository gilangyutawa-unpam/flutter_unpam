import 'package:flutter/material.dart';

class Pertemuan9Page extends StatelessWidget {
  const Pertemuan9Page({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date & Time Picker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const DateTimePickerForm(),
    );
  }
}

class DateTimePickerForm extends StatefulWidget {
  const DateTimePickerForm({super.key});

  @override
  State<DateTimePickerForm> createState() => _DateTimePickerFormState();
}

class _DateTimePickerFormState extends State<DateTimePickerForm> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  DateTime? _selectedDateTime;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _dateTimeController.dispose();
    super.dispose();
  }

  // ================= NAMA BULAN =================
  static const List<String> _namaBulan = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')} '
      '${_namaBulan[d.month - 1]} '
      '${d.year}';

  String _fmtDateShort(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')} '
      '${_namaBulan[d.month - 1].substring(0, 3)} '
      '${d.year}';

  String _fmtTime(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:'
      '${t.minute.toString().padLeft(2, '0')}';

  // ================= DATE PICKER =================
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: _pickerTheme,
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = _fmtDate(picked);
      });
    }
  }

  // ================= TIME PICKER =================
  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: _pickerTheme,
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = _fmtTime(picked);
      });
    }
  }

  // ================= DATE RANGE =================
  Future<void> _pickDateRange() async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: (_selectedStartDate != null && _selectedEndDate != null)
          ? DateTimeRange(start: _selectedStartDate!, end: _selectedEndDate!)
          : null,
      builder: _pickerTheme,
    );

    if (range != null) {
      setState(() {
        _selectedStartDate = range.start;
        _selectedEndDate = range.end;

        _startDateController.text = _fmtDateShort(range.start);

        _endDateController.text = _fmtDateShort(range.end);
      });
    }
  }

  // ================= DATE & TIME =================
  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: _pickerTheme,
    );

    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: _selectedDateTime != null
          ? TimeOfDay.fromDateTime(_selectedDateTime!)
          : TimeOfDay.now(),
      builder: _pickerTheme,
    );

    if (time == null) return;

    final combined = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() {
      _selectedDateTime = combined;

      _dateTimeController.text = '${_fmtDate(combined)}, ${_fmtTime(time)}';
    });
  }

  // ================= PICKER THEME =================
  Widget _pickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF6C63FF),
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: Color(0xFF1A1A2E),
        ),
      ),
      child: child!,
    );
  }

  // ================= SIMPAN =================
  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF6C63FF),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: const Text("Form berhasil disimpan 🎉"),
        ),
      );
    }
  }

  // ================= RESET =================
  void _reset() {
    _formKey.currentState?.reset();

    setState(() {
      _selectedDate = null;
      _selectedTime = null;
      _selectedStartDate = null;
      _selectedEndDate = null;
      _selectedDateTime = null;

      _titleController.clear();
      _dateController.clear();
      _timeController.clear();
      _startDateController.clear();
      _endDateController.clear();
      _dateTimeController.clear();
    });
  }

  bool get _hasAnyValue =>
      _titleController.text.isNotEmpty ||
      _dateController.text.isNotEmpty ||
      _timeController.text.isNotEmpty ||
      _startDateController.text.isNotEmpty ||
      _dateTimeController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0f0f0f),

      appBar: AppBar(
        title: const Text("Date & Time Picker"),
        centerTitle: true,
        backgroundColor: const Color(0xff0f0f0f),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: Column(
            children: [
              // ================= JUDUL =================
              _card(
                Column(
                  children: [
                    _inputField(
                      controller: _titleController,
                      label: "Judul Acara",
                      icon: Icons.title,
                      validator: (v) => v!.isEmpty ? "Judul wajib diisi" : null,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // ================= DATE =================
              _card(
                Column(
                  children: [
                    _pickerField(
                      controller: _dateController,
                      label: "Pilih Tanggal",
                      icon: Icons.calendar_today,
                      onTap: _pickDate,
                      validator: (v) =>
                          v!.isEmpty ? "Tanggal wajib dipilih" : null,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // ================= TIME =================
              _card(
                Column(
                  children: [
                    _pickerField(
                      controller: _timeController,
                      label: "Pilih Waktu",
                      icon: Icons.access_time,
                      onTap: _pickTime,
                      validator: (v) =>
                          v!.isEmpty ? "Waktu wajib dipilih" : null,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // ================= RANGE =================
              _card(
                Column(
                  children: [
                    _pickerField(
                      controller: _startDateController,
                      label: "Tanggal Mulai",
                      icon: Icons.play_arrow,
                      onTap: _pickDateRange,
                    ),

                    const SizedBox(height: 10),

                    _pickerField(
                      controller: _endDateController,
                      label: "Tanggal Selesai",
                      icon: Icons.stop,
                      onTap: _pickDateRange,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // ================= DATE TIME =================
              _card(
                Column(
                  children: [
                    _pickerField(
                      controller: _dateTimeController,
                      label: "Tanggal & Waktu",
                      icon: Icons.schedule,
                      onTap: _pickDateTime,
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
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text("Simpan"),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: OutlinedButton(
                      onPressed: _reset,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.amber),
                      ),
                      child: const Text(
                        "Reset",
                        style: TextStyle(color: Colors.amber),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ================= PREVIEW =================
              if (_hasAnyValue) _previewCard(),
            ],
          ),
        ),
      ),
    );
  }

  // ================= CARD =================
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

  // ================= INPUT =================
  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,

      style: const TextStyle(color: Colors.white),

      decoration: _inputStyle(label, icon),
    );
  }

  // ================= PICKER FIELD =================
  Widget _pickerField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      validator: validator,

      style: const TextStyle(color: Colors.white),

      decoration: _inputStyle(label, icon),
    );
  }

  // ================= STYLE =================
  InputDecoration _inputStyle(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,

      hintStyle: const TextStyle(color: Colors.white54),

      prefixIcon: Icon(icon, color: Colors.amber),

      filled: true,
      fillColor: const Color(0xff2a2a2a),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }

  // ================= PREVIEW =================
  Widget _previewCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xff1c1c1c),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.amber.withOpacity(0.2)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          const Text(
            "Preview Data",
            style: TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 10),

          if (_titleController.text.isNotEmpty)
            _previewItem("Judul", _titleController.text),

          if (_dateController.text.isNotEmpty)
            _previewItem("Tanggal", _dateController.text),

          if (_timeController.text.isNotEmpty)
            _previewItem("Waktu", _timeController.text),

          if (_startDateController.text.isNotEmpty)
            _previewItem(
              "Rentang",
              "${_startDateController.text} - ${_endDateController.text}",
            ),

          if (_dateTimeController.text.isNotEmpty)
            _previewItem("Tanggal & Waktu", _dateTimeController.text),
        ],
      ),
    );
  }

  Widget _previewItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),

      child: Text(
        "$label : $value",

        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
