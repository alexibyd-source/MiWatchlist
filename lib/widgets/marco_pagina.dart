// Se usa Material del SDK para respetar los paquetes del enunciado.
// ignore: deprecated_member_use
import 'package:flutter/material.dart';

/// Centra el contenido y limita su anchura en pantallas grandes.
class MarcoPagina extends StatelessWidget {
  const MarcoPagina({super.key, required this.child, this.ancho = 1000});
  final Widget child;
  final double ancho;

  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: ancho),
      child: child,
    ),
  );
}
