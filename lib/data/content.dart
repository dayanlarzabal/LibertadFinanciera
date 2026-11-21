// Contenido educativo premium basado en los mejores libros de finanzas e inversión

class Book {
  final String id;
  final String title;
  final String author;
  final String emoji;
  final String description;
  final List<Lesson> lessons;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.emoji,
    required this.description,
    required this.lessons,
  });
}

class Lesson {
  final String id;
  final String title;
  final String summary;
  final String fullText; // Texto completo para el mentor (TTS)
  final int durationMinutes;

  const Lesson({
    required this.id,
    required this.title,
    required this.summary,
    required this.fullText,
    required this.durationMinutes,
  });
}

class DailyMentor {
  final String title;
  final String excerpt;
  final String fullScript;

  const DailyMentor({
    required this.title,
    required this.excerpt,
    required this.fullScript,
  });
}

// ============== CONTENIDO PRINCIPAL ==============

const List<Book> allBooks = [
  Book(
    id: 'padre_rico',
    title: 'Padre Rico, Padre Pobre',
    author: 'Robert Kiyosaki',
    emoji: '💰',
    description: 'La diferencia entre activos y pasivos. Cómo hacer que el dinero trabaje para ti.',
    lessons: [
      Lesson(
        id: 'pr_1',
        title: 'La mentalidad del rico vs el pobre',
        summary: 'Por qué los ricos compran activos y los pobres compran pasivos.',
        fullText: '''Bienvenido. Hoy hablaremos de una de las lecciones más poderosas de Robert Kiyosaki.

La mayoría de las personas trabajan por dinero. Se levantan, van a su empleo, reciben un sueldo y lo gastan en cosas que no les generan más dinero: un auto más caro, una casa más grande, ropa de marca. Esas cosas se llaman pasivos. Te quitan dinero del bolsillo.

Los ricos hacen lo contrario. Usan su dinero para comprar activos: cosas que ponen dinero en su bolsillo. Un negocio, acciones que pagan dividendos, propiedades que generan renta, derechos de autor.

La pregunta más importante que debes hacerte cada vez que vas a gastar es: ¿Esto es un activo o un pasivo? ¿Este gasto pondrá dinero en mi bolsillo o me lo quitará?

Empieza hoy. Aunque sea con poco. Compra tu primer activo. Incluso si es pequeño. Esa es la mentalidad que separa a quienes logran la libertad financiera de quienes nunca la alcanzan.''',
        durationMinutes: 4,
      ),
      Lesson(
        id: 'pr_2',
        title: 'Activos vs Pasivos',
        summary: 'La regla de oro del flujo de efectivo.',
        fullText: '''Escucha con atención. Esta es la regla más importante de las finanzas personales según Kiyosaki.

Un activo es cualquier cosa que pone dinero en tu bolsillo. Un pasivo es cualquier cosa que saca dinero de tu bolsillo.

Tu casa principal, aunque mucha gente cree que es un activo, generalmente es un pasivo: impuestos, mantenimiento, hipoteca. El auto nuevo pierde valor desde que sales del concesionario y te genera gastos de gasolina, seguros y reparaciones.

¿Qué sí son activos? Una propiedad que alquilas. Acciones de empresas sólidas que pagan dividendos. Un negocio que genera ingresos sin que tú estés presente todo el tiempo. Un libro o curso que creas y vende mientras duermes.

Tu objetivo debe ser aumentar tus activos y reducir tus pasivos. Cada mes revisa tu flujo de efectivo. ¿Cuánto dinero entra por activos? ¿Cuánto sale por pasivos? Esa diferencia determina tu velocidad hacia la libertad financiera.''',
        durationMinutes: 5,
      ),
      Lesson(
        id: 'pr_3',
        title: 'Trabaja para aprender, no solo por dinero',
        summary: 'La verdadera educación financiera se obtiene en el campo.',
        fullText: '''Kiyosaki insiste en algo que pocas escuelas enseñan: trabaja para aprender, no solo por un sueldo.

En tus primeros años, elige trabajos y proyectos que te den habilidades valiosas: ventas, marketing, contabilidad, liderazgo, negociación. Esas habilidades son el verdadero capital.

Muchas personas se quedan atrapadas en empleos que pagan bien pero no les enseñan nada nuevo. Con el tiempo se vuelven dependientes de ese sueldo y tienen miedo de arriesgarse.

La persona que sabe vender puede crear cualquier negocio. La persona que entiende números puede evaluar cualquier inversión. La persona que lidera puede escalar.

Invierte en ti mismo primero. Lee, practica, equivócate en pequeño, aprende rápido. Ese es el camino más seguro hacia la libertad financiera.''',
        durationMinutes: 4,
      ),
    ],
  ),
  Book(
    id: 'inversor_inteligente',
    title: 'El Inversor Inteligente',
    author: 'Benjamin Graham',
    emoji: '📊',
    description: 'El libro que formó a Warren Buffett. Inversión en valor y margen de seguridad.',
    lessons: [
      Lesson(
        id: 'ii_1',
        title: 'Inversor vs Especulador',
        summary: 'La diferencia fundamental que todo el mundo debe entender.',
        fullText: '''Benjamin Graham, el maestro de Warren Buffett, hace una distinción clara y poderosa.

El inversor compra una parte de un negocio. Analiza su valor intrínseco, su capacidad de generar ganancias a largo plazo, y paga un precio razonable o preferiblemente inferior a ese valor.

El especulador compra un papel con la esperanza de vendérselo a alguien más a un precio más alto en el corto plazo. No le importa el negocio real, solo el movimiento del precio.

La mayoría de las personas en el mercado actúan como especuladores, aunque se llamen a sí mismos inversores. Se dejan llevar por noticias, por el miedo y por la codicia.

Un inversor inteligente es paciente, disciplinado y se enfoca en el valor. No necesita predecir el mercado. Solo necesita comprar buenos negocios a buenos precios y dejar que el tiempo haga su trabajo.''',
        durationMinutes: 4,
      ),
      Lesson(
        id: 'ii_2',
        title: 'El margen de seguridad',
        summary: 'La idea más importante de toda la inversión.',
        fullText: '''Si tuvieras que quedarte con una sola idea de Benjamin Graham, que sea esta: el margen de seguridad.

Nunca pagues el precio completo por un activo. Busca siempre un colchón. Compra cuando el precio de mercado esté significativamente por debajo de tu estimación del valor real.

¿Por qué? Porque te puedes equivocar en el análisis. Porque pueden pasar cosas inesperadas. Porque el mercado puede tardar más de lo que crees en reconocer el valor.

Ese margen de seguridad es tu protección. Es lo que te permite dormir tranquilo cuando el mercado cae. Es lo que convierte una buena inversión en una excelente inversión a largo plazo.

Warren Buffett resume esto con una frase simple: "Regla número uno: nunca pierdas dinero. Regla número dos: nunca olvides la regla número uno." El margen de seguridad es la herramienta práctica para cumplir esa regla.''',
        durationMinutes: 4,
      ),
      Lesson(
        id: 'ii_3',
        title: 'Mr. Market, tu socio emocional',
        summary: 'Cómo usar la locura del mercado a tu favor.',
        fullText: '''Graham inventó un personaje brillante: Mr. Market.

Imagina que tienes un socio de negocios llamado Mr. Market. Cada día este socio aparece y te ofrece comprarte tu parte del negocio o venderte la suya. Algunos días está eufórico y te ofrece precios ridículamente altos. Otros días está deprimido y te ofrece precios absurdamente bajos.

Tú no estás obligado a hacerle caso. Puedes ignorarlo la mayoría de los días. Solo actúas cuando te ofrece un precio que te conviene: compras cuando está demasiado pesimista y vendes cuando está demasiado optimista.

El mercado de valores es exactamente así. La mayoría de las personas se dejan contagiar por la emoción de Mr. Market. El inversor inteligente lo usa como una herramienta, no como un guía.

Cuando todos tienen miedo, suele ser buen momento para comprar. Cuando todos están eufóricos, suele ser buen momento para ser cauteloso.''',
        durationMinutes: 5,
      ),
    ],
  ),
  Book(
    id: 'psicologia_dinero',
    title: 'La Psicología del Dinero',
    author: 'Morgan Housel',
    emoji: '🧠',
    description: 'Cómo se comporta realmente la gente con el dinero y por qué importa más que la inteligencia.',
    lessons: [
      Lesson(
        id: 'pd_1',
        title: 'La riqueza es lo que no se ve',
        summary: 'La verdadera riqueza es el dinero que no gastas.',
        fullText: '''Morgan Housel tiene una idea que cambia la forma de ver el dinero: la riqueza es lo que no se ve.

Cuando ves a alguien con un auto de lujo, un reloj caro o una casa grande, estás viendo su ingreso o su deuda, no necesariamente su riqueza. La verdadera riqueza es el auto que no compró, las vacaciones que no tomó, las cosas que decidió no mostrar.

La riqueza es la opción. Es la capacidad de poder decir "no" cuando quieres. Es la libertad de despertarte y decidir qué hacer con tu tiempo.

Gastar dinero para mostrar estatus es una de las formas más rápidas de destruir la posibilidad de ser realmente rico. La gente más rica que conozco suele vivir por debajo de sus posibilidades. No porque sean tacaños, sino porque valoran más la libertad que las apariencias.''',
        durationMinutes: 4,
      ),
      Lesson(
        id: 'pd_2',
        title: 'El poder del tiempo y el interés compuesto',
        summary: 'Por qué empezar temprano importa más que ser brillante.',
        fullText: '''Hay una historia que Housel cuenta y que vale oro: alguien que invierte de forma constante durante décadas, aunque sea con montos modestos, puede terminar con más dinero que alguien que gana mucho pero empieza tarde o interrumpe el proceso.

El interés compuesto es la fuerza más poderosa en las finanzas. Pero necesita tiempo. Mucho tiempo. Y la mayoría de las personas no le dan tiempo suficiente porque se impacientan o porque intentan hacerse ricos rápido.

La paciencia no es solo una virtud moral. Es una ventaja financiera brutal. Quien puede mantener una estrategia simple durante 20 o 30 años tiene una probabilidad altísima de obtener resultados extraordinarios.

No necesitas ser el inversor más inteligente de la habitación. Necesitas ser el que se queda más tiempo en el juego.''',
        durationMinutes: 4,
      ),
      Lesson(
        id: 'pd_3',
        title: 'Suficiente: la palabra más poderosa',
        summary: 'Saber cuándo tienes suficiente es la clave de la felicidad financiera.',
        fullText: '''Una de las lecciones más profundas de La Psicología del Dinero es el concepto de "suficiente".

Muchas personas nunca sienten que tienen suficiente. Siempre quieren más. Más ingresos, más cosas, más estatus. Ese deseo constante de más es una de las principales causas de decisiones financieras tontas: asumir demasiado riesgo, endeudarse de más, comparar constantemente.

Saber definir qué es suficiente para ti te da paz. Te permite dejar de correr. Te permite disfrutar lo que ya tienes mientras sigues construyendo de forma inteligente.

La libertad financiera no es un número mágico en la cuenta bancaria. Es el punto en el que tus activos generan suficiente ingreso como para cubrir el estilo de vida que realmente quieres. Y ese estilo de vida no tiene por qué ser extravagante.

Define tu "suficiente". Escríbelo. Revísalo. Y defiéndelo de la tentación constante de querer más solo porque otros tienen más.''',
        durationMinutes: 5,
      ),
    ],
  ),
  Book(
    id: 'babilonia',
    title: 'El Hombre Más Rico de Babilonia',
    author: 'George S. Clason',
    emoji: '🏛️',
    description: 'Las leyes eternas del dinero contadas a través de historias de la antigua Babilonia.',
    lessons: [
      Lesson(
        id: 'bab_1',
        title: 'Págate a ti primero',
        summary: 'Guarda al menos el 10% de todo lo que ganes.',
        fullText: '''Hace más de 90 años, George Clason escribió una de las lecciones más simples y poderosas de la historia del dinero: págate a ti primero.

De cada moneda que ganes, toma al menos una de cada diez y guárdala. No la toques. No la gastes. Esa moneda es tuya. Las otras nueve pueden pagar tus gastos y deudas.

La mayoría de las personas hacen lo contrario: pagan todo lo demás primero y si sobra algo, entonces ahorran. El problema es que casi nunca sobra.

Cuando te pagas primero, estás construyendo tu propio capital. Ese capital, con el tiempo, empieza a trabajar para ti. Se convierte en el huevo de la gallina de los huevos de oro.

Empieza hoy. Aunque ganes poco. Aunque tengas deudas. Guarda al menos el 10%. Es la base de toda riqueza duradera.''',
        durationMinutes: 3,
      ),
      Lesson(
        id: 'bab_2',
        title: 'Haz que tu dinero trabaje',
        summary: 'Pon a cada moneda a generar más monedas.',
        fullText: '''Una vez que has aprendido a guardar una parte de lo que ganas, el siguiente paso es hacer que ese dinero trabaje.

El dinero que está debajo del colchón o en una cuenta que no genera nada, está dormido. El dinero que se invierte en activos productivos empieza a generar más dinero.

En las historias de Babilonia, los personajes aprenden a prestar con sabiduría, a invertir en negocios que entienden y a hacer que cada moneda sea un soldado que sale a conquistar más monedas.

No necesitas ser un genio de las finanzas. Necesitas disciplina para ahorrar y suficiente conocimiento para poner ese ahorro en lugares donde pueda crecer de forma razonable y segura a largo plazo.

Empieza simple. Un fondo indexado global. Una propiedad pequeña. Un negocio que conoces bien. Lo importante es que tu dinero deje de ser pasivo y se convierta en un generador de más dinero.''',
        durationMinutes: 4,
      ),
      Lesson(
        id: 'bab_3',
        title: 'Protégete de las pérdidas',
        summary: 'La preservación del capital es sagrada.',
        fullText: '''Clason enseña una lección que muchos olvidan cuando empiezan a ganar dinero: protege tu capital.

Es mucho más fácil perder dinero del que ya tienes que recuperarlo después. Por eso la preservación del capital es sagrada.

No inviertas en cosas que no entiendes. No te dejes llevar por promesas de ganancias rápidas y enormes. No pongas todo tu dinero en una sola apuesta.

Diversifica. Estudia antes de actuar. Desconfía de cualquiera que te prometa resultados extraordinarios sin riesgo. Y recuerda que el primer objetivo de cualquier plan financiero es no quedar en la ruina.

La riqueza se construye despacio y se puede destruir rápido. Sé un guardián cuidadoso de lo que has logrado acumular.''',
        durationMinutes: 3,
      ),
    ],
  ),
  Book(
    id: 'piense_hagase_rico',
    title: 'Piense y Hágase Rico',
    author: 'Napoleon Hill',
    emoji: '🔥',
    description: 'El clásico de la mentalidad de éxito. Deseo, fe, persistencia y el poder del pensamiento.',
    lessons: [
      Lesson(
        id: 'phr_1',
        title: 'El deseo ardiente',
        summary: 'Todo logro comienza con un deseo claro y quemante.',
        fullText: '''Napoleon Hill estudió a los hombres más exitosos de su época y llegó a una conclusión: todo empieza con un deseo ardiente.

No un deseo vago. No un "me gustaría ser rico". Un deseo claro, específico, escrito, con fecha y con un plan.

Hill recomienda escribir exactamente cuánto dinero quieres, para cuándo lo quieres, qué estás dispuesto a dar a cambio, y leer ese escrito en voz alta dos veces al día: al despertar y antes de dormir.

Suena simple. Incluso absurdo para algunas personas. Pero la claridad de intención tiene un poder enorme. Enfoca tu mente. Hace que notes oportunidades que antes pasaban desapercibidas. Te empuja a actuar.

Si tu deseo de libertad financiera es tibio, los resultados serán tibios. Si es ardiente, constante y específico, las probabilidades cambian radicalmente a tu favor.''',
        durationMinutes: 4,
      ),
      Lesson(
        id: 'phr_2',
        title: 'La fe y la autosugestión',
        summary: 'Cómo programar tu mente para el éxito.',
        fullText: '''Hill enseña que la fe es un estado mental que se puede cultivar. Y una de las herramientas principales es la autosugestión.

Repetir de forma consciente y emocional las ideas que quieres que tu subconsciente acepte. Visualizarte ya habiendo logrado tu objetivo. Sentir las emociones de ese logro antes de que ocurra.

Esto no es magia. Es entrenamiento mental. Tu cerebro tiende a moverse en la dirección de tus pensamientos dominantes. Si tus pensamientos dominantes son de escasez, miedo y limitación, actuarás en consecuencia. Si son de posibilidad, capacidad y abundancia, también actuarás en consecuencia.

Dedica unos minutos cada día a programar tu mente. Lee tus metas. Visualiza. Siente. Luego sal y trabaja como si ya fuera inevitable.''',
        durationMinutes: 4,
      ),
      Lesson(
        id: 'phr_3',
        title: 'La persistencia',
        summary: 'El hábito que separa a quienes logran de quienes abandonan.',
        fullText: '''De todas las cualidades que Hill identificó en las personas exitosas, la persistencia es una de las más decisivas.

La mayoría de las personas abandonan cuando las cosas se ponen difíciles. Justo en el momento en que están más cerca del avance. La persistencia es la capacidad de seguir cuando ya no tienes ganas, cuando no ves resultados inmediatos, cuando otros dudan de ti.

La persistencia se cultiva. Se fortalece cada vez que decides continuar a pesar de la dificultad. Se debilita cada vez que te rindes.

Decide de antemano que no vas a abandonar tu camino hacia la libertad financiera. Habrá meses malos. Habrá inversiones que no saldrán como esperabas. Habrá momentos de duda. Eso es normal. Lo que no es normal, y lo que separa a los que logran, es la decisión inquebrantable de continuar.

Persiste. Un día más. Una acción más. Un mes más. El tiempo y la consistencia hacen el resto.''',
        durationMinutes: 4,
      ),
    ],
  ),
];

