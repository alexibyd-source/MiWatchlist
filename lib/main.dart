// Se usa Material del SDK para respetar los paquetes del enunciado.
// ignore: deprecated_member_use
import 'package:flutter/material.dart';

import 'pantallas/pantalla_lista.dart';

/// Inicia la aplicación de Flutter.
void main() => runApp(const MiWatchlistApp());

/// Configura el tema y abre la pantalla principal de la aplicación.
class MiWatchlistApp extends StatelessWidget {
  const MiWatchlistApp({super.key});

  @override
  Widget build(BuildContext context) {
    final esquema =
        ColorScheme.fromSeed(
          seedColor: const Color(0xFFA9E5BB),
          brightness: Brightness.dark,
        ).copyWith(
          primary: const Color(0xFFA9E5BB),
          onPrimary: const Color(0xFF102318),
          surface: const Color(0xFF161C25),
          onSurface: const Color(0xFFF3F4F6),
          onSurfaceVariant: const Color(0xFFA5AEBC),
          outlineVariant: const Color(0xFF303846),
        );
    return MaterialApp(
      title: 'Mi Watchlist',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        useMaterial3: true,
        colorScheme: esquema,
        scaffoldBackgroundColor: const Color(0xFF0D121A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D121A),
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
          color: esquema.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: BorderSide(color: esquema.outlineVariant),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: esquema.surface,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: esquema.outlineVariant),
          ),
          contentPadding: const EdgeInsets.all(18),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size(48, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        chipTheme: ChipThemeData(
          side: BorderSide(color: esquema.outlineVariant),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
      ),
      home: const PantallaLista(),
    );
  }
}
