import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../modelos/elemento.dart';

/// Guarda y recupera la colección como JSON en las preferencias del dispositivo.
class Almacen {
  static const clave = 'watchlist';

  /// Carga la lista; si el contenido JSON es inválido devuelve una lista vacía.
  Future<List<Elemento>> cargar() async {
    final preferencias = await SharedPreferences.getInstance();
    final contenido = preferencias.getString(clave);
    if (contenido == null) return [];
    try {
      final datos = jsonDecode(contenido) as List<dynamic>;
      return datos
          .map((dato) => Elemento.fromJson(dato as Map<String, dynamic>))
          .toList();
    } on FormatException {
      return [];
    } on TypeError {
      return [];
    } on ArgumentError {
      return [];
    }
  }

  /// Serializa la lista y comunica un error si las preferencias no la guardan.
  Future<void> guardar(List<Elemento> elementos) async {
    final preferencias = await SharedPreferences.getInstance();
    final guardado = await preferencias.setString(
      clave,
      jsonEncode(elementos.map((e) => e.toJson()).toList()),
    );
    if (!guardado) throw StateError('No se pudo guardar la lista.');
  }
}
