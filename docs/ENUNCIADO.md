# Proyecto: «Mi Watchlist», tu primera app completa con ayuda de IA

Módulo: Desarrollo de Interfaces · Tecnología: Flutter y Dart · Modalidad: individual
Duración orientativa: 5 sesiones de clase (10 h) más trabajo en casa · Encaja con la entrega E1 (sesión 12)

---

## 1. Qué vas a construir

Una app para llevar el control de **películas, series y videojuegos** que quieres ver o jugar, los que tienes a medias y los que ya terminaste. Podrás añadirlos, puntuarlos con estrellas, filtrarlos, buscarlos y ver tus estadísticas. Los datos **se guardan en el dispositivo**: si cierras la app y la vuelves a abrir, siguen ahí.

Al terminar tendrás una app que puedes instalar en tu móvil y usar de verdad.

```text
┌──────────────────────────┐   ┌──────────────────────────┐   ┌──────────────────────────┐
│ Mi Watchlist        📊   │   │ ← Nuevo elemento          │   │ ← Estadísticas            │
│ [Buscar...............]  │   │                           │   │                           │
│ (Todos)(Pendiente)(Viendo)│  │ Título  [Dune: Parte 2 ]  │   │ Total: 14                 │
│ (Terminado)              │   │ Tipo    [Película   ▼]    │   │ Pendiente  ██████░░  6    │
│ ┌──────────────────────┐ │   │ Estado  [Pendiente  ▼]    │   │ Viendo     ███░░░░░  3    │
│ │🎬 Dune: Parte 2      │ │   │ Valoración ★★★★☆          │   │ Terminado  █████░░░  5    │
│ │   Pendiente   ☆☆☆☆☆  │ │   │ Notas   [.............]   │   │                           │
│ ├──────────────────────┤ │   │                           │   │ Valoración media: 3,8 ★   │
│ │📺 The Bear           │ │   │        [ Guardar ]        │   │ Tipo favorito: Serie      │
│ │   Viendo      ★★★★☆  │ │   │                           │   │                           │
│ └──────────────────────┘ │   └──────────────────────────┘   └──────────────────────────┘
│                     (+)  │
└──────────────────────────┘
```

---

## 2. La regla de oro del proyecto

> **Puedes usar IA para escribir código. No puedes entregar código que no sepas explicar.**

La IA (ChatGPT, Claude, Gemini, Copilot…) es tu **copiloto**: te sugiere, te explica y te ayuda a desbloquearte. Tú eres el **piloto**: decides qué entra en el proyecto, lo pruebas y respondes de ello.

En la defensa final el profesor señalará **cualquier línea** de tu proyecto y te preguntará qué hace y por qué está ahí. También te pedirá un **cambio pequeño en directo, sin IA**. Si no puedes explicar una parte, esa parte no puntúa (ver rúbrica).

### Normas de uso de la IA

1. **Pide por partes, nunca la app entera.** Prohibido el prompt «hazme una app de watchlist en Flutter». Cada fase de este enunciado es una petición (o varias) pequeña.
2. **Entiende antes de pegar.** Antes de copiar código, léelo. Si hay algo que no entiendes, pregúntale a la IA: «explícame línea a línea qué hace este fragmento» o «¿por qué usas `final` aquí?».
3. **Comenta con tus palabras.** Cada clase y cada función importante lleva un comentario `///` escrito por ti (no por la IA) que explique para qué sirve.
4. **Rellena la bitácora** (anexo A) en cada fase: qué pediste, qué te dio, qué cambiaste y qué aprendiste.
5. **Comprueba siempre.** Tras cada cambio: `flutter analyze` sin errores y la app ejecutándose. La IA se equivoca a menudo (inventa métodos, usa versiones antiguas de paquetes, olvida `dispose`). Detectarlo es parte del trabajo.
6. **Solo los paquetes permitidos:** `shared_preferences` y, opcionalmente, `intl`. Nada de `provider`, `riverpod`, `bloc`, `get`… El estado se gestiona con `StatefulWidget` y `setState`, que es lo que hemos visto en clase. Si la IA te propone otro paquete, pídele que lo haga sin él.
7. **Responde las preguntas de comprensión sin IA.** Al final de cada fase hay preguntas. Contéstalas en la bitácora con tus palabras; son la mejor preparación para la defensa.

### Cómo escribir un buen prompt

| ❌ Prompt pobre | ✅ Prompt bueno |
| --- | --- |
| «hazme el formulario» | «Estoy aprendiendo Flutter. Tengo esta clase `Elemento` (pego el código). Quiero una pantalla `PantallaFormulario` con un `Form`, un `TextFormField` para el título que no admita vacío ni solo espacios, y `DropdownButtonFormField` para tipo y estado. Usa solo `setState`, sin paquetes externos. Explícame después qué hace cada controlador y por qué hay que llamar a `dispose`.» |
| «no funciona, arréglalo» | «Al pulsar Guardar me sale este error (pego el error completo) en la línea 42 de `pantalla_formulario.dart` (pego el fragmento). Explícame la causa antes de darme la solución.» |

