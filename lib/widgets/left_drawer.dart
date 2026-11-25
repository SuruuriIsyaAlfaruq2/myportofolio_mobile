import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/screens/form/experience_form.dart';
import 'package:myportofolio_mobile/screens/form/skills_form.dart';
import 'package:myportofolio_mobile/screens/form/educations_form.dart';
import 'package:myportofolio_mobile/screens/experience_list_screen.dart';
import 'package:myportofolio_mobile/screens/skills_list_screen.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

// TODO: Impor halaman ProjectFormPage jika sudah dibuat

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;

    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Portfolio',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Explore personal portofolio!',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ),
          // TODO: Bagian routing
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // Navigasi ke halaman utama portofolio
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.work_outline),
            title: const Text('Experience'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExperienceListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.work_outline),
            title: const Text('Skills'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SkillsListScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Experience'),
            // Navigasi ke halaman tambah proyek
            onTap: () async {
              /*
              TODO: Buatlah routing ke halaman ProjectFormPage yang akan dibuat nanti.
              */
              Navigator.pop(context);
              if (!await ensureLoggedIn(context)) return;
              if (!context.mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExperienceFormPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Skills'),
            // Navigasi ke halaman tambah proyek
            onTap: () async {
              /*
              TODO: Buatlah routing ke halaman ProjectFormPage yang akan dibuat nanti.
              */
              Navigator.pop(context);
              if (!await ensureLoggedIn(context)) return;
              if (!context.mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SkillsFormPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Educations'),
            // Navigasi ke halaman tambah proyek
            onTap: () async {
              /*
              TODO: Buatlah routing ke halaman ProjectFormPage yang akan dibuat nanti.
              */
              Navigator.pop(context);
              if (!await ensureLoggedIn(context)) return;
              if (!context.mounted) return;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EducationsFormPage()),
              );
            },
          ),
          if (!isLoggedIn)
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
            )
          else
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () async {
                Navigator.pop(context);
                await context.read<AuthState>().logout();
                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Berhasil logout')),
                );
              },
            ),
        ],
      ),
    );
  }
}
