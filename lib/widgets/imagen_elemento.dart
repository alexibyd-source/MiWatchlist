// ignore: deprecated_member_use
import 'package:flutter/material.dart';

/// Muestra una portada remota y un icono si falta o no se puede cargar.
class ImagenElemento extends StatelessWidget {
  const ImagenElemento({
    super.key,
    required this.url,
    required this.icono,
    required this.color,
    this.tamano = 40,
  });
  final String? url;
  final IconData icono;
  final Color color;
  final double tamano;

  @override
  Widget build(BuildContext context) {
    final alternativa = Center(
      child: Icon(icono, color: color, size: tamano),
    );
    if (url == null || url!.isEmpty) return alternativa;
    return Image.network(
      url!,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
      errorBuilder: (_, error, stack) => alternativa,
    );
  }
}
