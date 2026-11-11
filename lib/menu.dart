import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/theme_colors.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = "2506548080";
  final String nama = "Suruuri Isya Alfaruq";
  final String kelas = "PBP E";

  // 1. DIUBAH: Memisahkan item Portofolio (Hero) dan Logout dari Grid item sekunder
  final ItemHomepage heroItem = ItemHomepage(
    "Lihat Portofolio", 
    Icons.folder_special, 
    AppColors.accent
  );

  final List<ItemHomepage> gridItems = [
    ItemHomepage("Lihat Experience", Icons.work, AppColors.ink),
    ItemHomepage("Tambah Experience", Icons.add_business, AppColors.textMuted),
    ItemHomepage("Lihat Skills", Icons.code, AppColors.ink),
    ItemHomepage("Tambah Skills", Icons.add_moderator, AppColors.textMuted),
    ItemHomepage("Lihat Education", Icons.school, AppColors.ink),
    ItemHomepage("Tambah Education", Icons.note_add, AppColors.textMuted),
  ];

  final ItemHomepage logoutItem = ItemHomepage(
    "Logout", 
    Icons.logout, 
    AppColors.accentDark
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      // 2. DIUBAH: Membungkus seluruh Body dengan SingleChildScrollView agar bisa di-scroll
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // InfoCard Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoCard(title: 'NPM', content: npm),
                  InfoCard(title: 'Name', content: nama),
                  InfoCard(title: 'Class', content: kelas),
                ],
              ),

              const SizedBox(height: 20.0),

              const Text(
                'Selamat datang di MyPortfolio Mobile!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),

              const SizedBox(height: 20.0),

              // 3. DIUBAH: Hero Action Button (Full Width di paling atas)
              SizedBox(
                height: 70,
                child: ItemCard(heroItem),
              ),

              const SizedBox(height: 16.0),

              // 4. DIUBAH: GridView 2 Kolom untuk pasangan Lihat & Tambah
              GridView.count(
                primary: false,
                shrinkWrap: true, // Menyesuaikan tinggi Grid dengan kontennya
                physics: const NeverScrollableScrollPhysics(), // Scroll ditangani oleh SingleChildScrollView
                crossAxisCount: 2, // 2 Kolom agar tombol lebih lega
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.2, // Rasio lebar dibanding tinggi kartu tombol
                children: gridItems.map((ItemHomepage item) {
                  return ItemCard(item);
                }).toList(),
              ),

              const SizedBox(height: 16.0),

              // 5. DIUBAH: Logout Button (Full Width di paling bawah)
              SizedBox(
                height: 50,
                child: ItemCard(logoutItem),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              content,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

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