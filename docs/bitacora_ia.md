# Bitácora de IA

## Registro inicial real

**Herramienta:** Codex.

**Peticiones del alumno:**

1. «tengo que hacer este proyecto de flutter en vs code en el enunciad.md esta como debe estructurarse el proyecto, antes de comenzar con todo el proyecto quiro que lo analices me digas que vas a necesitar o si no necesitas nada y que modelo de chatgpt y potencia puede ser el mejor para usar, tampoco me quiero quedar sin todos los tokens»
2. «bueno pues empieza con todo el proyecto base, con el estilo que quieras, pero que se vea bien hecho»

**Ayuda recibida:** análisis del enunciado, creación del proyecto y base de las pantallas, modelo, almacenamiento, tema y pruebas. La implementación se generó en un bloque de trabajo por petición expresa; el enunciado pide revisarla y aprenderla fase a fase.

**Aceptado, modificado o descartado por mí:** pendiente de completar por el alumno tras revisar el código.

**Errores que detecté personalmente:** pendiente de completar; no atribuirse comprobaciones realizadas únicamente por la IA.

## Preparación de la entrega — 17/11/2026

**Herramienta:** ChatGPT / Codex.

**Peticiones literales de esta revisión:**

1. «Tengo hecha esta app flutter analiza la carpeta con los archivos y la documentacion»
2. «vale pues necesito tener todo hecho prepara el proyecto porque ademas lo tendre que entregrar, lo mas seguro es que lo meta en un repostorio de git»

Las fases siguientes documentan la revisión de una base ya generada, no nueve sesiones de trabajo personal ni prompts que no se realizaron. Los comentarios técnicos añadidos en esta revisión proceden de IA.

## Fase 0 · Diseño en papel (sin IA, 30 min)

**Herramienta y ayuda recibida:** Ninguna para el boceto personal. El enunciado exige realizar el boceto sin IA. No se ha creado ni atribuido un boceto manual al alumno. Falta añadir docs/boceto.png.

**Prompts:** véanse el registro inicial y las dos peticiones literales anteriores; no hubo un prompt independiente por fase en esta preparación.

**Qué acepté, modifiqué o descarté personalmente:** pendiente de completar por Alejandro tras revisar esta fase.

**Errores detectados personalmente:** pendiente de completar; distinguir de los hallazgos de la revisión de IA.

**Lo que aprendí (mis palabras):** pendiente de completar por Alejandro.

## Fase 1 · Modelo de datos

**Herramienta y ayuda recibida:** Codex para la base y su revisión. La base contiene Elemento, Tipo y Estado, validación, toJson, fromJson y copyWith. La revisión comprueba que se conservan id y fechaAlta al editar y que notas puede faltar.

**Prompts:** véanse el registro inicial y las dos peticiones literales anteriores; no hubo un prompt independiente por fase en esta preparación.

**Qué acepté, modifiqué o descarté personalmente:** pendiente de completar por Alejandro tras revisar esta fase.

**Errores detectados personalmente:** pendiente de completar; distinguir de los hallazgos de la revisión de IA.

**Lo que aprendí (mis palabras):** pendiente de completar por Alejandro.

**Preguntas de comprensión — responder sin IA:**

1. ¿Por qué los campos son `final`? ¿Cómo «cambio» entonces el estado de un elemento?
2. ¿Cómo se guarda un `enum` en JSON y cómo se recupera?
3. ¿Qué pasaría en `fromJson` si el JSON no trae el campo `notas`?

**Mis respuestas:** pendientes de completar personalmente.

## Fase 2 · Lista y tarjeta (R1, R2, R12 parcial)

**Herramienta y ayuda recibida:** Codex para la base y su revisión. La base contiene TarjetaElemento, SelectorEstrellas y los estados de colección vacía y búsqueda sin resultados. Se usa SliverList.separated dentro de CustomScrollView para construir la lista bajo demanda.

**Prompts:** véanse el registro inicial y las dos peticiones literales anteriores; no hubo un prompt independiente por fase en esta preparación.

**Qué acepté, modifiqué o descarté personalmente:** pendiente de completar por Alejandro tras revisar esta fase.

**Errores detectados personalmente:** pendiente de completar; distinguir de los hallazgos de la revisión de IA.

**Lo que aprendí (mis palabras):** pendiente de completar por Alejandro.

**Preguntas de comprensión — responder sin IA:**

1. ¿Qué diferencia hay entre `ListView` y `ListView.builder`? ¿Cuándo conviene cada uno?
2. ¿Por qué `TarjetaElemento` recibe una función en lugar de navegar ella misma?
3. ¿`TarjetaElemento` es `StatelessWidget` o `StatefulWidget`? ¿Por qué?

**Mis respuestas:** pendientes de completar personalmente.

## Fase 3 · Formulario de alta (R3, R4)

**Herramienta y ayuda recibida:** Codex para la base y su revisión. El formulario de la base contiene Form, GlobalKey, controladores, desplegables y estrellas interactivas. Se revisan la validación del título y la liberación de controladores y FocusNode.

**Prompts:** véanse el registro inicial y las dos peticiones literales anteriores; no hubo un prompt independiente por fase en esta preparación.

**Qué acepté, modifiqué o descarté personalmente:** pendiente de completar por Alejandro tras revisar esta fase.

**Errores detectados personalmente:** pendiente de completar; distinguir de los hallazgos de la revisión de IA.

**Lo que aprendí (mis palabras):** pendiente de completar por Alejandro.

**Preguntas de comprensión — responder sin IA:**

