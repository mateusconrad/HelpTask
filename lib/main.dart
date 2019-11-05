import 'package:app_vai/login.dart';
import 'package:flutter/material.dart';

void main() {
  //Firestore.instance.collection("usuarios").document("001").setData({"nome":"Mateus"});
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Login(),
    theme: ThemeData(
      brightness: Brightness.light,
    ),
  ));
}