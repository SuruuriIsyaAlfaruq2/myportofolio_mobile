import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/skills.dart';
import 'package:myportofolio_mobile/screens/skills_list_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class SkillsFormPage extends StatefulWidget {
  const SkillsFormPage({super.key});

  @override
  State<SkillsFormPage> createState() => _SkillsFormPageState();
}

class _SkillsFormPageState extends State<SkillsFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _category = "hardskills";
  String _title = "";
  String _description = "";
  String _thumbnail = "";
  bool _isSubmitting = false;

  final Map<String, String> _categories = const {
    'softskills': 'Soft Skills',
    'hardskills': 'Hard Skills',
  };

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final loggedIn = await ensureLoggedIn(context);
      if (!loggedIn || !mounted) return;

      final authState = context.read<AuthState>();
      final token = authState.token;
      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Silakan login untuk menyimpan data.')),
        );
        await ensureLoggedIn(context);
        return;
      }

      final newSkill = Skills(
        category: _category,
        title: _title.trim(),
        description: _description.trim(),
        thumbnail: _thumbnail.trim().isEmpty ? null : _thumbnail.trim(),
      );
      await context.read<ApiClient>().createSkills(newSkill, token: token);

      if (!mounted) return;
      await Navigator.push<void>(
        context,
        MaterialPageRoute<void>(builder: (_) => const SkillsListScreen()),
      );
    } on ApiException catch (error) {
      if (!mounted) return;

      if (error.statusCode == 401) {
        final authState = context.read<AuthState>();
        try {
          await authState.logout();
        } on ApiException {
          // AuthState clears the local token even when the logout request fails.
        }

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sesi berakhir. Silakan login kembali.'),
          ),
        );
        await ensureLoggedIn(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Gagal menambahkan skill (${error.statusCode}): ${error.message}',
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Skills Form')),
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
                child: DropdownButtonFormField<String>(
                  initialValue: _category,
                  decoration: InputDecoration(
                    labelText: "Kategori Skill",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  items: _categories.entries
                      .map(
                        (entry) => DropdownMenuItem(
                          value: entry.key,
                          child: Text(entry.value),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) _category = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 255,
                  decoration: InputDecoration(
                    hintText: "Misal: Python / Leadership",
                    labelText: "Nama Skill",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _title = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama skill tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 640,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Jelaskan keahlian atau penguasaanmu",
                    labelText: "Deskripsi Skill",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _description = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Deskripsi skill tidak boleh kosong!";
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
                    hintText: "URL logo/gambar skill (opsional)",
                    labelText: "URL Logo/Gambar Skill",
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
                    onPressed: _isSubmitting ? null : _submit,
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text(
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
