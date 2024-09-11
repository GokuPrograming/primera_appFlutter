//statefullw
// se usaran grindView builder
//col
//row
//listView builder
//stack

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ///para recuperar los datos de usan los controladores
  final conUser = TextEditingController();
  final conPwd = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    //definicion de las cajas de texto
    TextFormField txtUser = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: conUser,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person),
      ),
    );
    TextFormField txtPass = TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: conPwd,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.password_sharp),
      ),
    );
    final ctnCredentials = Positioned(
      bottom: 100,
      child: Container(
        //para usar el botton, le debemos dar un tamaño en especifivo
        width: MediaQuery.of(context).size.width * .9,
        // margin: const EdgeInsets.symmetric(horizontal: 10),
        //simetric vertical y horizontal, soibre todo su hay elementos arriba y no se afcetan
        //only -> solo afecta un solo lado

        decoration: BoxDecoration(
            color: Colors.black87, borderRadius: BorderRadius.circular(20)),
        child: //puede un grind,row, listview,
            ListView(
          //solo la tiene list view
          shrinkWrap: true, //ayuda a capar
          //final declaras una constante en la compilacion
          children: [txtUser, txtPass],
        ),
      ),
    );

    final btnLogin = Positioned(
      width: MediaQuery.of(context).size.width * .9,
      bottom: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
        onPressed: () {
          isLoading = true;
          setState(() {});
          //se usa el then , para que lso demas valores no pasen a segundo plano
          Future.delayed(const Duration(milliseconds: 4000)).then(
            (value) => {
              isLoading = false,
              setState(() {}),
              Navigator.pushNamed(context, '/home')
            },
          );
        },
        child: const Text(
          'Login',
        ),
      ),
    );

    final gifLoading = Positioned(
      top: 5,
      child: Image.asset(
        'assets/tbag.gif',
        height: 100,
      ),
    );
    return Scaffold(
      body: Container(
        //estira a la imagen
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          //para un provider es ->ssetImage= es para las imagenes locales NetworkImage
          //images.network
          //image.file->imagen en el telefono, pero no en los assets
          //image.asset-> es un archivo dentro de la app
          image: DecorationImage(
              image: AssetImage('assets/halw_wallpaper.webp'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              ///ayuda a conocar de manera estatica
              top: 20,
              // left: 250,

              child: Image.asset(
                'assets/halo-png-44143.png',
                //elcontairner se adapta a sus hijos
                width: 100,
              ),
            ),
            ctnCredentials,
            btnLogin,
            isLoading ? gifLoading : Container(),
          ],
        ),
      ),
    );
  }
}