1. ¿Qué hace `_formKey.currentState!.validate()` y qué significa el `!`?
2. ¿Por qué hay que llamar a `dispose()` de los controladores?
3. Explica el viaje del dato: desde que pulsas Guardar hasta que aparece en la lista.

**Mis respuestas:** pendientes de completar personalmente.

## Fase 4 · Detalle, edición y borrado (R5, R6, R7)

**Herramienta y ayuda recibida:** Codex para la base y su revisión. La base reutiliza el formulario para editar, pide confirmación al borrar y devuelve las acciones a la lista. Las pruebas existentes incluyen persistencia de cambios y cancelación.

**Prompts:** véanse el registro inicial y las dos peticiones literales anteriores; no hubo un prompt independiente por fase en esta preparación.

**Qué acepté, modifiqué o descarté personalmente:** pendiente de completar por Alejandro tras revisar esta fase.

**Errores detectados personalmente:** pendiente de completar; distinguir de los hallazgos de la revisión de IA.

**Lo que aprendí (mis palabras):** pendiente de completar por Alejandro.

**Preguntas de comprensión — responder sin IA:**

1. ¿Cómo sabe el formulario si está creando o editando?
2. ¿Cómo encuentra la lista qué elemento debe reemplazar al volver de la edición?
3. ¿Qué devuelve `showDialog` y cómo lo usas para saber si el usuario confirmó?

**Mis respuestas:** pendientes de completar personalmente.

## Fase 5 · Filtro y búsqueda (R8, R9)

**Herramienta y ayuda recibida:** Codex para la base y su revisión. La base calcula una lista visible con where y combina estado y búsqueda en minúsculas sin borrar la colección original.

**Prompts:** véanse el registro inicial y las dos peticiones literales anteriores; no hubo un prompt independiente por fase en esta preparación.

**Qué acepté, modifiqué o descarté personalmente:** pendiente de completar por Alejandro tras revisar esta fase.

**Errores detectados personalmente:** pendiente de completar; distinguir de los hallazgos de la revisión de IA.

**Lo que aprendí (mis palabras):** pendiente de completar por Alejandro.

**Preguntas de comprensión — responder sin IA:**

1. ¿Por qué se filtra sobre una lista calculada y no sobre la original?
2. ¿Qué método usas para que «dune» encuentre «Dune»?
3. Si filtras por Terminado y buscas un título pendiente, ¿qué debe verse? ¿Lo has probado?

**Mis respuestas:** pendientes de completar personalmente.

## Fase 6 · Persistencia (R10)

**Herramienta y ayuda recibida:** Codex para la base y su revisión. La base guarda la lista JSON con la clave watchlist y shared_preferences. Esta preparación ha regenerado las dependencias porque conservaban rutas del ordenador de clase.

**Prompts:** véanse el registro inicial y las dos peticiones literales anteriores; no hubo un prompt independiente por fase en esta preparación.

**Qué acepté, modifiqué o descarté personalmente:** pendiente de completar por Alejandro tras revisar esta fase.

**Errores detectados personalmente:** pendiente de completar; distinguir de los hallazgos de la revisión de IA.

**Lo que aprendí (mis palabras):** pendiente de completar por Alejandro.

**Preguntas de comprensión — responder sin IA:**

1. ¿Por qué `cargar()` devuelve un `Future`? ¿Qué pasaría si la pantalla intentara pintar la lista antes de que termine?
2. ¿Por qué no se puede usar `await` directamente dentro de `initState`? ¿Cómo lo has resuelto?
3. ¿Dónde están físicamente los datos? ¿Se pierden si desinstalas la app?

**Mis respuestas:** pendientes de completar personalmente.

## Fase 7 · Estadísticas y tema (R11, R13)

**Herramienta y ayuda recibida:** Codex para la base y su revisión. La base incluye el tema oscuro, barras por estado y tipo, media sin ceros y tratamiento de la colección vacía y de los empates.

**Prompts:** véanse el registro inicial y las dos peticiones literales anteriores; no hubo un prompt independiente por fase en esta preparación.

**Qué acepté, modifiqué o descarté personalmente:** pendiente de completar por Alejandro tras revisar esta fase.

**Errores detectados personalmente:** pendiente de completar; distinguir de los hallazgos de la revisión de IA.

**Lo que aprendí (mis palabras):** pendiente de completar por Alejandro.

**Preguntas de comprensión — responder sin IA:**

1. ¿Cómo has evitado dividir entre cero en la valoración media?
2. ¿Por qué los elementos con 0 estrellas no cuentan para la media?
3. ¿Qué ventaja tiene definir los colores en el tema en lugar de en cada widget?

**Mis respuestas:** pendientes de completar personalmente.

## Fase 8 · Pruebas y documentación

**Herramienta y ayuda recibida:** Codex para la base y su revisión. Esta preparación revisa pruebas, documentación y capturas; añade comentarios técnicos de IA, instrucciones de Git, exclusiones y un script para empaquetar código y web. Los resultados ejecutados constan en VALIDACION.md.

**Prompts:** véanse el registro inicial y las dos peticiones literales anteriores; no hubo un prompt independiente por fase en esta preparación.

**Qué acepté, modifiqué o descarté personalmente:** pendiente de completar por Alejandro tras revisar esta fase.

**Errores detectados personalmente:** pendiente de completar; distinguir de los hallazgos de la revisión de IA.

**Lo que aprendí (mis palabras):** pendiente de completar por Alejandro.

**Preguntas de comprensión — responder sin IA:**

1. ¿Qué diferencia hay entre una prueba unitaria y una de widget?
2. ¿Qué hace `tester.pump()` y por qué hace falta después de pulsar un botón?

**Mis respuestas:** pendientes de completar personalmente.
