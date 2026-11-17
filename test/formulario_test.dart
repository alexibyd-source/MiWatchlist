// Se usa Material del SDK para respetar los paquetes del enunciado.
// ignore: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mi_watchlist/modelos/elemento.dart';
import 'package:mi_watchlist/pantallas/pantalla_formulario.dart';

void main() {
  Future<void> abrir(WidgetTester tester, {Elemento? inicial}) async {
    await tester.pumpWidget(
      MaterialApp(home: PantallaFormulario(inicial: inicial)),
    );
    await tester.pumpAndSettle();
  }

  Future<void> guardar(WidgetTester tester) async {
    final boton = find.byKey(const Key('guardar'));
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.ensureVisible(boton);
    await tester.pumpAndSettle();
    await tester.tap(boton);
    await tester.pumpAndSettle();
  }

  testWidgets('Guardar con título vacío muestra un error', (tester) async {
    await abrir(tester);
    await guardar(tester);
    expect(find.text('Escribe un título.'), findsOneWidget);
  });
  testWidgets('Rechaza espacios y más de 60 caracteres', (tester) async {
    await abrir(tester);
    await tester.enterText(find.byKey(const Key('campo_titulo')), '   ');
    await guardar(tester);
    expect(find.text('Escribe un título.'), findsOneWidget);
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('campo_titulo')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('campo_titulo')), 'a' * 61);
    await guardar(tester);
    expect(
      find.text('El título no puede superar los 60 caracteres.'),
      findsOneWidget,
    );
  });
  testWidgets('Editar y cancelar no modifica el elemento inicial', (
    tester,
  ) async {
    final inicial = Elemento(
      id: '1',
      titulo: 'Dune',
      tipo: Tipo.pelicula,
      estado: Estado.pendiente,
      fechaAlta: DateTime(2026),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () => Navigator.push<Elemento>(
                context,
                MaterialPageRoute(
                  builder: (_) => PantallaFormulario(inicial: inicial),
                ),
              ),
              child: const Text('Abrir'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Abrir'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('campo_titulo')),
      'Otro título',
    );
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Cancelar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancelar'));
    await tester.pumpAndSettle();
    expect(find.text('Abrir'), findsOneWidget);
    expect(inicial.titulo, 'Dune');
  });
}
