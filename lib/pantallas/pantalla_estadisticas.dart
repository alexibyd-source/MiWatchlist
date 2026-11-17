// Se usa Material del SDK para respetar los paquetes del enunciado.
// ignore: deprecated_member_use
import 'package:flutter/material.dart';

import '../modelos/elemento.dart';
import '../widgets/marco_pagina.dart';
import '../widgets/tarjeta_elemento.dart';

/// Calcula y muestra recuentos y medias de la colección recibida.
class PantallaEstadisticas extends StatelessWidget {
  const PantallaEstadisticas({super.key, required this.elementos});
  final List<Elemento> elementos;

  @override
  Widget build(BuildContext context) {
    final valorados = elementos.where((e) => e.valoracion > 0).toList();
    final media = valorados.isEmpty
        ? 0.0
        : valorados.fold<int>(0, (suma, e) => suma + e.valoracion) /
              valorados.length;
    final tipos = {
      for (final tipo in Tipo.values)
        tipo: elementos.where((e) => e.tipo == tipo).length,
    };
    final maximo = tipos.values.fold<int>(0, (max, n) => n > max ? n : max);
    final favoritos = tipos.entries
        .where((e) => e.value == maximo)
        .map((e) => e.key.etiqueta)
        .join(' · ');
    return Scaffold(
      appBar: AppBar(title: const Text('Estadísticas')),
      body: SafeArea(
        child: MarcoPagina(
          ancho: 800,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const Text(
                'Tu colección, en cifras.',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Cada historia cuenta. Estas son las tuyas.',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 28),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _Resumen(
                    valor: '${elementos.length}',
                    etiqueta: 'EN TU COLECCIÓN',
                    icono: Icons.bookmarks_outlined,
                  ),
                  _Resumen(
                    valor: valorados.isEmpty
                        ? '—'
                        : media.toStringAsFixed(1).replaceAll('.', ','),
                    etiqueta: 'VALORACIÓN MEDIA',
                    icono: Icons.star_outline_rounded,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'A tu ritmo',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 24),
                      for (final estado in Estado.values)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: _Barra(
                            etiqueta: estado == Estado.enCurso
                                ? 'Viendo / Jugando'
                                : estado.etiqueta(),
                            cantidad: elementos
                                .where((e) => e.estado == estado)
                                .length,
                            total: elementos.length,
                            color: switch (estado) {
                              Estado.pendiente => const Color(0xFFB8AFF2),
                              Estado.enCurso => const Color(0xFF8ACFE2),
                              Estado.terminado => const Color(0xFFA9E5BB),
                            },
                          ),
                        ),
                      Text(
                        '${valorados.length} elementos valorados. La media excluye los que tienen 0 estrellas.',
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.6,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tus universos favoritos',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 24),
                      for (final tipo in Tipo.values)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: _Barra(
                            etiqueta: tipo.etiqueta,
                            cantidad: tipos[tipo]!,
                            total: elementos.length,
                            color: colorTipo(tipo),
                          ),
                        ),
                      Text(
                        elementos.isEmpty
                            ? 'Añade tu primera historia para descubrir tu tipo favorito.'
                            : 'Tipo más frecuente: $favoritos${tipos.values.where((n) => n == maximo).length > 1 ? ' (empate)' : ''}.',
                        style: const TextStyle(height: 1.6),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Presenta una cifra destacada junto a su etiqueta e icono.
class _Resumen extends StatelessWidget {
  const _Resumen({
    required this.valor,
    required this.etiqueta,
    required this.icono,
  });
  final String valor;
  final String etiqueta;
  final IconData icono;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 240,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icono, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              valor,
              style: const TextStyle(fontSize: 42, fontWeight: FontWeight.w800),
            ),
            Text(
              etiqueta,
              style: TextStyle(
                fontSize: 10,
                letterSpacing: 1.5,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Representa una cantidad respecto al total sin dividir entre cero.
class _Barra extends StatelessWidget {
  const _Barra({
    required this.etiqueta,
    required this.cantidad,
    required this.total,
    required this.color,
  });
  final String etiqueta;
  final int cantidad;
  final int total;
  final Color color;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        children: [
          Expanded(child: Text(etiqueta)),
          Text(
            '$cantidad',
            style: TextStyle(color: color, fontWeight: FontWeight.w700),
          ),
        ],
      ),
      const SizedBox(height: 10),
      LinearProgressIndicator(
        value: total == 0 ? 0 : cantidad / total,
        minHeight: 8,
        borderRadius: BorderRadius.circular(8),
        color: color,
        backgroundColor: color.withValues(alpha: 0.1),
      ),
    ],
  );
}
