import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  static final TtsService _instance = TtsService._internal();
  factory TtsService() => _instance;
  TtsService._internal();

  final FlutterTts _tts = FlutterTts();
  bool _isInitialized = false;
  bool isPlaying = false;
  double _speechRate = 0.45; // Velocidad de mentor calmado

  Future<void> init() async {
    if (_isInitialized) return;

    await _tts.setLanguage('es-ES');
    await _tts.setSpeechRate(_speechRate);
    await _tts.setVolume(1.0);
    await _tts.setPitch(0.95); // Un poco más grave, voz de mentor

    // Intentar voz masculina española si está disponible
    try {
      final voices = await _tts.getVoices;
      if (voices != null) {
        for (var voice in voices) {
          final name = (voice['name'] ?? '').toString().toLowerCase();
          final locale = (voice['locale'] ?? '').toString().toLowerCase();
          if (locale.contains('es') &&
              (name.contains('male') ||
                  name.contains('hombre') ||
                  name.contains('jorge') ||
                  name.contains('pablo') ||
                  name.contains('enrique') ||
                  name.contains('miguel'))) {
            await _tts.setVoice({
              'name': voice['name'],
              'locale': voice['locale'],
            });
            break;
          }
        }
      }
    } catch (_) {}

    _tts.setStartHandler(() {
      isPlaying = true;
    });
    _tts.setCompletionHandler(() {
      isPlaying = false;
    });
    _tts.setCancelHandler(() {
      isPlaying = false;
    });
    _tts.setErrorHandler((msg) {
      isPlaying = false;
    });

    _isInitialized = true;
  }

  Future<void> speak(String text) async {
    await init();
    if (isPlaying) {
      await stop();
    }
    await _tts.speak(text);
  }

  Future<void> stop() async {
    await _tts.stop();
    isPlaying = false;
  }

  Future<void> pause() async {
    await _tts.pause();
    isPlaying = false;
  }

  void setSpeechRate(double rate) {
    _speechRate = rate;
    _tts.setSpeechRate(rate);
  }

  double get speechRate => _speechRate;
}
