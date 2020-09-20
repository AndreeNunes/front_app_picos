import 'dart:convert';

import 'package:artes_decoracoes/components/button_primary.dart';
import 'package:artes_decoracoes/components/divider_or.dart';
import 'package:artes_decoracoes/components/input_text.dart';
import 'package:artes_decoracoes/components/primary_title.dart';
import 'package:artes_decoracoes/pages/cadastra_usuario.dart';
import 'package:artes_decoracoes/pages/cadastra_usuario_cep.dart';
import 'package:artes_decoracoes/pages/cliente/home_page_cliente.dart';
import 'package:artes_decoracoes/pages/prestador/home_page_prestador.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String usuarioLogin;
  String senhaLogin;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _builBodyLoginPage(),
    );
  }

  _builBodyLoginPage() {
    return Container(
      width: MediaQuery.of(context).size.width / 1,
      height: MediaQuery.of(context).size.height / 1,
      child: Wrap(
        children: <Widget>[
          _buildheaderLoginPage(),
          InputText(
              "Usuario",
              IconButton(
                  icon: FaIcon(FontAwesomeIcons.userAlt),
                  iconSize: 20,
                  onPressed: () {}), (value) {
            usuarioLogin = value;
          }),
          InputText(
            "Senha",
            IconButton(
                icon: FaIcon(FontAwesomeIcons.key),
                iconSize: 20,
                onPressed: () {}),
            (value) {
              senhaLogin = value;
            },
            obscureText: true,
          ),
          Container(
            height: 50,
          ),
          ButtonPrimary(
            () {
              _functionLogar();
            },
            'Entrar',
          ),
          Container(
            height: 30,
          ),
          DividerOr(),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width / 1,
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CadastraUsuario()));
              },
              child: Text("Cadastra-se",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.black45)),
            ),
          )
        ],
      ),
    );
  }

  // decoration: BoxDecoration(border: Border.all(color: Colors.amber)),
  _buildheaderLoginPage() {
    return Container(
      width: MediaQuery.of(context).size.width / 1,
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90.0)),
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xcc4B0082),
              Color(0xFF4B0082),
            ]),
      ),
      child: Wrap(
        children: <Widget>[
          Container(
            height: 290,
            width: MediaQuery.of(context).size.width / 1,
            child: IconButton(
              icon: FaIcon(FontAwesomeIcons.artstation),
              onPressed: () {},
              iconSize: 70,
              color: Colors.white,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1,
            height: 60,
            margin: EdgeInsets.only(right: 40),
            child: Wrap(
              alignment: WrapAlignment.end,
              runAlignment: WrapAlignment.start,
              children: <Widget>[
                PrimaryTitle(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future _functionLogar() async {

    String username = 'tavoando';
    String password = 'deitando';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    var body = {
      "username": "${usuarioLogin}",
      "password": "${senhaLogin}",
      "grant_type": "password"
    };

    http.Response response;
    response = await http.post("http://andreeez.ddns.net:9090/oauth/token",
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'authorization': basicAuth,
        },
        body: body);

    Map<String, dynamic> usuarioLogado = jsonDecode(response.body);

    print(response.body);

    /*http.Response response;
    response = await http.get(
        "http://andreeez.ddns.net:8080/picos/login/${usuarioLogin}/${senhaLogin}");

    Map<String, dynamic> usuarioLogado = jsonDecode(response.body);

    if (usuarioLogado['logadoCadastro'] == 'true') {
      if (usuarioLogado['tipoCadastro'] == 'prestador') {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePagePrestador()));
      } else if (usuarioLogado['tipoCadastro'] == 'cliente') {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePageCliente()));
      }
    } else {
      return Flushbar(
        title: "Aviso",
        icon: Icon(Icons.warning),
        backgroundColor: Colors.purpleAccent,
        message: "Os dados não conferem",
        duration: Duration(seconds: 3),
      )..show(context);
    }*/
  }
}
