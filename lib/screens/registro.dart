import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pmsn2024b/firebase/email_auth.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<Registro> {
  EmailAuth createUser = EmailAuth();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final conUser = TextEditingController();
  final conPwd = TextEditingController();
  final conName = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    TextFormField txtUser = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: conUser,
      decoration: const InputDecoration(
          prefixIcon: Icon(Icons.email), hintText: 'nombre de correo'),
    );

    final txtPwd = TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: conPwd,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.password), hintText: 'Password'),
    );
    final txtnombre = TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: conName,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person_3), hintText: 'nombre de usuario'),
    );

    final ctnCredentials = Positioned(
      bottom: 90,
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        //margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(10)),
        child: ListView(
          shrinkWrap: true,
          children: [txtUser, txtnombre, txtPwd],
        ),
      ),
    );

    final btnRegistro = Positioned(
      width: MediaQuery.of(context).size.width * .9,
      bottom: 40,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[200]),
          onPressed: () async {
            createUser.createUser(conName.text, conUser.text, conPwd.text);
            // //registrar
            // isLoading)true;
            //createUser.createUser(conName.text, conUser.text, conPwd.text).then(
            //   (value){
            //     value ? isLoading=false: isLoading;
            //   }
            // );
            setState(() {});
          },
          child: const Text('Validar Usuario')),
    );

    final gifLoading = Positioned(
        top: 5,
        child: Image.asset(
          'assets/loading.gif',
          height: 200,
        ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
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
            btnRegistro,
            isLoading ? gifLoading : Container()
          ],
        ),
      ),
    );
  }
}
