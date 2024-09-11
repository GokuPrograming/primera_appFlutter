import 'package:flutter/material.dart';

///tema personalizado
class ThemeSetting {
  //tiene que recibir un contexto
  static ThemeData ligthTheme() {
    ///se usa para poder reescribir el tema
    final theme = ThemeData.light();
    //se copian todos los valores que se estan usando
    //para poder hacer mutable a un objeto inmutable, para acceder a sus propiedades para hacer muchas cosas
    return theme.copyWith(
    scaffoldBackgroundColor: Colors.amber.shade100
    );
  }
  //el archivo singletone son para que no se instancie , o que no se repita la inttancia

  static ThemeData darkTheme() {
    final theme = ThemeData.dark();
    return theme.copyWith();
  }

  static ThemeData ThemeIsra() {
    final theme = ThemeData.dark();
    return theme.copyWith();
  }
}
