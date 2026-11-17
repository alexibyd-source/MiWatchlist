# Bitácora del proyecto Watchlist

## Introducción

Watchlist es una aplicación desarrollada con Flutter para organizar películas y series, añadir valoraciones y consultar estadísticas. Para preparar la base del proyecto, revisar el código y ampliar algunas funciones se utilizó ChatGPT/Codex. Esta bitácora recoge de forma resumida las fases del desarrollo y las características incorporadas.

## Fase 0. Boceto inicial

La aplicación se organiza en tres apartados principales: lista de películas y series, formulario para añadir o editar elementos y pantalla de estadísticas.

adjuntado el boceto hecho a mano en `docs/boceto.png`.

## Fase 1. Modelo de datos

Se definió un modelo `Elemento` para representar cada película o serie, junto a las enumeraciones `Tipo` y `Estado`. El modelo incluye campos opcionales y métodos `toJson`, `fromJson` y `copyWith`, necesarios para guardar y actualizar la información. El identificador y la fecha de alta se conservan cuando se edita un registro.

## Fase 2. Pantalla principal

La pantalla principal muestra la colección mediante `TarjetaElemento`, con un selector de estrellas para las valoraciones. También contempla los casos en los que todavía no hay elementos o una búsqueda no devuelve resultados. La lista se construye con `CustomScrollView` y `SliverList.separated`.

## Fase 3. Formulario

El formulario permite registrar una película o serie con título, tipo, estado, notas y valoración. Utiliza `Form`, `GlobalKey`, controladores y campos desplegables. Se comprueba que el título sea válido antes de guardar y se liberan los controladores cuando deja de utilizarse la pantalla.

## Fase 4. Detalle, edición y eliminación

Cada elemento dispone de una vista de detalle. Se reutiliza el formulario para editar su información y se muestra una confirmación antes de eliminarlo. El proyecto incluye pruebas relacionadas con la edición y la cancelación de acciones.

## Fase 5. Búsqueda y filtros

Es posible buscar por título y filtrar los elementos según su estado. Los resultados se calculan a partir de la colección original, sin modificarla. La búsqueda no distingue entre mayúsculas y minúsculas.

## Fase 6. Guardado de datos

La información se almacena localmente con `shared_preferences`. Los elementos se convierten a JSON y se guardan con la clave `watchlist`, para recuperarlos al abrir la aplicación. También se regeneraron dependencias que contenían rutas de otro ordenador.

## Fase 7. Estadísticas y diseño

La aplicación utiliza un tema oscuro e incorpora estadísticas por tipo y estado. La valoración media se calcula con los elementos puntuados, sin incluir los que tienen cero estrellas. Se contemplan también las listas vacías.

## Fase 8. Pruebas y documentación

El proyecto contiene pruebas y documentación de uso. Los resultados de las comprobaciones ejecutadas están recogidos en `VALIDACION.md`. La entrega incluye instrucciones para el repositorio, archivos excluidos y la preparación de una versión web.

## Ampliación. Imágenes mediante enlaces

Se incorporó el campo opcional `imagenUrl`, que permite añadir una portada a las películas y series a través de un enlace `http` o `https`. Las imágenes aparecen en la tarjeta y en la vista de detalle. Si el enlace falla, se muestra un icono alternativo. La aplicación sigue admitiendo elementos antiguos sin imagen y se prepararon tres reseñas de ejemplo para visualizar esta función.

## Resumen de la asistencia utilizada

Se utilizó ChatGPT/Codex para generar la estructura y la primera base funcional del proyecto, apoyar las revisiones y añadir la opción de imágenes mediante URL. Las solicitudes principales consistieron en analizar el enunciado, iniciar el proyecto, revisar sus archivos, preparar la entrega y ampliar la funcionalidad de las reseñas.

## Revisión personal pendiente

Queda por incorporar el boceto manual, registrar las comprobaciones realizadas por el alumno y completar con sus propias palabras los apartados de aprendizaje y comprensión que exige el enunciado.
