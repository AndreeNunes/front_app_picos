import 'package:artes_decoracoes/model/Usuario.dart';
import 'package:artes_decoracoes/pages/cliente/home_page_cliente.dart';
import 'package:artes_decoracoes/pages/home_page.dart';
import 'package:artes_decoracoes/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  String usuario;
  String senha;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _buildTheme(context),
      home: LoginPage(),
    );
  }

  _buildTheme(BuildContext context){
    return ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme,
      ),
      primaryColor: Color(0xFF4B0082),
    );
  }

  logado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('loginLogado');
    usuario = prefs.getString('loginLogado');
    senha = prefs.getString('loginSenha');
  }
}