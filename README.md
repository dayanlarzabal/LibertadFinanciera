# Libertad Financiera Premium

Aplicación móvil premium de educación financiera con **voz de mentor**, audiolibros y enseñanza estructurada basada en los mejores libros de finanzas e inversión de la historia.

## Características

- **Mentor de voz** (Text-to-Speech en español) que narra las lecciones como un coach personal
- **5 libros fundamentales** con lecciones completas:
  - Padre Rico, Padre Pobre (Kiyosaki)
  - El Inversor Inteligente (Benjamin Graham)
  - La Psicología del Dinero (Morgan Housel)
  - El Hombre Más Rico de Babilonia (George S. Clason)
  - Piense y Hágase Rico (Napoleon Hill)
- **Reproductor de audiolibro** con control de velocidad
- **Chat con el Mentor** inteligente (respuestas basadas en principios de los libros)
- **Seguimiento de progreso**, rachas y niveles
- **Plan de acción semanal** práctico
- Diseño **premium oscuro + dorado**

## Cómo generar el APK

### Opción 1: GitHub Actions (recomendado)

1. Sube este proyecto a un repositorio de GitHub
2. Ve a la pestaña **Actions**
3. Ejecuta el workflow **"Build Android APK (Flutter)"**
4. Descarga el artefacto `LibertadFinanciera-Premium-APK`

### Opción 2: En tu computadora

```bash
flutter pub get
flutter build apk --release
```

El APK quedará en:
`build/app/outputs/flutter-apk/app-release.apk`

## Requisitos

- Flutter 3.24+
- Android SDK 21+

## Notas

- La voz del mentor usa el motor TTS del dispositivo (funciona offline).
- El progreso se guarda localmente en el teléfono.
- Todo el contenido educativo está incluido en la app.
