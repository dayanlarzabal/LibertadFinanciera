import 'package:flutter/material.dart';
import '../data/content.dart';
import '../services/tts_service.dart';
import '../services/progress_service.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final Set<String> _expanded = {};
  final TtsService _tts = TtsService();
  final ProgressService _progress = ProgressService();
  Set<String> _completed = {};
  String? _playingId;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final c = await _progress.getCompletedLessons();
    setState(() => _completed = c);
  }

  Future<void> _playLesson(Lesson lesson) async {
    if (_playingId == lesson.id) {
      await _tts.stop();
      setState(() => _playingId = null);
      return;
    }
    setState(() => _playingId = lesson.id);
    await _tts.speak(lesson.fullText);
    await _progress.markLessonCompleted(lesson.id);
    final c = await _progress.getCompletedLessons();
    setState(() {
      _playingId = null;
      _completed = c;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        children: [
          Text(
            'Cursos & Libros',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              fontFamily: 'PlayfairDisplay',
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Programas estructurados basados en obras maestras de las finanzas',
            style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14),
          ),
          const SizedBox(height: 28),
          ...allBooks.map((book) {
            final isExpanded = _expanded.contains(book.id);
            final completedCount =
                book.lessons.where((l) => _completed.contains(l.id)).length;

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF12121A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF2A2A3A)),
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (isExpanded) {
                          _expanded.remove(book.id);
                        } else {
                          _expanded.add(book.id);
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF2A2418), Color(0xFF3D3420)],
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: Text(book.emoji, style: const TextStyle(fontSize: 28)),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  book.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  book.author,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white.withOpacity(0.45),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '${book.lessons.length} lecciones · $completedCount completadas',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFFC9A227),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            color: Colors.white38,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isExpanded) ...[
                    const Divider(height: 1, color: Color(0xFF2A2A3A)),
                    ...book.lessons.asMap().entries.map((entry) {
                      final i = entry.key;
                      final lesson = entry.value;
                      final done = _completed.contains(lesson.id);
                      final playing = _playingId == lesson.id;

                      return InkWell(
                        onTap: () => _playLesson(lesson),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: done
                                      ? const Color(0xFFC9A227)
                                      : const Color(0xFF1A1A26),
                                ),
                                child: Center(
                                  child: done
                                      ? const Icon(Icons.check, size: 16, color: Color(0xFF0A0A0F))
                                      : Text(
                                          '${i + 1}',
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFFC9A227),
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      lesson.title,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: playing
                                            ? const Color(0xFFC9A227)
                                            : Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      '${lesson.durationMinutes} min · Toca para escuchar',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                playing ? Icons.stop_circle_outlined : Icons.play_circle_outline,
                                color: const Color(0xFFC9A227),
                                size: 28,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
