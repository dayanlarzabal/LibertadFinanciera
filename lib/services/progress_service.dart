import 'package:shared_preferences/shared_preferences.dart';

class ProgressService {
  static final ProgressService _instance = ProgressService._internal();
  factory ProgressService() => _instance;
  ProgressService._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<Set<String>> getCompletedLessons() async {
    await init();
    return _prefs!.getStringList('completed_lessons')?.toSet() ?? {};
  }

  Future<void> markLessonCompleted(String lessonId) async {
    await init();
    final completed = await getCompletedLessons();
    completed.add(lessonId);
    await _prefs!.setStringList('completed_lessons', completed.toList());
    
    // Incrementar contador de minutos (aprox)
    final minutes = _prefs!.getInt('total_minutes') ?? 0;
    await _prefs!.setInt('total_minutes', minutes + 4);
    
    // Actualizar racha
    await _updateStreak();
  }

  Future<int> getTotalMinutes() async {
    await init();
    return _prefs!.getInt('total_minutes') ?? 0;
  }

  Future<int> getStreak() async {
    await init();
    return _prefs!.getInt('streak') ?? 0;
  }

  Future<void> _updateStreak() async {
    await init();
    final today = DateTime.now().toIso8601String().substring(0, 10);
    final lastDate = _prefs!.getString('last_activity_date');
    
    if (lastDate == today) return;
    
    if (lastDate != null) {
      final last = DateTime.parse(lastDate);
      final diff = DateTime.now().difference(last).inDays;
      if (diff == 1) {
        final streak = (_prefs!.getInt('streak') ?? 0) + 1;
        await _prefs!.setInt('streak', streak);
      } else if (diff > 1) {
        await _prefs!.setInt('streak', 1);
      }
    } else {
      await _prefs!.setInt('streak', 1);
    }
    await _prefs!.setString('last_activity_date', today);
  }

  Future<Set<String>> getCompletedActions() async {
    await init();
    return _prefs!.getStringList('completed_actions')?.toSet() ?? {};
  }

  Future<void> toggleAction(String actionId) async {
    await init();
    final completed = await getCompletedActions();
    if (completed.contains(actionId)) {
      completed.remove(actionId);
    } else {
      completed.add(actionId);
    }
    await _prefs!.setStringList('completed_actions', completed.toList());
  }

  Future<double> getBookProgress(String bookId, int totalLessons) async {
    final completed = await getCompletedLessons();
    final bookLessons = completed.where((id) => id.startsWith(bookId.split('_').first) || id.contains(bookId.substring(0, 2))).length;
    // Mejor cálculo
    int count = 0;
    for (var id in completed) {
      if (id.startsWith(bookId.substring(0, 2)) || id.contains(bookId)) {
        count++;
      }
    }
    // Simplificado: contar lecciones que empiezan con el prefijo del libro
    final prefix = bookId == 'padre_rico' ? 'pr_' :
                   bookId == 'inversor_inteligente' ? 'ii_' :
                   bookId == 'psicologia_dinero' ? 'pd_' :
                   bookId == 'babilonia' ? 'bab_' :
                   bookId == 'piense_hagase_rico' ? 'phr_' : '';
    count = completed.where((id) => id.startsWith(prefix)).length;
    if (totalLessons == 0) return 0;
    return (count / totalLessons).clamp(0.0, 1.0);
  }
}
