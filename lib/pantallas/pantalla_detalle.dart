// Se usa Material del SDK para respetar los paquetes del enunciado.
// ignore: deprecated_member_use
import 'package:flutter/material.dart';

import '../modelos/elemento.dart';
import '../widgets/marco_pagina.dart';
import '../widgets/selector_estrellas.dart';
import '../widgets/tarjeta_elemento.dart';
import 'pantalla_formulario.dart';

enum AccionDetalle { editar, borrar }

/// Transporta a la lista la acción confirmada y el elemento afectado.
class ResultadoDetalle {
  const ResultadoDetalle(this.accion, this.elemento);
  final AccionDetalle accion;
  final Elemento elemento;
}

/// Muestra los datos del elemento y devuelve acciones de edición o borrado.
class PantallaDetalle extends StatelessWidget {
  const PantallaDetalle({super.key, required this.elemento});
  final Elemento elemento;

  /// Abre el formulario precargado y devuelve el cambio confirmado a la lista.
  Future<void> _editar(BuildContext context) async {
    final actualizado = await Navigator.push<Elemento>(
      context,
      MaterialPageRoute(builder: (_) => PantallaFormulario(inicial: elemento)),
    );
    if (!context.mounted || actualizado == null) return;
    Navigator.pop(context, ResultadoDetalle(AccionDetalle.editar, actualizado));
  }

  /// Pide confirmación antes de devolver la acción de borrado a la lista.
  Future<void> _borrar(BuildContext context) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Borrar elemento?'),
        content: Text(
          '«${elemento.titulo}» se eliminará de tu lista. Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Borrar'),
          ),
        ],
      ),
    );
    if (!context.mounted || confirmado != true) return;
    Navigator.pop(context, ResultadoDetalle(AccionDetalle.borrar, elemento));
  }

  @override
  Widget build(BuildContext context) {
    final color = colorTipo(elemento.tipo);
    final fecha = elemento.fechaAlta.toLocal();
    final fechaTexto =
        '${fecha.day.toString().padLeft(2, '0')}/${fecha.month.toString().padLeft(2, '0')}/${fecha.year}';
    return Scaffold(
      appBar: AppBar(title: const Text('Tu colección')),
      body: SafeArea(
        child: MarcoPagina(
          ancho: 680,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Container(
                height: 172,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withValues(alpha: 0.22),
                      color.withValues(alpha: 0.04),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: color.withValues(alpha: 0.24)),
                ),
                child: Icon(iconoTipo(elemento.tipo), size: 72, color: color),
              ),
              const SizedBox(height: 28),
              Text(
                elemento.tipo.etiqueta.toUpperCase(),
                style: TextStyle(
                  color: color,
                  letterSpacing: 2,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                elemento.titulo,
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Chip(label: Text(elemento.estado.etiqueta(elemento.tipo))),
                  SelectorEstrellas(valor: elemento.valoracion, tamano: 26),
                  if (elemento.valoracion == 0) const Text('Sin valorar'),
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
                        'TUS NOTAS',
                        style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        elemento.notas?.isNotEmpty == true
                            ? elemento.notas!
                            : 'Todavía no has añadido notas.',
                        style: const TextStyle(height: 1.7),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'En tu lista desde el $fechaTexto',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              FilledButton.icon(
                onPressed: () => _editar(context),
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Editar elemento'),
              ),
              const SizedBox(height: 12),
              TextButton.icon(
                onPressed: () => _borrar(context),
                icon: const Icon(Icons.delete_outline_rounded),
                label: const Text('Borrar de mi lista'),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
