import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/form/educations_form.dart';
import 'package:myportofolio_mobile/screens/form/experience_form.dart';
import 'package:myportofolio_mobile/screens/form/skills_form.dart';
import 'package:myportofolio_mobile/screens/experience_list_screen.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      // 6. DIUBAH: Match --radius: 4px dari web
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: () async {
          if (item.name == 'Login') {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
            return;
          }

          if (item.name == 'Logout') {
            try {
              await context.read<AuthState>().logout();
              if (!context.mounted) return;
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Berhasil logout')));
            } on ApiException catch (error) {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Logout gagal dengan status code ${error.statusCode}.',
                  ),
                ),
              );
            }
            return;
          }

          final isAddAction = [
            'Tambah Experience',
            'Tambah Skills',
            'Tambah Education',
          ].contains(item.name);
          if (isAddAction) {
            final loggedIn = await ensureLoggedIn(context);
            if (!loggedIn || !context.mounted) return;
          }

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!"),
              ),
            );
          // Navigate ke halaman yang sesuai
          if (item.name == "Lihat Experience") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ExperienceListScreen(),
              ),
            );
          } else if (item.name == "Tambah Experience") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ExperienceFormPage(),
              ),
            );
          } else if (item.name == "Tambah Skills") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SkillsFormPage()),
            );
          } else if (item.name == "Tambah Education") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EducationsFormPage(),
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 24.0),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    item.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
