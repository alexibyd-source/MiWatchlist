# Validación de Mi Watchlist

Fecha de preparación: **17/11/2026**. Entorno: Windows, Flutter **3.50.0**, Dart **3.14.0**.

## Resultados ejecutados

| Comprobación | Resultado |
| --- | --- |
| Restaurar dependencias con flutter pub get | Correcto; rutas regeneradas para este ordenador |
| dart format lib test | 15 archivos revisados, sin cambios de formato |
| flutter analyze --no-pub | Sin incidencias |
| flutter test --no-pub | 13 pruebas superadas; 1 prueba de generación de capturas omitida por diseño |
| flutter build web --no-pub | Correcto; salida en build/web |

Las pruebas de almacenamiento utilizan preferencias simuladas. Comprueban lectura/escritura y contenido corrupto. Las pruebas de flujo cubren alta, edición, cancelación de borrado, borrado confirmado, búsqueda con filtro y estadísticas. Las pruebas del formulario cubren títulos vacíos, espacios, longitud excesiva y cancelación de edición. Las del modelo cubren JSON, copias y validación.

La prueba capturas_test.dart solo se ejecuta con CAPTURAS=true, porque su finalidad es escribir imágenes. Las capturas ya incluidas se generaron previamente con widgets reales y datos de muestra; no se han regenerado en esta preparación.

## Cambios de preparación

- Regeneración de dependencias con rutas del ordenador actual; no se versionan las rutas locales.
- Comentarios técnicos en clases y funciones de lib; el alumno debe revisarlos y expresarlos con sus palabras.
- README de ejecución, compilación, datos y dependencias.
- Bitácora estructurada en nueve fases, sin inventar respuestas personales ni trabajo manual.
- Guía de Git, exclusiones de archivos locales y script para generar paquetes.
- Copia del enunciado original en docs/ENUNCIADO.md.

## Límites de esta comprobación

No se ha realizado una demostración manual en navegador o móvil ni una instalación Android. La compilación entregada es la web, permitida por el enunciado; no se ha generado APK.

Faltan el boceto manual docs/boceto.png, las reflexiones y respuestas personales de la bitácora y la revisión personal de los comentarios. La presencia de código que funciona no sustituye la defensa individual.
