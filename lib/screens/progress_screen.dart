import 'package:flutter/material.dart';
import '../data/content.dart';
import '../services/progress_service.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  final ProgressService _progress = ProgressService();
  Set<String> _completed = {};
  int _minutes = 0;
  int _streak = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final c = await _progress.getCompletedLessons();
    final m = await _progress.getTotalMinutes();
    final s = await _progress.getStreak();
    setState(() {
      _completed = c;
      _minutes = m;
      _streak = s;
    });
  }

  int get _level {
    if (_completed.length >= 20) return 5;
    if (_completed.length >= 12) return 4;
    if (_completed.length >= 7) return 3;
    if (_completed.length >= 3) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        children: [
          const Text(
            'Mi Progreso',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 24),

          // Stats
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.4,
            children: [
              _statCard('${_completed.length}', 'Lecciones\ncompletadas'),
              _statCard('$_minutes', 'Minutos de\naprendizaje'),
              _statCard('$_streak', 'Días de\nracha'),
              _statCard('$_level', 'Nivel\nactual'),
            ],
          ),

          const SizedBox(height: 32),
          const Text(
            'Progreso por libro',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 14),

          ...allBooks.map((book) {
            final done = book.lessons.where((l) => _completed.contains(l.id)).length;
            final total = book.lessons.length;
            final pct = total == 0 ? 0.0 : done / total;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF12121A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF2A2A3A)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(book.emoji, style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          book.title,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        '${(pct * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFFC9A227),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: pct,
                      backgroundColor: const Color(0xFF2A2A3A),
                      valueColor: const AlwaysStoppedAnimation(Color(0xFFC9A227)),
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '$done de $total lecciones',
                    style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.4)),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _statCard(String number, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF12121A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF2A2A3A)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFFC9A227),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.5),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
