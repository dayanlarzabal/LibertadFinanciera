package com.libertadfinanciera.app

import android.app.Activity
import android.os.Bundle
import android.speech.tts.TextToSpeech
import android.widget.*
import android.graphics.Color
import android.view.Gravity
import android.view.ViewGroup
import android.content.Context
import java.util.Locale
import kotlin.math.roundToInt

class MainActivity : Activity(), TextToSpeech.OnInitListener {
    private val bg = Color.rgb(10, 24, 20)
    private val panel = Color.rgb(20, 43, 34)
    private val gold = Color.rgb(222, 180, 83)
    private val cream = Color.rgb(244, 240, 225)
    private lateinit var root: LinearLayout
    private lateinit var tts: TextToSpeech
    private var ttsReady = false
    private var premiumUnlocked = false

    private val lessons = listOf(
        "Mentalidad financiera" to "La libertad financiera comienza cuando tus ingresos pueden cubrir tus gastos sin depender exclusivamente de tu tiempo. Aprende a distinguir necesidades, deseos y prioridades.",
        "Presupuesto inteligente" to "Registra cuánto entra y cuánto sale. Separa primero una cantidad para ahorrar, crea un fondo de emergencia y revisa tus gastos cada semana.",
        "Activos y pasivos" to "Un activo puede poner dinero en tu bolsillo; un pasivo suele retirar dinero. Analiza el flujo de efectivo real antes de comprar o invertir.",
        "Interés compuesto" to "El interés compuesto permite que los rendimientos generen nuevos rendimientos. El tiempo, la constancia, los costos y el riesgo influyen en el resultado.",
        "Diversificación y riesgo" to "No pongas todo tu capital en una sola inversión. Diversificar reduce la dependencia de un único activo, aunque no elimina el riesgo de pérdida."
    )
    private val books = listOf(
        Triple("Padre rico, padre pobre", "Robert T. Kiyosaki", "Resumen original y guía de conceptos. El audiolibro completo requiere licencia."),
        Triple("El hombre más rico de Babilonia", "George S. Clason", "Lecciones sobre ahorro, disciplina y administración del dinero."),
        Triple("Piense y hágase rico", "Napoleon Hill", "Resumen educativo sobre objetivos, hábitos y perseverancia."),
        Triple("El inversor inteligente", "Benjamin Graham", "Introducción a inversión de valor, margen de seguridad y paciencia.")
    )

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        tts = TextToSpeech(this, this)
        showHome()
    }

    override fun onInit(status: Int) {
        if (status == TextToSpeech.SUCCESS) {
            tts.language = Locale("es", "ES")
            ttsReady = true
        }
    }

    private fun base(title: String, subtitle: String) {
        root = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setBackgroundColor(bg)
            setPadding(22, 24, 22, 18)
        }
        val scroll = ScrollView(this)
        scroll.addView(root)
        setContentView(scroll)
        text(title, 27, gold, true)
        text(subtitle, 14, cream, false)
        space(14)
    }

    private fun text(value: String, size: Int, color: Int, bold: Boolean) {
        root.addView(TextView(this).apply {
            text = value
            textSize = size.toFloat()
            setTextColor(color)
            if (bold) setTypeface(null, android.graphics.Typeface.BOLD)
            setPadding(0, 5, 0, 7)
        })
    }

    private fun space(h: Int) {
        root.addView(android.view.View(this), LinearLayout.LayoutParams(1, h))
    }

    private fun button(label: String, action: () -> Unit) {
        root.addView(Button(this).apply {
            text = label
            setTextColor(Color.BLACK)
            setBackgroundColor(gold)
            textSize = 14f
            isAllCaps = false
            setOnClickListener { action() }
        }, LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT).apply {
            bottomMargin = 9
        })
    }

    private fun card(title: String, body: String) {
        val box = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(15, 12, 15, 12)
            setBackgroundColor(panel)
        }
        box.addView(TextView(this).apply {
            text = title; textSize = 18f; setTextColor(gold)
            setTypeface(null, android.graphics.Typeface.BOLD)
        })
        box.addView(TextView(this).apply {
            text = body; textSize = 14f; setTextColor(cream); setPadding(0, 6, 0, 0)
        })
        root.addView(box, LinearLayout.LayoutParams(-1, -2).apply { bottomMargin = 11 })
    }

    private fun showHome() {
        base("LIBERTAD FINANCIERA", "Aprende. Invierte. Construye tu futuro.")
        card("TU ACADEMIA FINANCIERA", "Aprende a administrar el dinero, crear activos y tomar decisiones con criterio.")
        button("📚 Biblioteca de audiolibros") { showBooks() }
        button("🎓 Cursos y lecciones") { showLessons() }
        button("📈 Simulador de inversión") { showSimulator() }
        button("🏆 Mi progreso") { showProgress() }
        button("⭐ Zona Premium") { showPremium() }
        text("Aviso: contenido educativo. No constituye asesoramiento financiero ni garantiza ganancias.", 12, cream, false)
    }

    private fun showBooks() {
        base("BIBLIOTECA", "Resúmenes narrados y acceso a obras con licencia.")
        books.forEachIndexed { index, b ->
            card(b.first, "${b.second}\n${b.third}")
            button(if (index == 0) "Escuchar resumen" else "Escuchar ficha y resumen") {
                val narration = "${b.first}. ${b.third} " +
                    "Recuerda: estudia las ideas, contrástalas y adapta lo aprendido a tu realidad."
                speak(narration)
            }
        }
        card("Audiolibros completos", "La aplicación está preparada para incorporar archivos o enlaces de audio cuya distribución esté autorizada. No se incluyen copias no autorizadas de libros protegidos.")
        button("Volver al inicio") { showHome() }
    }

    private fun showLessons() {
        base("ACADEMIA", "Lecciones breves para avanzar paso a paso.")
        lessons.forEachIndexed { i, lesson ->
            card("Nivel ${i + 1}: ${lesson.first}", lesson.second)
            button("▶ Escuchar lección") { speak("${lesson.first}. ${lesson.second}") }
        }
        button("Volver al inicio") { showHome() }
    }

    private fun showSimulator() {
        base("SIMULADOR", "Proyección educativa; no predice rendimientos reales.")
        val amount = EditText(this).apply {
            hint = "Capital inicial (ej. 1000)"
            inputType = 8194
            setTextColor(cream); setHintTextColor(Color.LTGRAY)
        }
        val monthly = EditText(this).apply {
            hint = "Aporte mensual (ej. 100)"
            inputType = 8194
            setTextColor(cream); setHintTextColor(Color.LTGRAY)
        }
        val rate = EditText(this).apply {
            hint = "Rendimiento anual estimado % (ej. 5)"
            inputType = 8194
            setTextColor(cream); setHintTextColor(Color.LTGRAY)
        }
        val years = EditText(this).apply {
            hint = "Años (ej. 10)"
            inputType = 2
            setTextColor(cream); setHintTextColor(Color.LTGRAY)
        }
        listOf(amount, monthly, rate, years).forEach {
            root.addView(it, LinearLayout.LayoutParams(-1, 54))
        }
        val result = TextView(this).apply { setTextColor(gold); textSize = 18f }
        root.addView(result)
        button("Calcular proyección") {
            val p = amount.text.toString().toDoubleOrNull() ?: 0.0
            val c = monthly.text.toString().toDoubleOrNull() ?: 0.0
            val r = (rate.text.toString().toDoubleOrNull() ?: 0.0) / 100.0 / 12.0
            val n = ((years.text.toString().toIntOrNull() ?: 0).coerceIn(0, 80) * 12)
            var total = p
            repeat(n) { total = total * (1 + r) + c }
            result.text = "Capital aportado: ${"%.2f".format(p + c * n)}\nValor proyectado: ${"%.2f".format(total)}\nResultado estimado: ${"%.2f".format(total - p - c * n)}"
        }
        button("Volver al inicio") { showHome() }
    }

    private fun showProgress() {
        base("MI PROGRESO", "Tu avance se guardará en este dispositivo.")
        val prefs = getSharedPreferences("progress", Context.MODE_PRIVATE)
        val completed = prefs.getInt("lessons", 0)
        card("Lecciones completadas", "$completed de ${lessons.size}")
        button("Marcar una lección como completada") {
            prefs.edit().putInt("lessons", (completed + 1).coerceAtMost(lessons.size)).apply()
            showProgress()
        }
        button("Volver al inicio") { showHome() }
    }

    private fun showPremium() {
        base("MEMBRESÍA PREMIUM", "Contenido ampliado para profundizar.")
        card("Incluido en Premium (preparado para activar)", "Cursos avanzados, biblioteca ampliada, audiolibros completos licenciados, guías descargables y rutas de aprendizaje.")
        card("Estado actual", if (premiumUnlocked) "Premium de demostración activado en este dispositivo." else "Versión inicial: compras reales todavía no están conectadas.")
        button("Activar demostración Premium") {
            premiumUnlocked = true
            showPremium()
        }
        button("Volver al inicio") { showHome() }
    }

    private fun speak(content: String) {
        if (ttsReady) tts.speak(content, TextToSpeech.QUEUE_FLUSH, null, "lf_narration")
        else Toast.makeText(this, "El motor de voz todavía se está preparando.", Toast.LENGTH_SHORT).show()
    }

    override fun onDestroy() {
        if (::tts.isInitialized) { tts.stop(); tts.shutdown() }
        super.onDestroy()
    }
}
