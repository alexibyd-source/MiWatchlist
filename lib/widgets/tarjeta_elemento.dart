// Se usa Material del SDK para respetar los paquetes del enunciado.
// ignore: deprecated_member_use
import 'package:flutter/material.dart';

import '../modelos/elemento.dart';
import 'selector_estrellas.dart';
import 'imagen_elemento.dart';

/// Devuelve el color asociado al tipo de contenido.
Color colorTipo(Tipo tipo) => switch (tipo) {
  Tipo.pelicula => const Color(0xFFB8AFF2),
  Tipo.serie => const Color(0xFF8ACFE2),
  Tipo.videojuego => const Color(0xFFF2BA91),
};

/// Devuelve el icono asociado al tipo de contenido.
IconData iconoTipo(Tipo tipo) => switch (tipo) {
  Tipo.pelicula => Icons.movie_outlined,
  Tipo.serie => Icons.live_tv_outlined,
  Tipo.videojuego => Icons.sports_esports_outlined,
};

/// Muestra un resumen del elemento y delega la pulsación en su callback.
class TarjetaElemento extends StatelessWidget {
  const TarjetaElemento({
    super.key,
    required this.elemento,
    required this.onTap,
  });
  final Elemento elemento;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = colorTipo(elemento.tipo);
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 72,
                height: 104,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ImagenElemento(
                  url: elemento.imagenUrl,
                  icono: iconoTipo(elemento.tipo),
                  color: color,
                  tamano: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      elemento.tipo.etiqueta.toUpperCase(),
                      style: TextStyle(
                        color: color,
                        fontSize: 10,
                        letterSpacing: 1.8,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      elemento.titulo,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 16,
                      runSpacing: 8,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          elemento.estado.etiqueta(elemento.tipo),
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurfaceVariant,
                            fontSize: 12,
                          ),
                        ),
                        SelectorEstrellas(
                          valor: elemento.valoracion,
                          tamano: 18,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_outward_rounded,
                size: 18,
                color: Color(0xFF758094),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
