import 'package:flutter/material.dart';
import '../data/content.dart';
import '../services/tts_service.dart';
import '../services/progress_service.dart';

class AudiobookScreen extends StatefulWidget {
  const AudiobookScreen({super.key});

  @override
  State<AudiobookScreen> createState() => _AudiobookScreenState();
}

class _AudiobookScreenState extends State<AudiobookScreen> {
  final TtsService _tts = TtsService();
  final ProgressService _progress = ProgressService();
  
  Lesson? _currentLesson;
  Book? _currentBook;
  bool _isPlaying = false;
  double _speed = 0.45;
  int _currentIndex = 0;

  // Flatten all lessons
  late final List<MapEntry<Book, Lesson>> _allLessons;

  @override
  void initState() {
    super.initState();
    _allLessons = [];
    for (final book in allBooks) {
      for (final lesson in book.lessons) {
        _allLessons.add(MapEntry(book, lesson));
      }
    }
  }

  Future<void> _play(int index) async {
    if (index < 0 || index >= _allLessons.length) return;
    
    final entry = _allLessons[index];
    setState(() {
      _currentIndex = index;
      _currentBook = entry.key;
      _currentLesson = entry.value;
      _isPlaying = true;
    });

    await _tts.speak(entry.value.fullText);
    await _progress.markLessonCompleted(entry.value.id);
    
    if (mounted) {
      setState(() => _isPlaying = false);
    }
  }

  Future<void> _togglePlay() async {
    if (_isPlaying) {
      await _tts.stop();
      setState(() => _isPlaying = false);
    } else if (_currentLesson != null) {
      await _play(_currentIndex);
    } else {
      await _play(0);
    }
  }

  void _setSpeed(double rate) {
    _tts.setSpeechRate(rate);
    setState(() => _speed = rate);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        children: [
          const Text(
            'Audiolibro Diario',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            'Escucha lecciones profundas como si estuvieras con un mentor personal',
            style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14),
          ),
          const SizedBox(height: 28),

          // Player Card
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF16161F), Color(0xFF1A1810)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFC9A227).withOpacity(0.2)),
            ),
            child: Column(
              children: [
                // Vinyl
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                      colors: [Color(0xFF3A3A4A), Color(0xFF1A1A22)],
                      center: Alignment(-0.3, -0.3),
                    ),
                    border: Border.all(color: const Color(0xFF9A7B1A), width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFC9A227).withOpacity(0.15),
                        blurRadius: 30,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFFC9A227),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  _currentLesson?.title ?? 'Selecciona una lección',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(
                  _currentBook != null
                      ? '${_currentBook!.title} · ${_currentBook!.author}'
                      : '—',
                  style: TextStyle(color: Colors.white.withOpacity(0.45), fontSize: 13),
                ),
                const SizedBox(height: 28),

                // Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => _play(_currentIndex - 1),
                      icon: const Icon(Icons.skip_previous_rounded, size: 32),
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: _togglePlay,
                      child: Container(
                        width: 68,
                        height: 68,
                        decoration: const BoxDecoration(
                          color: Color(0xFFC9A227),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded,
                          size: 36,
                          color: const Color(0xFF0A0A0F),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      onPressed: () => _play(_currentIndex + 1),
                      icon: const Icon(Icons.skip_next_rounded, size: 32),
                      color: Colors.white70,
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Speed
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [0.4, 0.45, 0.5, 0.55].map((rate) {
                    final label = rate == 0.4
                        ? 'Lento'
                        : rate == 0.45
                            ? 'Normal'
                            : rate == 0.5
                                ? 'Rápido'
                                : 'Muy rápido';
                    final selected = (_speed - rate).abs() < 0.01;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: () => _setSpeed(rate),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: selected
                                ? const Color(0xFFC9A227).withOpacity(0.2)
                                : const Color(0xFF1A1A26),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: selected
                                  ? const Color(0xFFC9A227)
                                  : const Color(0xFF2A2A3A),
                            ),
                          ),
                          child: Text(
                            label,
                            style: TextStyle(
                              fontSize: 12,
                              color: selected
                                  ? const Color(0xFFC9A227)
                                  : Colors.white54,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
          const Text(
            'Biblioteca de lecciones',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 14),

          ..._allLessons.asMap().entries.map((entry) {
            final i = entry.key;
            final book = entry.value.key;
            final lesson = entry.value.value;
            final isActive = _currentIndex == i && _isPlaying;

            return GestureDetector(
              onTap: () => _play(i),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF12121A),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isActive
                        ? const Color(0xFFC9A227)
                        : const Color(0xFF2A2A3A),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive
                            ? const Color(0xFFC9A227)
                            : const Color(0xFF1A1A26),
                      ),
                      child: Center(
                        child: isActive
                            ? const Icon(Icons.graphic_eq, size: 18, color: Color(0xFF0A0A0F))
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
                              color: isActive ? const Color(0xFFC9A227) : Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${book.title} · ${lesson.durationMinutes} min',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
