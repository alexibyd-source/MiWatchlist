// Se usa Material del SDK para respetar los paquetes del enunciado.
// ignore: deprecated_member_use
import 'package:flutter/material.dart';

import '../modelos/elemento.dart';
import '../servicios/almacen.dart';
import '../widgets/marco_pagina.dart';
import '../widgets/tarjeta_elemento.dart';
import 'pantalla_detalle.dart';
import 'pantalla_estadisticas.dart';
import 'pantalla_formulario.dart';

/// Presenta la colección y concentra sus cambios y persistencia.
class PantallaLista extends StatefulWidget {
  const PantallaLista({super.key});
  @override
  State<PantallaLista> createState() => _PantallaListaState();
}

/// Carga y guarda la colección y calcula los resultados visibles.
class _PantallaListaState extends State<PantallaLista> {
  final _almacen = Almacen();
  final _buscador = TextEditingController();
  List<Elemento> _elementos = [];
  Estado? _filtro;
  bool _cargando = true;
  bool _guardando = false;
  String? _errorCarga;

  /// Inicializa el estado y prepara los datos o controladores de la pantalla.
  @override
  void initState() {
    super.initState();
    _cargar();
  }

  /// Libera los controladores y nodos de foco al cerrar la pantalla.
  @override
  void dispose() {
    _buscador.dispose();
    super.dispose();
  }

  /// Recupera la colección y actualiza los estados de carga y error.
  Future<void> _cargar() async {
    setState(() {
      _cargando = true;
      _errorCarga = null;
    });
    try {
      final elementos = await _almacen.cargar();
      if (!mounted) return;
      setState(() {
        _elementos = elementos;
        _cargando = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _errorCarga = 'No se pudo abrir tu colección.';
        _cargando = false;
      });
    }
  }

