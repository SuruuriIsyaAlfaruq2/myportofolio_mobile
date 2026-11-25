import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/skills.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/theme_colors.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class SkillsListScreen extends StatefulWidget {
  const SkillsListScreen({super.key});

  @override
  State<SkillsListScreen> createState() => _SkillsListScreenState();
}

class _SkillsListScreenState extends State<SkillsListScreen> {
  late Future<List<Skills>> _skillsFuture;

  @override
  void initState() {
    super.initState();
    _skillsFuture = context.read<ApiClient>().getSkills();
  }

  Future<void> _reload() async {
    final future = context.read<ApiClient>().getSkills();
    setState(() {
      _skillsFuture = future;
    });
    await future;
  }

  String _categoryLabel(String category) {
    const labels = {
      'softskills': 'Soft Skills',
      'hardskills': 'Hard Skills',
    };
    return labels[category] ?? category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Skills',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<Skills>>(
        future: _skillsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Gagal memuat skills: ${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _reload,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          final skills = snapshot.data ?? const <Skills>[];

          if (skills.isEmpty) {
            return RefreshIndicator(
              onRefresh: _reload,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 240),
                  Center(child: Text('No experience found.')),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: skills.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final skill = skills[index];
                final String? imageUrl = skill.thumbnail;
                final bool hasImage = imageUrl != null && imageUrl.isNotEmpty;

                return Card(
                  elevation: 1,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: AppColors.line),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      if (hasImage) ...[
                        Image.network(
                          imageUrl,
                          width: 40,
                          height: 80,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const SizedBox(
                              width: 40,
                              height: 80,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox.shrink();
                          },
                        ),
                        const SizedBox(width: 12),
                      ],                    
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              skill.title,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: AppColors.ink,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _categoryLabel(skill.category),
                              style: const TextStyle(
                                color: AppColors.accentDark,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              skill.description,
                              style: const TextStyle(
                                color: AppColors.ink,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
