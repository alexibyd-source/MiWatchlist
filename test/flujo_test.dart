// Se usa Material del SDK para respetar los paquetes del enunciado.
// ignore: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_watchlist/main.dart';
import 'package:mi_watchlist/modelos/elemento.dart';
import 'package:mi_watchlist/pantallas/pantalla_estadisticas.dart';
import 'package:mi_watchlist/servicios/almacen.dart';
import 'package:mi_watchlist/widgets/tarjeta_elemento.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('Alta, edición, cancelación y borrado persisten correctamente', (
    tester,
  ) async {
    await tester.pumpWidget(const MiWatchlistApp());
    await tester.pumpAndSettle();
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Añadir mi primer elemento'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Añadir mi primer elemento'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('campo_titulo')), 'Dune');
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('guardar')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('guardar')));
    await tester.pumpAndSettle();
    expect((await Almacen().cargar()).single.titulo, 'Dune');
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byType(TarjetaElemento));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(TarjetaElemento));
    await tester.pumpAndSettle();
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Editar elemento'), 200);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Editar elemento'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('campo_titulo')),
      'Dune: Parte 2',
    );
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('guardar')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('guardar')));
    await tester.pumpAndSettle();
    expect((await Almacen().cargar()).single.titulo, 'Dune: Parte 2');
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byType(TarjetaElemento));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(TarjetaElemento));
    await tester.pumpAndSettle();
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Borrar de mi lista'), 200);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Borrar de mi lista'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();
    expect(await Almacen().cargar(), hasLength(1));
    await tester.tap(find.text('Borrar de mi lista'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Borrar'));
    await tester.pumpAndSettle();
    expect(await Almacen().cargar(), isEmpty);
    expect(find.text('Elemento borrado.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Búsqueda y filtro se combinan sin borrar la colección', (
    tester,
  ) async {
    await Almacen().guardar([
      Elemento(
        id: '1',
        titulo: 'Dune',
        tipo: Tipo.pelicula,
        estado: Estado.pendiente,
        fechaAlta: DateTime(2026),
      ),
      Elemento(
        id: '2',
        titulo: 'The Bear',
        tipo: Tipo.serie,
        estado: Estado.terminado,
        fechaAlta: DateTime(2026),
      ),
    ]);
    await tester.pumpWidget(const MiWatchlistApp());
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'dUnE');
    await tester.pumpAndSettle();
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byType(TarjetaElemento));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(TarjetaElemento, 'Dune'), findsOneWidget);
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.widgetWithText(ChoiceChip, 'Terminado'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, 'Terminado'));
    await tester.pumpAndSettle();
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('No hay coincidencias.'));
    await tester.pumpAndSettle();
    expect(find.text('No hay coincidencias.'), findsOneWidget);
    expect(await Almacen().cargar(), hasLength(2));
  });

  testWidgets('Estadísticas vacías y en móvil no producen errores', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      const MaterialApp(home: PantallaEstadisticas(elementos: [])),
    );
    await tester.pumpAndSettle();
    expect(find.text('—'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('La media excluye los ceros y muestra los empates', (
    tester,
  ) async {
    final elementos = [
      Elemento(
        id: '1',
        titulo: 'Dune',
        tipo: Tipo.pelicula,
        estado: Estado.terminado,
        valoracion: 4,
        fechaAlta: DateTime(2026),
      ),
      Elemento(
        id: '2',
        titulo: 'The Bear',
        tipo: Tipo.serie,
        estado: Estado.pendiente,
        fechaAlta: DateTime(2026),
      ),
    ];
    await tester.pumpWidget(
      MaterialApp(home: PantallaEstadisticas(elementos: elementos)),
    );
    await tester.pumpAndSettle();
    expect(find.text('4,0'), findsOneWidget);
    await tester.scrollUntilVisible(find.textContaining('(empate)'), 300);
    expect(find.textContaining('Película · Serie (empate)'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
