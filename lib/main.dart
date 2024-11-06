import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pmsn2024b/provider/test_provider.dart';
import 'package:pmsn2024b/screens/detailPupularScreen.dart';
import 'package:pmsn2024b/screens/home_screen.dart';
import 'package:pmsn2024b/screens/login_screen.dart';
import 'package:pmsn2024b/screens/movies_screen.dart';
import 'package:pmsn2024b/screens/movies_screen_fireBase.dart';
import 'package:pmsn2024b/screens/popularScreen.dart';
import 'package:pmsn2024b/screens/registro.dart';
import 'package:pmsn2024b/settings/global_values.dart';
import 'package:pmsn2024b/settings/theme_settings.dart';
import 'package:provider/provider.dart';

///validar con fiebase
void main() async {
  ///inicializar la aplicacion
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder(
          valueListenable: GlobalValues.banThemeDark,
          builder: (context, value, widget) {
            return ChangeNotifierProvider(
              create: (context) => TestProvider(),
              //el provider funciona solo si envolvemos todos lso widgets
              child: MaterialApp(
                title: 'Material App',
                debugShowCheckedModeBanner: false,
                home: LoginScreen(),
                theme: value
                    ? ThemeSettings.darkTheme()
                    : ThemeSettings.ligthTheme(),
                routes: {
                  "/home": (context) => HomeScreen(),
                  "/db": (context) => MoviesScreen(),
                  "/movies": (context) => Popularscreen(),
                  "/detalle": (context) => Detailpupularscreen(),
                  "/registro": (context) => Registro(),
                  "/firebaseMovies": (context) => MoviesScreenFirebase()
                },
              ),
            );
          }),
    );
  }
}