// Mentor diario (se puede rotar)
const List<DailyMentor> dailyMentors = [
  DailyMentor(
    title: 'La mentalidad del inversor',
    excerpt: 'Hoy exploramos por qué la mayoría de las personas trabajan por dinero... y cómo tú puedes hacer que el dinero trabaje para ti.',
    fullScript: '''Buenas. Soy tu mentor financiero.

Hoy quiero que reflexiones sobre una pregunta simple pero profunda: ¿estás trabajando por dinero o estás haciendo que el dinero trabaje para ti?

La mayoría de las personas intercambian tiempo por dinero. Ese es el empleo tradicional. No tiene nada de malo al principio. De hecho, es necesario. Pero si te quedas ahí toda la vida, nunca alcanzarás la verdadera libertad.

La libertad financiera llega cuando tus activos generan suficiente ingreso como para cubrir tus gastos. Cuando puedes dejar de trabajar y tu estilo de vida no se derrumba.

Empieza pequeño. Aprende a diferenciar activos de pasivos. Ahorra con disciplina. Invierte con inteligencia. Y sobre todo, cultiva la paciencia. El tiempo es el mejor amigo del inversor disciplinado.

Nos vemos en la próxima lección. Sigue construyendo.''',
  ),
  DailyMentor(
    title: 'El poder de pagarte primero',
    excerpt: 'La regla de Babilonia que ha creado más millonarios de los que se pueden contar.',
    fullScript: '''Escúchame bien. Esta es una de las reglas más simples y más poderosas que existen.

Págate a ti primero. De todo lo que entre, toma al menos el diez por ciento y guárdalo antes de pagar cualquier otra cosa.

No es lo que te sobra al final del mes. Es lo primero que haces. Como si fuera el gasto más importante de todos. Porque lo es.

Ese dinero que te pagas a ti mismo se convierte en la semilla de tu libertad. Con el tiempo, y si lo inviertes con inteligencia, crece. Y un día ese crecimiento empieza a pagar tus gastos.

Empieza hoy. Aunque sea con poco. La cantidad importa menos que el hábito. El hábito es lo que te transforma.''',
  ),
  DailyMentor(
    title: 'Suficiente es poder',
    excerpt: 'La lección más subestimada de La Psicología del Dinero.',
    fullScript: '''Hoy quiero hablarte de una palabra que puede cambiar tu relación con el dinero: suficiente.

La mayoría de las personas nunca sienten que tienen suficiente. Siempre quieren más. Y esa búsqueda constante de más es lo que las mantiene atrapadas: más riesgo del necesario, más comparación, más ansiedad.

Definir qué es suficiente para ti te da una ventaja enorme. Te permite construir con propósito en lugar de correr sin destino. Te permite disfrutar el camino.

Siéntate y escribe: ¿Cuánto necesito realmente para vivir el estilo de vida que quiero? ¿Qué cosas realmente aportan valor a mi vida y cuáles solo alimentan el ego?

Una vez que tengas claridad, defiende ese número. No dejes que el ruido del mundo te convenza de que necesitas más de lo que realmente necesitas.''',
  ),
];