Un buen prompt da **contexto** (qué tienes), **objetivo** (qué quieres), **restricciones** (qué no quieres) y **pide explicación**.

---

## 3. Requisitos de la aplicación

### 3.1 Modelo de datos

Clase `Elemento` con:

| Campo | Tipo | Notas |
| --- | --- | --- |
| `id` | `String` | Único. Puede generarse con `DateTime.now().microsecondsSinceEpoch.toString()` |
| `titulo` | `String` | Obligatorio, entre 1 y 60 caracteres sin contar espacios iniciales o finales |
| `tipo` | `enum Tipo { pelicula, serie, videojuego }` | |
| `estado` | `enum Estado { pendiente, enCurso, terminado }` | En pantalla: Pendiente, Viendo/Jugando, Terminado |
| `valoracion` | `int` | De 0 a 5. 0 significa «sin valorar» |
| `notas` | `String?` | Opcional |
| `fechaAlta` | `DateTime` | Se asigna al crear |

Debe tener los métodos `toJson()`, `fromJson()` y `copyWith()`.

### 3.2 Pantallas y funciones obligatorias

| Nº | Requisito |
| --- | --- |
| R1 | **Lista principal** con todos los elementos, icono según el tipo, estado y estrellas. |
| R2 | **Estado vacío**: si no hay elementos, un mensaje amable y un botón para añadir el primero. |
| R3 | **Alta** desde un `FloatingActionButton` que abre el formulario. |
| R4 | **Formulario con validación**: título obligatorio y longitud máxima; mensajes de error claros. |
| R5 | **Detalle** al tocar un elemento, con todos sus datos y botones Editar y Borrar. |
| R6 | **Edición** reutilizando el mismo formulario, con los datos ya cargados. Cancelar no modifica nada. |
| R7 | **Borrado con confirmación** mediante `AlertDialog`. |
| R8 | **Filtro por estado** con `ChoiceChip` o `SegmentedButton` (Todos, Pendiente, Viendo, Terminado). |
| R9 | **Búsqueda** por título que no distinga mayúsculas de minúsculas. Funciona junto con el filtro. |
| R10 | **Persistencia** con `shared_preferences`: la lista se guarda en JSON y se recupera al arrancar. |
| R11 | **Estadísticas**: total, recuento por estado con barras, valoración media (solo de los valorados, sin dividir entre cero) y tipo más frecuente. |
| R12 | **Componentes propios**: al menos `TarjetaElemento` y `SelectorEstrellas`, en archivos separados y con parámetros y callbacks. |
| R13 | **Tema propio** con `ThemeData` y `ColorScheme.fromSeed` aplicado en toda la app. |

### 3.3 Estructura de carpetas obligatoria

```text
lib/
├── main.dart                     # Arranque y tema
├── modelos/
│   └── elemento.dart             # Clase Elemento y enums
├── servicios/
│   └── almacen.dart              # Guardar y cargar con shared_preferences
├── pantallas/
│   ├── pantalla_lista.dart
│   ├── pantalla_formulario.dart
│   ├── pantalla_detalle.dart
│   └── pantalla_estadisticas.dart
└── widgets/
    ├── tarjeta_elemento.dart
    └── selector_estrellas.dart
test/
├── elemento_test.dart            # Pruebas unitarias del modelo
└── formulario_test.dart          # Prueba de widget de la validación
```

---

## 4. Fases de trabajo

Trabaja **en orden**. No pases a la siguiente fase hasta que la actual funcione y hayas rellenado su entrada en la bitácora. Si usas Git, haz **un commit por fase** con un mensaje que diga qué has hecho.

### Fase 0 · Diseño en papel (sin IA, 30 min)

- Dibuja en papel o en una herramienta de bocetos las 4 pantallas y flechas que indiquen cómo se navega entre ellas.
- Escribe qué datos muestra cada pantalla.
- Crea el proyecto: `flutter create mi_watchlist` y crea las carpetas de la estructura.

**Entrega:** foto o captura del boceto en `docs/boceto.png`.

### Fase 1 · Modelo de datos

- Escribe la clase `Elemento`, los dos `enum`, `toJson`, `fromJson` y `copyWith`.
- Crea en `pantalla_lista.dart` una lista con 4 o 5 elementos de ejemplo escritos a mano.

**Prompt orientativo:** «Escribe en Dart una clase inmutable `Elemento` con estos campos (pega la tabla). Añade `toJson`, `fromJson` y `copyWith`. Explica qué es `copyWith` y por qué lo necesito si los campos son `final`.»

