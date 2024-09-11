import 'package:flutter/material.dart';
import 'package:primerapp/screen/home_secreen.dart';
import 'package:primerapp/screen/login_screen.dart';
import 'package:primerapp/settings/global_values.dart';
import 'package:primerapp/settings/theme_setting.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true, // Avoid system intrusions at the top
      bottom: true,

      ///tenemos que envoolver en MaterialApp dentro de un Builder por que el buider regresa un witget
      ///se usa el valueListenableBuilder, para qyue podamos trabajarlo
      child: ValueListenableBuilder(

          ///este ayuda a monitorial la variable
          valueListenable: GlobalValues.banThemeDark,
          builder: (context, value, widget)
//dynamic es cualquier tipo de dato,que corresponde al valor que estamos trabajando jajsa
              ///el guin bajo es algo que va a ignorar
              {
            return MaterialApp(
                title: 'Material App',
                debugShowCheckedModeBanner: false,

                //cambiar un tema es con el gestor de estado
                //
                theme: value
                    ? ThemeSetting.darkTheme()
                    : ThemeSetting.ligthTheme(),
                // ? ThemeData.dark() //si es true
                // : ThemeData.light(), //si no XD
                home: const LoginScreen(),
                routes: {"/home": (context) => const HomeScreen()});
          }),
    );
  }
}
