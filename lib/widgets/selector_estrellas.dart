// Se usa Material del SDK para respetar los paquetes del enunciado.
// ignore: deprecated_member_use
import 'package:flutter/material.dart';

/// Muestra la valoración y permite cambiarla cuando recibe un callback.
class SelectorEstrellas extends StatelessWidget {
  const SelectorEstrellas({
    super.key,
    required this.valor,
    this.onChanged,
    this.tamano = 22,
  });
  final int valor;
  final ValueChanged<int>? onChanged;
  final double tamano;

  @override
  Widget build(BuildContext context) {
    if (onChanged == null) {
      return Semantics(
        label: valor == 0 ? 'Sin valorar' : '$valor de 5 estrellas',
        child: ExcludeSemantics(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(5, (i) => _icono(i)),
          ),
        ),
      );
    }
    return Wrap(
      spacing: 2,
      children: List.generate(
        5,
        (i) => IconButton(
          tooltip:
              '${i + 1} estrellas. Pulsa de nuevo para quitar la valoración',
          onPressed: () => onChanged!(valor == i + 1 ? 0 : i + 1),
          icon: _icono(i),
        ),
      ),
    );
  }

  /// Construye una estrella llena o vacía según la valoración actual.
  Widget _icono(int i) => Icon(
    i < valor ? Icons.star_rounded : Icons.star_outline_rounded,
    size: tamano,
    color: i < valor ? const Color(0xFFF4CD78) : const Color(0xFF758094),
  );
}
