import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'services/tts_service.dart';
import 'services/progress_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF0A0A0F),
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  await ProgressService().init();
  await TtsService().init();

  runApp(const LibertadFinancieraApp());
}

class LibertadFinancieraApp extends StatelessWidget {
  const LibertadFinancieraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Libertad Financiera Premium',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0F),
        primaryColor: const Color(0xFFC9A227),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFC9A227),
          secondary: Color(0xFFE8C547),
          surface: Color(0xFF12121A),
          onSurface: Color(0xFFF0F0F5),
        ),
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.dark().textTheme,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF0A0A0F).withOpacity(0.95),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFF0F0F5),
          ),
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF12121A),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF2A2A3A)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC9A227),
            foregroundColor: const Color(0xFF0A0A0F),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
