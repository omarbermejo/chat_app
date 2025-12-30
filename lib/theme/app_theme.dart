// Se gestiona el thema , colores y fondos de la app completa, esto para tener el manejo y control de ella


// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppThemeCustom {
  static const Color colorPrincipal = Colors.white;
  static const Color colorSecundarioDark = Colors.black;

  static const Color colorTexto = Colors.black;
  static const Color colorTextoContrario = Colors.white;
  static const Color colorTextoSecundario = Colors.red;

  static final ThemeData ligthTheme = ThemeData.light().copyWith(
    primaryColor: colorSecundarioDark,
    scaffoldBackgroundColor: colorPrincipal,
    appBarTheme: const AppBarTheme(
      color: colorPrincipal,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: colorTexto,
        fontWeight: FontWeight.w800,
        fontSize: 35,
      ),),
    );
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: colorSecundarioDark,
    scaffoldBackgroundColor: colorSecundarioDark,
    appBarTheme: const AppBarTheme(
      color: colorSecundarioDark,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: colorTextoContrario,
        fontWeight: FontWeight.w800,
        fontSize: 35,
      ),
    ),
     );
}
