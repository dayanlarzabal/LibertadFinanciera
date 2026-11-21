import 'package:flutter/material.dart';
import '../services/tts_service.dart';

class MentorScreen extends StatefulWidget {
  const MentorScreen({super.key});

  @override
  State<MentorScreen> createState() => _MentorScreenState();
}

class _MentorScreenState extends State<MentorScreen> {
  final TtsService _tts = TtsService();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<_Message> _messages = [];
  bool _isSpeaking = false;

  @override
  void initState() {
    super.initState();
    _messages.add(_Message(
      text: 'Hola. Soy tu mentor financiero personal. Estoy entrenado con los principios de Kiyosaki, Graham, Housel, Hill y los mejores pensadores de la historia del dinero.\n\n¿Sobre qué quieres que hablemos hoy? Mentalidad, inversión, deuda, hábitos, o el camino hacia la libertad financiera.',
      isUser: false,
    ));
  }

  String _generateResponse(String question) {
    final q = question.toLowerCase();

    if (q.contains('activo') || q.contains('pasivo')) {
      return 'Excelente pregunta. Según Robert Kiyosaki, un activo es cualquier cosa que pone dinero en tu bolsillo. Un pasivo es cualquier cosa que saca dinero de tu bolsillo.\n\nTu casa principal suele ser un pasivo: impuestos, mantenimiento, hipoteca. Un auto nuevo pierde valor y genera gastos.\n\n¿Qué sí son activos? Propiedades que alquilan, acciones que pagan dividendos, un negocio que genera ingresos sin tu presencia constante.\n\nCada vez que vayas a gastar, pregúntate: ¿esto pondrá dinero en mi bolsillo o me lo quitará?';
    }
    if (q.contains('poco dinero') || q.contains('empezar') || q.contains('pequeño')) {
      return 'Puedes empezar con muy poco. Lo importante no es la cantidad inicial, sino el hábito.\n\n1. Págate primero: guarda al menos el 10% de todo lo que ganes.\n2. Educate: lee, escucha lecciones, entiende la diferencia entre activos y pasivos.\n3. Empieza a invertir aunque sea con montos pequeños en fondos indexados de bajo costo.\n4. Reduce gastos que no aportan valor real.\n\nWarren Buffett empezó de joven con poco. El tiempo y el interés compuesto hacen el resto. Empieza hoy, aunque sea con lo que tengas.';
    }
    if (q.contains('deuda') || q.contains('deudas')) {
      return 'Las deudas se dividen en dos tipos: deudas buenas y deudas malas.\n\nDeuda mala: la que usas para consumir (tarjetas de crédito para ropa, vacaciones, carros caros). Esta te empobrece.\n\nDeuda buena: la que usas para comprar activos que generan más dinero del que cuesta la deuda (una propiedad que alquilas por más de la hipoteca, por ejemplo).\n\nPrioridad: elimina primero las deudas de alto interés. Usa el método de la bola de nieve o el de la avalancha. Y mientras pagas deudas, sigue pagándote a ti primero aunque sea un pequeño porcentaje.';
    }
    if (q.contains('mentalidad') || q.contains('rico') || q.contains('pensar')) {
      return 'La mentalidad es el verdadero punto de partida.\n\nLos pobres y la clase media piensan: "No puedo permitírmelo". Los ricos piensan: "¿Cómo puedo permitírmelo?".\n\nEsa diferencia genera búsqueda de soluciones en lugar de resignación.\n\nNapoleon Hill enseñaba que todo logro comienza con un deseo ardiente y claro. Escribe exactamente qué quieres, para cuándo, y qué estás dispuesto a dar a cambio. Léelo cada día.\n\nAdemás, cultiva la paciencia. La riqueza real se construye despacio. Quien busca hacerse rico rápido suele terminar más pobre.';
    }
    if (q.contains('invertir') || q.contains('inversión') || q.contains('acciones')) {
      return 'Benjamin Graham, el maestro de Buffett, enseñaba: compra negocios, no cotizaciones.\n\nUn inversor analiza el valor intrínseco de una empresa y compra cuando el precio está por debajo de ese valor. Eso se llama margen de seguridad.\n\nSi estás empezando, una de las mejores formas es invertir de forma constante en fondos indexados globales de bajo costo. Es simple, diversificado y ha funcionado históricamente a largo plazo.\n\nEvita la especulación. Evita comprar porque "está subiendo". Compra porque entiendes lo que compras y porque el precio es razonable.';
    }
    if (q.contains('libertad') || q.contains('libre') || q.contains('independiente')) {
      return 'La libertad financiera no es un número mágico. Es el punto en el que tus activos generan suficiente ingreso como para cubrir el estilo de vida que realmente quieres.\n\nPasos claros:\n1. Calcula tus gastos anuales reales.\n2. Define qué estilo de vida quieres (sé honesto).\n3. Multiplica ese número por 25 (regla aproximada del 4%).\n4. Ese es tu número objetivo en activos generadores de ingreso.\n\nMientras construyes, vive por debajo de tus posibilidades. La riqueza verdadera es lo que no se ve: el dinero que no gastaste.';
    }

    // Respuesta genérica de mentor
    return 'Interesante pregunta. La educación financiera es un camino, no un destino.\n\nTe recomiendo que explores las lecciones de los libros en la sección de Cursos. Cada una está diseñada para construir una pieza de tu mentalidad y de tu sistema financiero.\n\nRecuerda: el conocimiento sin acción es inútil. Elige una idea de las que aprendas hoy y aplícala esta misma semana. Eso es lo que separa a quienes transforman su vida de quienes solo acumulan información.\n\n¿Hay algo más específico sobre lo que quieras profundizar?';
  }

