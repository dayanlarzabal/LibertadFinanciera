import 'package:flutter/material.dart';
import '../data/content.dart';
import '../services/progress_service.dart';

class ActionsScreen extends StatefulWidget {
  const ActionsScreen({super.key});

  @override
  State<ActionsScreen> createState() => _ActionsScreenState();
}

class _ActionsScreenState extends State<ActionsScreen> {
  final ProgressService _progress = ProgressService();
  Set<String> _done = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final d = await _progress.getCompletedActions();
    setState(() => _done = d);
  }

  Future<void> _toggle(String id) async {
    await _progress.toggleAction(id);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        children: [
          const Text(
            'Plan de Acción',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            'El conocimiento sin acción es inútil. Aquí está tu checklist semanal.',
            style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14),
          ),
          const SizedBox(height: 28),

          ...weeklyActions.map((action) {
            final isDone = _done.contains(action.id);
            return GestureDetector(
              onTap: () => _toggle(action.id),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isDone ? 0.55 : 1.0,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF12121A),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDone
                          ? const Color(0xFFC9A227).withOpacity(0.4)
                          : const Color(0xFF2A2A3A),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: isDone ? const Color(0xFFC9A227) : Colors.transparent,
                          border: Border.all(
                            color: isDone
                                ? const Color(0xFFC9A227)
                                : const Color(0xFF2A2A3A),
                            width: 2,
                          ),
                        ),
                        child: isDone
                            ? const Icon(Icons.check, size: 16, color: Color(0xFF0A0A0F))
                            : null,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              action.title,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                decoration: isDone ? TextDecoration.lineThrough : null,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              action.description,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white.withOpacity(0.5),
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFC9A227).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                action.category,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFFC9A227),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFC9A227).withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFC9A227).withOpacity(0.2)),
            ),
            child: Column(
              children: [
                const Icon(Icons.lightbulb_outline, color: Color(0xFFC9A227), size: 28),
                const SizedBox(height: 10),
                Text(
                  'Consejo del mentor',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFC9A227),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'No intentes hacer todo a la vez. Elige 2 o 3 acciones esta semana y cúmplelas. La consistencia vence a la intensidad.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.6),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
