import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:primerapp/screen/login_screen.dart';
import 'package:primerapp/screen/profile_screen.dart';
import 'package:primerapp/settings/colors_settings.dart';
import 'package:primerapp/settings/global_values.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final _key = GlobalKey<
      ExpandableFabState>(); //es para obtener el contexto y usalo de manera global
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //el color esta en un archivo(settings)
        backgroundColor: ColorsSettings.navColor,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.access_alarm_outlined)),

          ///para que la imagen parezaca como botton o icono
          GestureDetector(
            onTap: () {},
            child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Image.asset('assets/cat-food.png')),
          )

          /// si es qeu esta orientada a web
        ],
      ),

      //los builders siempre retornar un witget
      //para que esto pueda fuincionar se necesita el index
      body: Builder(builder: (context) {
        switch (index) {
          case 0:
            return const ProfileScreen();
          case 1:
            return const LoginScreen();
          default:
            return const ProfileScreen();
        }
      }),
      // endDrawer: Drawer(),
      drawer: const Drawer(),
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.person, title: 'Profile'),
          TabItem(icon: Icons.exit_to_app, title: 'Exit'),
        ],
        onTap: (int i) => setState(() {
          ///asigna el cambio de variable, y en el render de la pantalla se
          ///cahca ese valor para el cambio de la pantalla
          index = i;
        }),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(key: _key, children: [
        //es necesario una accion para que pueda mostra el bton
        FloatingActionButton.small(
          onPressed: () {
            //shared preference, para valores compartidos predefinidos

            GlobalValues.banThemeDark.value = false;
          },
          child: const Icon(Icons.light_mode),
        ),
        FloatingActionButton.small(
          onPressed: () {
            GlobalValues.banThemeDark.value = true;
          },
          child: const Icon(Icons.mode_night),
        )
      ]),
    );
  }
}