  Future<void> _send(String text) async {
    if (text.trim().isEmpty) return;
    _controller.clear();
    setState(() {
      _messages.add(_Message(text: text, isUser: true));
    });
    _scrollToBottom();

    await Future.delayed(const Duration(milliseconds: 600));
    final response = _generateResponse(text);
    setState(() {
      _messages.add(_Message(text: response, isUser: false));
    });
    _scrollToBottom();
  }

  Future<void> _speakLast() async {
    final last = _messages.lastWhere((m) => !m.isUser, orElse: () => _messages.last);
    if (_isSpeaking) {
      await _tts.stop();
      setState(() => _isSpeaking = false);
      return;
    }
    setState(() => _isSpeaking = true);
    await _tts.speak(last.text);
    setState(() => _isSpeaking = false);
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final quickQuestions = [
      '¿Cómo empiezo a invertir con poco dinero?',
      '¿Cuál es la diferencia entre activo y pasivo?',
      'Explícame la mentalidad del rico',
      '¿Cómo salir de deudas?',
    ];

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Habla con tu Mentor',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Text(
                  'Pregunta lo que quieras. Tu mentor responde con sabiduría de los grandes.',
                  style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _messages.length,
              itemBuilder: (context, i) {
                final msg = _messages[i];
                return Align(
                  alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                    ),
                    decoration: BoxDecoration(
                      color: msg.isUser
                          ? const Color(0xFFC9A227).withOpacity(0.15)
                          : const Color(0xFF12121A),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: msg.isUser
                            ? const Color(0xFFC9A227).withOpacity(0.3)
                            : const Color(0xFF2A2A3A),
                      ),
                    ),
                    child: Text(
                      msg.text,
                      style: const TextStyle(fontSize: 14, height: 1.5),
                    ),
                  ),
                );
              },
            ),
          ),
          // Quick questions
          SizedBox(
            height: 42,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: quickQuestions.map((q) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => _send(q),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF12121A),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF2A2A3A)),
                      ),
                      child: Text(
                        q.length > 28 ? '${q.substring(0, 26)}...' : q,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 10),
          // Input
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Escribe tu pregunta...',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.35)),
                      filled: true,
                      fillColor: const Color(0xFF12121A),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: Color(0xFF2A2A3A)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: Color(0xFF2A2A3A)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: Color(0xFFC9A227)),
                      ),
                    ),
                    onSubmitted: _send,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _send(_controller.text),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC9A227),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send_rounded, color: Color(0xFF0A0A0F), size: 22),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _speakLast,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A26),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF2A2A3A)),
                    ),
                    child: Icon(
                      _isSpeaking ? Icons.stop_rounded : Icons.volume_up_rounded,
                      color: const Color(0xFFC9A227),
                      size: 22,
                    ),
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

class _Message {
  final String text;
  final bool isUser;
  _Message({required this.text, required this.isUser});
}
