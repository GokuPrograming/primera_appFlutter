import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth {
  String? email;
  String? correo;
  String? nombre;
  final FirebaseAuth auth = FirebaseAuth.instance;

  createUser<bool>(String user, String email, String password) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      credential.user!.emailVerified;
      validarUser(email, password);
      return true;
      // Aquí accedes al usuario creado
    } catch (e) {
      print(e); // Imprime cualquier error
      // Retorna null en caso de error
    }
    return false;
  }

  Future<bool> validarUser(String email, String password) async {
    try {
      final credencial = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (credencial.user!.emailVerified) {
        return true;
      }
    } catch (e) {
      print('error al verificar usuario${e}');
    }

    return false;
  }
}