**Preguntas de comprensión:**
1. ¿Por qué los campos son `final`? ¿Cómo «cambio» entonces el estado de un elemento?
2. ¿Cómo se guarda un `enum` en JSON y cómo se recupera?
3. ¿Qué pasaría en `fromJson` si el JSON no trae el campo `notas`?

### Fase 2 · Lista y tarjeta (R1, R2, R12 parcial)

- Muestra los elementos con `ListView.builder`.
- Crea `TarjetaElemento` en su propio archivo; recibe un `Elemento` y un callback `onTap`.
- Crea `SelectorEstrellas` (5 iconos, de solo lectura de momento, con un parámetro `valor`).
- Implementa el estado vacío.

**Preguntas de comprensión:**
1. ¿Qué diferencia hay entre `ListView` y `ListView.builder`? ¿Cuándo conviene cada uno?
2. ¿Por qué `TarjetaElemento` recibe una función en lugar de navegar ella misma?
3. ¿`TarjetaElemento` es `StatelessWidget` o `StatefulWidget`? ¿Por qué?

### Fase 3 · Formulario de alta (R3, R4)

- `PantallaFormulario` con `Form`, `GlobalKey<FormState>`, `TextEditingController`, desplegables de tipo y estado, `SelectorEstrellas` ahora **interactivo** (callback `onChanged`) y campo de notas.
- Al guardar, valida y devuelve el nuevo `Elemento` con `Navigator.pop(context, elemento)`.
- La lista recibe el resultado con `await Navigator.push(...)` y lo añade con `setState`.

**Preguntas de comprensión:**
1. ¿Qué hace `_formKey.currentState!.validate()` y qué significa el `!`?
2. ¿Por qué hay que llamar a `dispose()` de los controladores?
3. Explica el viaje del dato: desde que pulsas Guardar hasta que aparece en la lista.

### Fase 4 · Detalle, edición y borrado (R5, R6, R7)

- `PantallaDetalle` muestra todos los datos.
- Editar abre el mismo formulario con un parámetro opcional `Elemento? inicial`. Si viene, los campos aparecen rellenos y se conserva el `id`.
- Borrar pide confirmación con `AlertDialog`. Después muestra un `SnackBar`.

**Preguntas de comprensión:**
1. ¿Cómo sabe el formulario si está creando o editando?
2. ¿Cómo encuentra la lista qué elemento debe reemplazar al volver de la edición?
3. ¿Qué devuelve `showDialog` y cómo lo usas para saber si el usuario confirmó?

### Fase 5 · Filtro y búsqueda (R8, R9)

- Guarda en el estado de la lista el filtro elegido y el texto buscado.
- Calcula la lista visible a partir de la lista completa con `where`. **No borres** elementos de la lista original al filtrar.

**Preguntas de comprensión:**
1. ¿Por qué se filtra sobre una lista calculada y no sobre la original?
2. ¿Qué método usas para que «dune» encuentre «Dune»?
3. Si filtras por Terminado y buscas un título pendiente, ¿qué debe verse? ¿Lo has probado?

### Fase 6 · Persistencia (R10)

- Añade el paquete: `flutter pub add shared_preferences`.
- En `servicios/almacen.dart` crea una clase `Almacen` con `Future<List<Elemento>> cargar()` y `Future<void> guardar(List<Elemento>)`. Guarda toda la lista como un único `String` JSON con la clave `watchlist`.
- Carga en `initState` y muestra un `CircularProgressIndicator` mientras tanto. Guarda después de cada alta, edición o borrado.
- Si el JSON guardado está dañado, la app no debe romperse: arranca con la lista vacía.

**Preguntas de comprensión:**
1. ¿Por qué `cargar()` devuelve un `Future`? ¿Qué pasaría si la pantalla intentara pintar la lista antes de que termine?
2. ¿Por qué no se puede usar `await` directamente dentro de `initState`? ¿Cómo lo has resuelto?
3. ¿Dónde están físicamente los datos? ¿Se pierden si desinstalas la app?

### Fase 7 · Estadísticas y tema (R11, R13)

- Pantalla accesible desde un icono en la `AppBar`.
- Barras construidas con widgets (`LinearProgressIndicator` o `Container` con ancho proporcional), con su número al lado.
- Aplica un tema propio. Revisa que todo se lea bien.

**Preguntas de comprensión:**
1. ¿Cómo has evitado dividir entre cero en la valoración media?
2. ¿Por qué los elementos con 0 estrellas no cuentan para la media?
3. ¿Qué ventaja tiene definir los colores en el tema en lugar de en cada widget?

### Fase 8 · Pruebas y documentación

