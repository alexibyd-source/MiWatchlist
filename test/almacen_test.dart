import 'package:flutter_test/flutter_test.dart';
import 'package:mi_watchlist/modelos/elemento.dart';
import 'package:mi_watchlist/servicios/almacen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test(
    'Guardar y cargar conserva la colección, incluso tras vaciarla',
    () async {
      final almacen = Almacen();
      final elemento = Elemento(
        id: '1',
        titulo: 'The Bear',
        tipo: Tipo.serie,
        estado: Estado.enCurso,
        fechaAlta: DateTime(2026),
      );
      await almacen.guardar([elemento]);
      expect((await Almacen().cargar()).single.toJson(), elemento.toJson());
      await almacen.guardar([]);
      expect(await Almacen().cargar(), isEmpty);
    },
  );
  test('JSON corrupto o con campos inválidos carga una lista vacía', () async {
    for (final contenido in ['{roto', '{}', '[{"tipo":"otro"}]', '[1]']) {
      SharedPreferences.setMockInitialValues({'watchlist': contenido});
      expect(await Almacen().cargar(), isEmpty);
    }
  });
}
