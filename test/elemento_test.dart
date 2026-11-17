import 'package:flutter_test/flutter_test.dart';
import 'package:mi_watchlist/modelos/elemento.dart';

void main() {
  final original = Elemento(
    id: '1',
    titulo: 'Dune',
    tipo: Tipo.pelicula,
    estado: Estado.pendiente,
    valoracion: 4,
    notas: 'Versión original',
    fechaAlta: DateTime(2026, 1, 2),
  );

  test('JSON conserva todos los datos del elemento', () {
    expect(Elemento.fromJson(original.toJson()).toJson(), original.toJson());
  });
  test('copyWith cambia solo lo indicado y mantiene el original', () {
    final cambiado = original.copyWith(estado: Estado.terminado);
    expect(cambiado.toJson(), {...original.toJson(), 'estado': 'terminado'});
    expect(original.estado, Estado.pendiente);
  });
  test('Las notas ausentes son opcionales y pueden eliminarse', () {
    final json = original.toJson()..remove('notas');
    expect(Elemento.fromJson(json).notas, isNull);
    expect(original.copyWith(borrarNotas: true).notas, isNull);
  });
  test('El modelo valida título y valoración', () {
    expect(() => original.copyWith(titulo: '   '), throwsArgumentError);
    expect(() => original.copyWith(titulo: 'a' * 61), throwsArgumentError);
    expect(() => original.copyWith(valoracion: 6), throwsArgumentError);
    expect(original.copyWith(titulo: ' Dune ').titulo, 'Dune');
  });
}
