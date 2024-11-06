import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final conUser = TextEditingController();
  final conPwd = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    TextFormField txtUser = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: conUser,
      decoration: const InputDecoration(prefixIcon: Icon(Icons.person)),
    );

    final txtPwd = TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: conPwd,
      decoration: InputDecoration(prefixIcon: Icon(Icons.password)),
    );

    final ctnCredentials = Positioned(
      top: 400,
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        //margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(10)),
        child: ListView(
          shrinkWrap: true,
          children: [txtUser, txtPwd],
        ),
      ),
    );

    final btnLogin = Positioned(
      width: MediaQuery.of(context).size.width * .9,
      top: 500,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[200]),
          onPressed: () {
            isLoading = true;
            setState(() {});
            Future.delayed(const Duration(milliseconds: 4000)).then((value) => {
                  isLoading = false,
                  setState(() {}),
                  Navigator.pushNamed(context, "/home")
                });
          },
          child: const Text('Validar Usuario')),
    );
    final btnRegistro = Positioned(
      width: MediaQuery.of(context).size.width * .9,
      top: 550,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[200]),
          onPressed: () {
            // isLoading = true;
            // setState(() {});
            // Future.delayed(const Duration(milliseconds: 4000)).then((value) => {
            //       isLoading = false,
            //       setState(() {}),

            //     });
            Navigator.pushNamed(context, "/registro");
          },
          child: const Text('Registrar Usuario')),
    );

    final gifLoading = Positioned(
        top: 5,
        child: Image.asset(
          'assets/loading.gif',
          height: 200,
        ));

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('assets/halo.png'))),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                top: 100,
                child: Image.asset(
                  'assets/halo_logo.png',
                  width: 180,
                )),
            ctnCredentials,
            btnLogin,
            btnRegistro,
            isLoading ? gifLoading : Container()
          ],
        ),
      ),
    );
  }
}
