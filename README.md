# Libertad Financiera — Android

Aplicación educativa Android en Kotlin. Incluye:
- Biblioteca de libros con fichas y resúmenes originales narrados mediante Text-to-Speech.
- Lecciones financieras narradas.
- Simulador de aportes e interés compuesto.
- Seguimiento local del progreso.
- Pantalla Premium de demostración.

## Importante sobre derechos de autor
La versión inicial NO contiene audiolibros completos de terceros. Para publicar audiolibros íntegros se deben adquirir licencias o utilizar obras de dominio público verificadas. Los resúmenes y textos incluidos son originales y educativos. No se deben subir archivos de libros protegidos sin autorización.

## Compilar en GitHub
1. Sube el contenido de esta carpeta a la raíz de un repositorio GitHub.
2. Añade el workflow `.github/workflows/android.yml` (se entrega en este proyecto).
3. Abre Actions, selecciona **Build Android APK** y pulsa **Run workflow**.
4. Al terminar, descarga el artefacto `LibertadFinanciera-debug-apk`.

## Configuración técnica
- Android Gradle Plugin 8.7.3
- Kotlin 2.0.21
- JDK 17
- Android SDK 35
- Paquete: `com.libertadfinanciera.app`
- Min Android: 6.0 (API 23)

## Próximas integraciones
- Compras premium reales (Google Play Billing o proveedor compatible con distribución directa).
- Backend y cuentas de usuario.
- Descargas offline de audio con licencias.
- Panel administrativo para gestionar catálogo y permisos.
- Política de privacidad y términos de uso.