  /// Valida o persiste los datos antes de confirmar el cambio.
  Future<void> _guardar(List<Elemento> siguiente, String mensaje) async {
    setState(() => _guardando = true);
    try {
      await _almacen.guardar(siguiente);
      if (!mounted) return;
      setState(() => _elementos = siguiente);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(mensaje)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo guardar el cambio. Inténtalo de nuevo.'),
        ),
      );
    } finally {
      if (mounted) setState(() => _guardando = false);
    }
  }

  /// Abre el formulario de alta y guarda el resultado si no se cancela.
  Future<void> _nuevo() async {
    final elemento = await Navigator.push<Elemento>(
      context,
      MaterialPageRoute(builder: (_) => const PantallaFormulario()),
    );
    if (!mounted || elemento == null) return;
    await _guardar([..._elementos, elemento], 'Añadido a tu colección.');
  }

  /// Abre el detalle y aplica su resultado buscando el identificador del elemento.
  Future<void> _detalle(Elemento elemento) async {
    final resultado = await Navigator.push<ResultadoDetalle>(
      context,
      MaterialPageRoute(builder: (_) => PantallaDetalle(elemento: elemento)),
    );
    if (!mounted || resultado == null) return;
    final siguiente = resultado.accion == AccionDetalle.borrar
        ? _elementos.where((e) => e.id != resultado.elemento.id).toList()
        : _elementos
              .map(
                (e) => e.id == resultado.elemento.id ? resultado.elemento : e,
              )
              .toList();
    await _guardar(
      siguiente,
      resultado.accion == AccionDetalle.borrar
          ? 'Elemento borrado.'
          : 'Cambios guardados.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    final busqueda = _buscador.text.trim().toLowerCase();
    final visibles = _elementos
        .where(
          (e) =>
              (_filtro == null || e.estado == _filtro) &&
              e.titulo.toLowerCase().contains(busqueda),
        )
        .toList();
    final bloqueado = _cargando || _guardando || _errorCarga != null;
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bookmarks_rounded, size: 22, color: Color(0xFFA9E5BB)),
            SizedBox(width: 12),
            Text(
              'Mi Watchlist',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Estadísticas',
            onPressed: bloqueado
                ? null
                : () => Navigator.push<void>(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PantallaEstadisticas(
                        elementos: List.unmodifiable(_elementos),
                      ),
                    ),
                  ),
            icon: const Icon(Icons.bar_chart_rounded),
          ),
          const SizedBox(width: 16),
        ],
      ),
      floatingActionButton: bloqueado
          ? null
          : FloatingActionButton.extended(
              onPressed: _nuevo,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Añadir'),
            ),
      body: SafeArea(
        child: _cargando
            ? const Center(child: CircularProgressIndicator())
            : _errorCarga != null
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_errorCarga!),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: _cargar,
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              )
            : AbsorbPointer(
                absorbing: _guardando,
                child: MarcoPagina(
                  child: CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 7,
                                    height: 7,
                                    decoration: BoxDecoration(
                                      color: colores.primary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 9),
                                  Text(
                                    'TU ESPACIO PERSONAL',
                                    style: TextStyle(
                                      color: colores.primary,
                                      fontSize: 10,
                                      letterSpacing: 2.4,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Buenas historias.\nSiempre a mano.',
                                style: TextStyle(
                                  fontSize: 40,
                                  height: 1.12,
                                  letterSpacing: -1.8,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                'Películas, series y videojuegos. Un lugar para todos tus pendientes.',
                                style: TextStyle(
                                  color: colores.onSurfaceVariant,
                                  height: 1.6,
                                ),
                              ),
                              const SizedBox(height: 28),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: Tipo.values
                                    .map(
                                      (tipo) => Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: colorTipo(tipo)
                                              .withValues(alpha: 0.08),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: colorTipo(tipo)
                                                .withValues(alpha: 0.18),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              iconoTipo(tipo),
                                              color: colorTipo(tipo),
                                              size: 16,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              tipo.etiqueta,
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                            const SizedBox(width: 14),
                                            Text(
                                              '${_elementos.where((e) => e.tipo == tipo).length}',
                                              style: TextStyle(
                                                color: colorTipo(tipo),
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const SizedBox(height: 32),
                              TextField(
                                controller: _buscador,
                                onChanged: (_) => setState(() {}),
                                decoration: InputDecoration(
                                  hintText: 'Buscar en tu colección…',
                                  prefixIcon: const Icon(Icons.search_rounded),
                                  suffixIcon: _buscador.text.isEmpty
                                      ? null
                                      : IconButton(
                                          tooltip: 'Limpiar búsqueda',
                                          onPressed: () =>
                                              setState(_buscador.clear),
                                          icon: const Icon(Icons.close_rounded),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  ChoiceChip(
                                    label: const Text('Todos'),
                                    selected: _filtro == null,
                                    onSelected: (_) =>
                                        setState(() => _filtro = null),
                                  ),
                                  for (final estado in Estado.values)
                                    ChoiceChip(
                                      label: Text(
                                        estado == Estado.enCurso
                                            ? 'Viendo / Jugando'
                                            : estado.etiqueta(),
                                      ),
                                      selected: _filtro == estado,
                                      onSelected: (_) =>
                                          setState(() => _filtro = estado),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Tu colección',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.5,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${visibles.length} ${visibles.length == 1 ? 'elemento' : 'elementos'}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: colores.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                              if (_guardando)
                                const Padding(
                                  padding: EdgeInsets.only(top: 12),
                                  child: LinearProgressIndicator(),
                                ),
                              const SizedBox(height: 18),
                            ],
                          ),
                        ),
                      ),
                      if (visibles.isEmpty)
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 110),
                          sliver: SliverToBoxAdapter(
                            child: _Vacio(
                              primeraVez: _elementos.isEmpty,
                              onAccion: _elementos.isEmpty
                                  ? _nuevo
                                  : () => setState(() {
                                      _filtro = null;
                                      _buscador.clear();
                                    }),
                            ),
                          ),
                        )
                      else
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 110),
                          sliver: SliverList.separated(
                            itemCount: visibles.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 12),
                            itemBuilder: (_, indice) => TarjetaElemento(
                              elemento: visibles[indice],
                              onTap: () => _detalle(visibles[indice]),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

/// Muestra una acción adecuada para una colección vacía o una búsqueda sin resultados.
class _Vacio extends StatelessWidget {
  const _Vacio({required this.primeraVez, required this.onAccion});
  final bool primeraVez;
  final VoidCallback onAccion;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary
                  .withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              primeraVez
                  ? Icons.auto_awesome_outlined
                  : Icons.search_off_rounded,
              size: 36,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            primeraVez
                ? 'Todo empieza con una historia.'
                : 'No hay coincidencias.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Text(
            primeraVez
                ? 'Esa película que te recomendaron. La serie de la que todos hablan.\nGuarda aquí lo próximo que no quieres perderte.'
                : 'Prueba con otro título o cambia el filtro de estado.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: onAccion,
            icon: Icon(
              primeraVez ? Icons.add_rounded : Icons.filter_alt_off_outlined,
            ),
            label: Text(
              primeraVez ? 'Añadir mi primer elemento' : 'Limpiar filtros',
            ),
          ),
        ],
      ),
    ),
  );
}
