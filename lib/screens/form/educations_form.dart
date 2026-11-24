import 'package:material_ui/material_ui.dart';

class EducationsFormPage extends StatefulWidget {
  const EducationsFormPage({super.key});

  @override
  State<EducationsFormPage> createState() => _EducationsFormPageState();
}

class _EducationsFormPageState extends State<EducationsFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _institution = "";
  String _major = "";
  String _thumbnail = "";
  String _startYear = "";
  String _endYear = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Educations Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 255,
                  decoration: InputDecoration(
                    hintText: "Misal: Universitas Indonesia",
                    labelText: "Nama Instansi / Sekolah / Universitas",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _institution = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama instansi tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 640,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: "Misal: Ilmu Komputer",
                    labelText: "Jurusan / Program Studi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _major = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Jurusan tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  key: ValueKey(_startYear),
                  initialValue: _startYear,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Pilih tahun mulai",
                    labelText: "Tahun Mulai",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    ).then((date) {
                      if (date != null) {
                        setState(() => _startYear = date.year.toString());
                      }
                    });
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Tahun mulai tidak boleh kosong!";
                    }
                    final year = int.tryParse(value);
                    if (year == null || year < 1900 || year > 2100) {
                      return "Masukkan tahun mulai antara 1900 dan 2100!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  key: ValueKey(_endYear),
                  initialValue: _endYear,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText:
                        "Pilih tahun atau kosongkan jika masih berlangsung",
                    labelText: "Tahun Selesai (opsional)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    suffixIcon: _endYear.isEmpty
                        ? const Icon(Icons.calendar_today)
                        : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => setState(() => _endYear = ""),
                          ),
                  ),
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    ).then((date) {
                      if (date != null) {
                        setState(() => _endYear = date.year.toString());
                      }
                    });
                  },
                  validator: (value) {
                    final year =
                        int.tryParse(value ?? "") ?? DateTime.now().year;
                    if (year < 1900 || year > 2100) {
                      return "Masukkan tahun selesai antara 1900 dan 2100!";
                    }
                    final startYear =
                        int.tryParse(_startYear) ?? DateTime.now().year;
                    if (year < startYear) {
                      return "Tahun selesai tidak boleh sebelum tahun mulai!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 1024,
                  decoration: InputDecoration(
                    hintText: "URL logo instansi (opsional)",
                    labelText: "URL Logo Instansi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _thumbnail = value,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                'Education berhasil ditambahkan!',
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Instansi: $_institution'),
                                  Text('Jurusan: $_major'),
                                  Text('Tahun mulai: $_startYear'),
                                  Text(
                                    'Tahun selesai: ${_endYear.isEmpty ? "Sekarang" : _endYear}',
                                  ),
                                  Text('Thumbnail: $_thumbnail'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _formKey.currentState!.reset();
                                    setState(() {
                                      _institution = "";
                                      _major = "";
                                      _thumbnail = "";
                                      _startYear = "";
                                      _endYear = "";
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Simpan",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
