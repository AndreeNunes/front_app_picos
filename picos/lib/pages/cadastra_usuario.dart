import 'dart:convert';

import 'package:artes_decoracoes/components/button_primary.dart';
import 'package:artes_decoracoes/components/input_text.dart';
import 'package:artes_decoracoes/pages/cadastra_usuario_photo.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CadastraUsuario extends StatefulWidget {
  @override
  _CadastraUsuarioState createState() => _CadastraUsuarioState();
}

class _CadastraUsuarioState extends State<CadastraUsuario> {
  String email;
  String usuario;
  String telefone;
  String senha;
  String cep;
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _buildBody(),
    );
  }

  @protected
  @mustCallSuper
  // ignore: must_call_super
  void initState() {
    pr = new ProgressDialog(context);
    pr.style(
        message: 'Por favor espere...',
        borderRadius: 20.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
        ),
        padding: EdgeInsets.all(30),
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
  }

  _appBar() {
    return AppBar(
      elevation: 0,
      title: Text("Cadastro"),
      backgroundColor: Color(0xcc4B0082),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: FaIcon(FontAwesomeIcons.infoCircle),
          onPressed: () {},
        )
      ],
    );
  }

  _buildBody() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.purple[50]])),
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 50, left: 45),
            height: 100,
            alignment: Alignment.centerLeft,
            child: Text(
              'Insira os dados',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
            ),
          ),
          Container(margin: EdgeInsets.only(top: 20.0), child: Divider()),
          InputText('E-mail',
              IconButton(icon: FaIcon(FontAwesomeIcons.at), onPressed: () {}),
              (value) {
            email = value;
          },
            textInputType: TextInputType.emailAddress,
          ),
          InputText(
              'Usuario',
              IconButton(
                  icon: FaIcon(FontAwesomeIcons.userAlt),
                  onPressed: () {}), (value) {
            usuario = value;
          }),
          InputText(
              'Telefone',
              IconButton(
                  icon: FaIcon(FontAwesomeIcons.phoneAlt),
                  onPressed: () {}), (value) {
            telefone = value;
          },
          textInputType: TextInputType.phone,
          ),
          InputText('Senha',
              IconButton(icon: FaIcon(FontAwesomeIcons.key), onPressed: () {}),
              (value) {
            senha = value;
          },
          obscureText: true,
          ),
          Container(
            height: 60,
          ),
          ButtonPrimary(() {
            _buildProxCadastro();
          }, 'Prosseguir'),
          Container(
            height: 60,
          ),
        ],
      ),
    );
  }

  _buildProxCadastro() async {
    if (email == null || usuario == null || telefone == null || senha == null) {
      setState(() {
        pr.hide();
      });
      Flushbar(
        title: "Aviso",
        icon: Icon(Icons.warning),
        backgroundColor: Colors.purpleAccent,
        message: "Algum dado esta vazio, por favor verifique e tente novamente",
        duration: Duration(seconds: 3),
      )..show(context);
    } else {
      setState(() {
        pr.show();
      });

      try {
        http.Response response;

        response = await http.get(
            "http://andreeez.ddns.net:9090/picos/valida/cadastro/${email}/${usuario}/${telefone}/${senha}/");

        Map<String, dynamic> prosseguir = jsonDecode(response.body);

        if (prosseguir['sucessoCadastro'] != 'true') {
          setState(() {
            pr.hide();
          });

          Flushbar(
            title: "Aviso",
            icon: Icon(Icons.warning),
            backgroundColor: Colors.purpleAccent,
            message:
                "O login ou Email, ja contem no sistema, por favor tente altera-los",
            duration: Duration(seconds: 3),
          )..show(context);
        } else {
          salveLoginLocale();
          setState(() {
            pr.hide();
          });

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CadastraUsuarioPhoto(usuario)));
        }
      } catch (e) {
        print(e);
      }
    }
  }

  salveLoginLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('loginLogado', usuario);
    prefs.setString('loginSenha', senha);
  }
}
