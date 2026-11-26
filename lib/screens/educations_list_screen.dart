import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/educations.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/theme_colors.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class EducationsListScreen extends StatefulWidget {
  const EducationsListScreen({super.key});

  @override
  State<EducationsListScreen> createState() => _EducationsListScreenState();
}

class _EducationsListScreenState extends State<EducationsListScreen> {
  late Future<List<Educations>> _educationsFuture;

  @override
  void initState() {
    super.initState();
    _educationsFuture = context.read<ApiClient>().getEducations();
  }

  Future<void> _reload() async {
    final future = context.read<ApiClient>().getEducations();
    setState(() {
      _educationsFuture = future;
    });
    await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Educations',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(currentPage: LeftDrawerPage.educations),
      body: FutureBuilder<List<Educations>>(
        future: _educationsFuture,
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
                      'Gagal memuat educations: ${snapshot.error}',
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

          final educations = snapshot.data ?? const <Educations>[];

          if (educations.isEmpty) {
            return RefreshIndicator(
              onRefresh: _reload,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 240),
                  Center(child: Text('No educations found.')),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: educations.length,
              itemBuilder: (context, index) {
                final education = educations[index];
                final isLast = index == educations.length - 1;
                final imageUrl = education.thumbnail;
                final hasImage = imageUrl != null && imageUrl.isNotEmpty;
                final endYear = education.isOngoing || education.endYear == null
                    ? 'Sekarang'
                    : education.endYear.toString();

                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //Timeline
                      SizedBox(
                        width: 24,
                        child: Column(
                          children: [
                            // Garis atas
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 2,
                                color: AppColors.line,
                              ),
                            ),
                            // Titik 
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: education.isOngoing
                                    ? AppColors.accentDark
                                    : Theme.of(context).scaffoldBackgroundColor,
                                border: Border.all(
                                  color: AppColors.accentDark,
                                  width: 2.5,
                                ),
                              ),
                            ),
                            // Garis bawah
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 2,
                                color: AppColors.line,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
                          child: Card(
                            margin: EdgeInsets.zero, 
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
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
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
                                        const SizedBox(height: 8),
                                        Text(
                                          'Started: ${education.startYear} - Ended: $endYear',
                                          style: const TextStyle(
                                            color: AppColors.accentDark,
                                            fontSize: 13,
                                          ),
                                        ),
                                        Text(
                                          education.institution,
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.ink,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          education.major,
                                          style: const TextStyle(
                                            color: AppColors.textMuted,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