- `test/elemento_test.dart`: comprueba que `fromJson(toJson(e))` devuelve los mismos datos y que `copyWith` solo cambia lo indicado.
- `test/formulario_test.dart`: prueba de widget que pulsa Guardar con el título vacío y comprueba que aparece el mensaje de error.
- `README.md` del proyecto: qué hace la app, cómo ejecutarla, capturas y paquetes usados.
- Ejecuta y deja sin errores:

```bash
dart format lib test
```

```bash
flutter analyze
```

```bash
flutter test
```

**Preguntas de comprensión:**
1. ¿Qué diferencia hay entre una prueba unitaria y una de widget?
2. ¿Qué hace `tester.pump()` y por qué hace falta después de pulsar un botón?

---

## 5. Ampliaciones opcionales (para subir nota)

Elige como máximo dos. Mismas normas de IA.

- **Deshacer borrado** desde la acción del `SnackBar`.
- **Ordenar** por título, fecha o valoración con un `PopupMenuButton`.
- **Modo oscuro** con un interruptor que se guarde en `shared_preferences`.
- **Deslizar para borrar** con `Dismissible` (sin perder la confirmación).
- **Contador de días** en el detalle: «En tu lista desde hace 12 días».

---

## 6. Entrega

Un archivo `.zip` (sin la carpeta `build`) o el enlace al repositorio, con:

1. El proyecto Flutter completo.
2. `docs/boceto.png` (fase 0).
3. `docs/bitacora_ia.md` con todas las fases rellenas (anexo A).
4. `README.md` del proyecto con capturas.
5. Un APK de depuración (`flutter build apk --debug`) o la versión web (`flutter build web`).

### Defensa individual (10 minutos)

1. Demostración de la app funcionando (2 min).
2. El profesor elige un fragmento de código al azar y lo explicas (4 min).
3. Cambio en directo **sin IA** (4 min). Ejemplos: cambiar el límite del título a 40 caracteres, añadir un cuarto estado «Abandonado», mostrar el total en la `AppBar`, cambiar el color del tema.

---

## 7. Evaluación

| Criterio | Peso | Qué se valora |
| --- | --- | --- |
| Funcionalidad | 30 % | R1 a R13 funcionan sin errores. Cada requisito cuenta lo mismo. |
| Defensa | 25 % | Explica su código con sus palabras y resuelve el cambio en directo. |
| Calidad del código | 15 % | Estructura de carpetas, nombres claros, comentarios propios, `flutter analyze` limpio, sin código muerto. |
| Usabilidad | 10 % | Mensajes claros, confirmaciones, estado vacío, se lee bien, navegación coherente. |
| Pruebas | 10 % | Las pruebas pedidas existen y pasan. |
| Bitácora de IA | 10 % | Completa, honesta y con reflexión; respuestas de comprensión correctas. |

**Condición de la defensa:** un requisito que no sepas explicar se considera no cumplido aunque funcione. Si no puedes explicar la mayoría del proyecto, la entrega se repite.

**Ampliaciones:** hasta +1 punto sobre la nota final, solo si la parte obligatoria está completa.

> Pesos y condiciones propuestos; el profesor puede ajustarlos a la programación didáctica del centro.

---

## Anexo A · Plantilla de la bitácora de IA

Copia este bloque en `docs/bitacora_ia.md` una vez por fase.

```markdown
## Fase N · Nombre de la fase

**Herramienta usada:** (ChatGPT, Claude, Gemini, Copilot, ninguna…)

**Prompts principales** (cópialos tal cual):
1. ...
2. ...

**Qué me dio la IA y qué hice con ello:**
- Acepté sin cambios: ...
- Modifiqué: ... porque ...
- Descarté: ... porque ...

**Errores de la IA que detecté** (métodos inventados, código que no compilaba, paquetes no permitidos…):
- ...

**Lo que he aprendido en esta fase** (2-3 líneas con mis palabras):
...

**Preguntas de comprensión** (respondidas sin IA):
1. ...
2. ...
3. ...
```

## Anexo B · Lista de comprobación antes de entregar

- [ ] La app arranca sin errores en Android o en Chrome.
- [ ] Añado un elemento, cierro la app, la vuelvo a abrir y sigue ahí.
- [ ] El formulario no deja guardar un título vacío o de solo espacios.
- [ ] Cancelar la edición no cambia nada.
- [ ] Borrar pide confirmación.
- [ ] Filtro y búsqueda funcionan a la vez.
- [ ] Las estadísticas no fallan con la lista vacía.
- [ ] `flutter analyze` no muestra problemas.
- [ ] `flutter test` pasa.
- [ ] Cada clase y cada función importante tiene un comentario escrito por mí.
- [ ] La bitácora tiene todas las fases.
- [ ] Sé explicar cualquier archivo de `lib/` sin mirar la IA.
