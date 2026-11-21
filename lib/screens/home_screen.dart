import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/content.dart';
import '../services/tts_service.dart';
import '../services/progress_service.dart';
import 'courses_screen.dart';
import 'audiobook_screen.dart';
import 'mentor_screen.dart';
import 'progress_screen.dart';
import 'actions_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final TtsService _tts = TtsService();
  bool _isSpeaking = false;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      _HomeTab(onPlayDaily: _playDailyMentor),
      const CoursesScreen(),
      const AudiobookScreen(),
      const MentorScreen(),
      const ProgressScreen(),
      const ActionsScreen(),
    ];
  }

  Future<void> _playDailyMentor() async {
    if (_isSpeaking) {
      await _tts.stop();
      setState(() => _isSpeaking = false);
      return;
    }
    final daily = dailyMentors[DateTime.now().day % dailyMentors.length];
    setState(() => _isSpeaking = true);
    await _tts.speak(daily.fullScript);
    setState(() => _isSpeaking = false);
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Buenos días';
    if (hour < 19) return 'Buenas tardes';
    return 'Buenas noches';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFF2A2A3A))),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex > 4 ? 0 : _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF0C0C12),
          selectedItemColor: const Color(0xFFC9A227),
          unselectedItemColor: const Color(0xFF6A6A7A),
          selectedFontSize: 11,
          unselectedFontSize: 11,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Inicio'),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded), label: 'Cursos'),
            BottomNavigationBarItem(icon: Icon(Icons.headphones_rounded), label: 'Audio'),
            BottomNavigationBarItem(icon: Icon(Icons.record_voice_over_rounded), label: 'Mentor'),
            BottomNavigationBarItem(icon: Icon(Icons.insights_rounded), label: 'Progreso'),
          ],
        ),
      ),
    );
  }
}

// ==================== HOME TAB ====================
class _HomeTab extends StatefulWidget {
  final VoidCallback onPlayDaily;
  const _HomeTab({required this.onPlayDaily});

  @override
  State<_HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<_HomeTab> {
  final ProgressService _progress = ProgressService();
  Set<String> _completed = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final c = await _progress.getCompletedLessons();
    setState(() => _completed = c);
  }

  @override
  Widget build(BuildContext context) {
    final daily = dailyMentors[DateTime.now().day % dailyMentors.length];
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? 'Buenos días'
        : hour < 19
            ? 'Buenas tardes'
            : 'Buenas noches';

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greeting,
                    style: const TextStyle(
                      color: Color(0xFFC9A227),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Tu camino hacia la\nlibertad financiera',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      height: 1.25,
                      color: const Color(0xFFF0F0F5),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Basado en los principios de los mejores libros de finanzas e inversión de la historia.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.55),
                      fontSize: 14,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Daily Mentor Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF16161F), Color(0xFF1C1A14)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFC9A227).withOpacity(0.25)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFC9A227).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'MENTOR DEL DÍA',
                                style: TextStyle(
                                  color: Color(0xFFC9A227),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: widget.onPlayDaily,
                              child: Container(
                                width: 44,
                                height: 44,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFC9A227),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.play_arrow_rounded, color: Color(0xFF0A0A0F), size: 28),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          daily.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFF0F0F5),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          daily.excerpt,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.55),
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                  const Text(
                    'Libros fundamentales',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFF0F0F5),
                    ),
                  ),
                  const SizedBox(height: 14),
                ],
              ),
            ),
          ),

          // Books horizontal
          SliverToBoxAdapter(
            child: SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: allBooks.length,
                itemBuilder: (context, i) {
                  final book = allBooks[i];
                  return Container(
                    width: 140,
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF12121A),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFF2A2A3A)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(book.emoji, style: const TextStyle(fontSize: 28)),
                        const Spacer(),
                        Text(
                          book.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          book.author,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white.withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Continúa aprendiendo',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ...allBooks.take(3).map((book) {
                    final completedCount = book.lessons
                        .where((l) => _completed.contains(l.id))
                        .length;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF12121A),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: const Color(0xFF2A2A3A)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF2A2418), Color(0xFF3D3420)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(book.emoji, style: const TextStyle(fontSize: 24)),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book.title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '${book.lessons.length} lecciones · ${completedCount} completadas',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withOpacity(0.45),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(2),
                                  child: LinearProgressIndicator(
                                    value: book.lessons.isEmpty
                                        ? 0
                                        : completedCount / book.lessons.length,
                                    backgroundColor: const Color(0xFF2A2A3A),
                                    valueColor: const AlwaysStoppedAnimation(Color(0xFFC9A227)),
                                    minHeight: 4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
