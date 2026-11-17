/// Categorías disponibles para los elementos de la colección.
enum Tipo { pelicula, serie, videojuego }

/// Progreso de visualización o juego de cada elemento.
enum Estado { pendiente, enCurso, terminado }

/// Proporciona el nombre visible de cada tipo de contenido.
extension NombreTipo on Tipo {
  String get etiqueta => switch (this) {
    Tipo.pelicula => 'Película',
    Tipo.serie => 'Serie',
    Tipo.videojuego => 'Videojuego',
  };
}

/// Adapta el nombre del estado al tipo de contenido.
extension NombreEstado on Estado {
  String etiqueta([Tipo? tipo]) => switch (this) {
    Estado.pendiente => 'Pendiente',
    Estado.enCurso => tipo == Tipo.videojuego ? 'Jugando' : 'Viendo',
    Estado.terminado => 'Terminado',
  };
}

/// Representa un título inmutable y valida sus datos antes de guardarlo.
class Elemento {
  Elemento({
    required this.id,
    required String titulo,
    required this.tipo,
    required this.estado,
    this.valoracion = 0,
    this.notas,
    this.imagenUrl,
    required this.fechaAlta,
  }) : titulo = titulo.trim() {
    if (this.titulo.isEmpty || this.titulo.length > 60) {
      throw ArgumentError('El título debe tener entre 1 y 60 caracteres.');
    }
    if (valoracion < 0 || valoracion > 5) {
      throw ArgumentError('Valoración fuera de rango.');
    }
    if (id.isEmpty) throw ArgumentError('El identificador es obligatorio.');
  }

  final String id;
  final String titulo;
  final Tipo tipo;
  final Estado estado;
  final int valoracion;
  final String? notas;
  final String? imagenUrl;
  final DateTime fechaAlta;

  /// Convierte el elemento a valores compatibles con JSON.
  Map<String, dynamic> toJson() => {
    'id': id,
    'titulo': titulo,
    'tipo': tipo.name,
    'estado': estado.name,
    'valoracion': valoracion,
    'notas': notas,
    'imagenUrl': imagenUrl,
    'fechaAlta': fechaAlta.toIso8601String(),
  };

  /// Reconstruye y valida un elemento a partir del JSON almacenado.
  factory Elemento.fromJson(Map<String, dynamic> json) => Elemento(
    id: json['id'] as String,
    titulo: json['titulo'] as String,
    tipo: Tipo.values.byName(json['tipo'] as String),
    estado: Estado.values.byName(json['estado'] as String),
    valoracion: json['valoracion'] as int,
    notas: json['notas'] as String?,
    imagenUrl: json['imagenUrl'] as String?,
    fechaAlta: DateTime.parse(json['fechaAlta'] as String),
  );

  /// Crea una copia con los cambios indicados conservando el identificador y la fecha.
  Elemento copyWith({
    String? titulo,
    Tipo? tipo,
    Estado? estado,
    int? valoracion,
    String? notas,
    bool borrarNotas = false,
    String? imagenUrl,
    bool borrarImagen = false,
  }) => Elemento(
    id: id,
    titulo: titulo ?? this.titulo,
    tipo: tipo ?? this.tipo,
    estado: estado ?? this.estado,
    valoracion: valoracion ?? this.valoracion,
    notas: borrarNotas ? null : (notas ?? this.notas),
    imagenUrl: borrarImagen ? null : (imagenUrl ?? this.imagenUrl),
    fechaAlta: fechaAlta,
  );
}
