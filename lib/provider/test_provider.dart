import 'package:flutter/material.dart';

class TestProvider extends ChangeNotifier {
  ///siempre manejar variables privadas en el provider
  ///
  String _name = 'Miguel Vera Franco';
  String get name => _name;
  set name(String value) {
    _name = value;
    notifyListeners();
    // al usarlo no le importa si es stateLess o stateFull, logrando la optimizacion 
    
  }
}