// Plan de acción semanal
class ActionItem {
  final String id;
  final String title;
  final String description;
  final String category;

  const ActionItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
  });
}

const List<ActionItem> weeklyActions = [
  ActionItem(
    id: 'a1',
    title: 'Revisa tus gastos de la semana',
    description: 'Identifica al menos 3 gastos que no generaron valor real y elimínalos o redúcelos.',
    category: 'Conciencia',
  ),
  ActionItem(
    id: 'a2',
    title: 'Págate primero',
    description: 'Transfiere al menos el 10% de tus ingresos a una cuenta o inversión separada antes de gastar.',
    category: 'Hábito',
  ),
  ActionItem(
    id: 'a3',
    title: 'Estudia un activo',
    description: 'Elige un tipo de activo (acciones, bienes raíces, negocio) y dedica 30 minutos a entenderlo mejor.',
    category: 'Educación',
  ),
  ActionItem(
    id: 'a4',
    title: 'Calcula tu número de libertad',
    description: 'Estima cuánto necesitas en activos para cubrir tus gastos anuales. Ese es tu objetivo principal.',
    category: 'Claridad',
  ),
  ActionItem(
    id: 'a5',
    title: 'Habla de dinero con alguien',
    description: 'Comparte una lección que aprendiste esta semana con un amigo o familiar. Enseñar refuerza el aprendizaje.',
    category: 'Comunidad',
  ),
  ActionItem(
    id: 'a6',
    title: 'Evita una compra impulsiva',
    description: 'Cuando sientas el impulso de comprar algo no esencial, espera 48 horas antes de decidir.',
    category: 'Disciplina',
  ),
];
