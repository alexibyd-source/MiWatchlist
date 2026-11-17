// Se usa Material del SDK para respetar los paquetes del enunciado.
// ignore: deprecated_member_use
import 'package:flutter/material.dart';

import '../modelos/elemento.dart';
import '../widgets/marco_pagina.dart';
import '../widgets/selector_estrellas.dart';

/// Reutiliza el formulario para crear o editar según el elemento inicial.
class PantallaFormulario extends StatefulWidget {
  const PantallaFormulario({super.key, this.inicial});
  final Elemento? inicial;

  @override
  State<PantallaFormulario> createState() => _PantallaFormularioState();
}

/// Gestiona los campos, la validación y el resultado del formulario.
class _PantallaFormularioState extends State<PantallaFormulario> {
  final _formKey = GlobalKey<FormState>();
  final _focoTitulo = FocusNode();
  late final TextEditingController _titulo;
  late final TextEditingController _notas;
  late final TextEditingController _imagen;
  late Tipo _tipo;
  late Estado _estado;
  late int _valoracion;

  /// Inicializa el estado y prepara los datos o controladores de la pantalla.
  @override
  void initState() {
    super.initState();
    final inicial = widget.inicial;
    _titulo = TextEditingController(text: inicial?.titulo ?? '');
    _notas = TextEditingController(text: inicial?.notas ?? '');
    _imagen = TextEditingController(text: inicial?.imagenUrl ?? '');
    _tipo = inicial?.tipo ?? Tipo.pelicula;
    _estado = inicial?.estado ?? Estado.pendiente;
    _valoracion = inicial?.valoracion ?? 0;
  }

  /// Libera los controladores y nodos de foco al cerrar la pantalla.
  @override
  void dispose() {
    _focoTitulo.dispose();
    _titulo.dispose();
    _notas.dispose();
    _imagen.dispose();
    super.dispose();
  }

  /// Valida o persiste los datos antes de confirmar el cambio.
  void _guardar() {
    if (!_formKey.currentState!.validate()) {
      if (_titulo.text.trim().isEmpty || _titulo.text.trim().length > 60) {
        _focoTitulo.requestFocus();
      }
      return;
    }
    final notas = _notas.text.trim();
    final imagen = _imagen.text.trim();
    final inicial = widget.inicial;
    final elemento = inicial == null
        ? Elemento(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            titulo: _titulo.text,
            tipo: _tipo,
            estado: _estado,
            valoracion: _valoracion,
            notas: notas.isEmpty ? null : notas,
            imagenUrl: imagen.isEmpty ? null : imagen,
            fechaAlta: DateTime.now(),
          )
        : inicial.copyWith(
            titulo: _titulo.text,
            tipo: _tipo,
            estado: _estado,
            valoracion: _valoracion,
            notas: notas,
            borrarNotas: notas.isEmpty,
            imagenUrl: imagen,
            borrarImagen: imagen.isEmpty,
          );
    Navigator.pop(context, elemento);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        widget.inicial == null ? 'Nuevo elemento' : 'Editar elemento',
      ),
    ),
    body: SafeArea(
      child: MarcoPagina(
        ancho: 640,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.inicial == null
                      ? 'Tu próxima gran historia.'
                      : 'Cada historia evoluciona.',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Guarda lo que te apetece ver o jugar.',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  key: const Key('campo_titulo'),
                  controller: _titulo,
                  focusNode: _focoTitulo,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    hintText: 'Por ejemplo, Dune: Parte 2',
                    helperText: 'Obligatorio · hasta 60 caracteres',
                  ),
                  validator: (valor) {
                    final texto = valor?.trim() ?? '';
                    if (texto.isEmpty) return 'Escribe un título.';
                    if (texto.length > 60) {
                      return 'El título no puede superar los 60 caracteres.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                DropdownButtonFormField<Tipo>(
                  initialValue: _tipo,
                  decoration: const InputDecoration(labelText: 'Tipo'),
                  items: Tipo.values
                      .map(
                        (tipo) => DropdownMenuItem(
                          value: tipo,
                          child: Text(tipo.etiqueta),
                        ),
                      )
                      .toList(),
                  onChanged: (tipo) {
                    if (tipo != null) setState(() => _tipo = tipo);
                  },
                ),
                const SizedBox(height: 24),
                DropdownButtonFormField<Estado>(
                  initialValue: _estado,
                  decoration: const InputDecoration(labelText: 'Estado'),
                  items: Estado.values
                      .map(
                        (estado) => DropdownMenuItem(
                          value: estado,
                          child: Text(estado.etiqueta(_tipo)),
                        ),
                      )
                      .toList(),
                  onChanged: (estado) {
                    if (estado != null) setState(() => _estado = estado);
                  },
                ),
                const SizedBox(height: 28),
                const Text(
                  'TU VALORACIÓN',
                  style: TextStyle(
                    fontSize: 11,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                SelectorEstrellas(
                  valor: _valoracion,
                  tamano: 32,
                  onChanged: (valor) => setState(() => _valoracion = valor),
                ),
                Text(
                  _valoracion == 0
                      ? 'Sin valorar. Puedes decidirlo más adelante.'
                      : '$_valoracion de 5 estrellas · pulsa la misma estrella para quitarla.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 28),
                TextFormField(
                  key: const Key('campo_imagen'),
                  controller: _imagen,
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    labelText: 'Enlace de imagen (opcional)',
                    hintText: 'https://ejemplo.com/portada.jpg',
                    helperText: 'Pega el enlace directo a una imagen.',
                  ),
                  validator: (valor) {
                    final texto = valor?.trim() ?? '';
                    if (texto.isEmpty) return null;
                    final uri = Uri.tryParse(texto);
                    if (uri == null ||
                        !['http', 'https'].contains(uri.scheme) ||
                        uri.host.isEmpty) {
                      return 'Introduce un enlace http o https válido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _notas,
                  minLines: 3,
                  maxLines: 6,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Notas (opcional)',
                    hintText: '¿Por qué te apetece? ¿Dónde te quedaste?',
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 32),
                FilledButton.icon(
                  key: const Key('guardar'),
                  onPressed: _guardar,
                  icon: const Icon(Icons.check_rounded),
                  label: const Text('Guardar'),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
