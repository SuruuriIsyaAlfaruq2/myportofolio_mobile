import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/form/experience_form.dart';
import 'package:myportofolio_mobile/screens/menu.dart';


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
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"))
            );
          // Navigate ke halaman yang sesuai
          if (item.name == "Tambah Experience") {
            // TODO: Gunakan Navigator.push() untuk melakukan navigasi ke MaterialPageRoute yang mencakup ExperienceFormPage
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExperienceFormPage(),
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
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 24.0,
                ),
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