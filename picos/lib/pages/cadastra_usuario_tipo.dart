import 'dart:convert';

import 'package:artes_decoracoes/components/button_primary.dart';
import 'package:artes_decoracoes/model/Usuario.dart';
import 'package:artes_decoracoes/pages/cliente/home_page_cliente.dart';
import 'package:artes_decoracoes/pages/prestador/home_page_prestador.dart';
import 'package:artes_decoracoes/services/carrega_info_usuario.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

class CadastraUsuarioTipo extends StatefulWidget {
  String usuario;

  CadastraUsuarioTipo(String usuario){
    this.usuario = usuario;
  }

  @override
  _CadastraUsuarioTipoState createState() => _CadastraUsuarioTipoState(usuario);
}

class _CadastraUsuarioTipoState extends State<CadastraUsuarioTipo> {
  int isClient = 0;
  ProgressDialog pr;
  Usuario usuario = new Usuario();
  CarregaInfoUsuario carregaInfoUsuario = new CarregaInfoUsuario();
  String usuarioLogin;

  _CadastraUsuarioTipoState(String usuarioLogin){
    this.usuarioLogin = usuarioLogin;
  }
  

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
    pr = new ProgressDialog(
      context,
      isDismissible: false,
    );
    pr.style(
        message: 'Por favor aguarde...',
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
    return ListView(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width / 1,
          height: MediaQuery.of(context).size.height / 1,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.purple[50]])),
          child: Wrap(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 50, left: 45),
                height: 100,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Selecione o seu perfil',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Divider(),
              ),
              Container(
                height: 40,
              ),
              Container(
                child: _buildCardClient(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.deepOrangeAccent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.1),
                      blurRadius: 1.0,
                    ),
                  ],
                ),
                height: 150,
                width: MediaQuery.of(context).size.width / 1,
                margin: EdgeInsets.only(left: 40, right: 40),
              ),
              Container(
                height: 40,
              ),
              Container(
                child: _buildCardPrestador(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.deepPurple,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.1), //(x,y)
                      blurRadius: 1.0,
                    ),
                  ],
                ),
                height: 150,
                width: MediaQuery.of(context).size.width / 1,
                margin: EdgeInsets.only(left: 40, right: 40),
              ),
              Container(
                height: 80,
              ),
              ButtonPrimary(
                () {
                  _buildFinishRegister();
                },
                'Finalizar Cadastro',
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildCardClient() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isClient = 1;
        });
      },
      child: Container(
        margin: isClient != 1
            ? EdgeInsets.only(bottom: 7)
            : EdgeInsets.only(bottom: 12),
        width: MediaQuery.of(context).size.width / 1,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white)),
        child: Wrap(
          children: <Widget>[
            Container(
              height: 140,
              width: MediaQuery.of(context).size.width / 3,
              child: IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.userFriends,
                  color: isClient == 1 ? Colors.deepOrange : Colors.black45,
                ),
                onPressed: null,
                iconSize: 50,
              ),
            ),
            Container(
                alignment: Alignment.centerLeft,
                height: 140,
                width: MediaQuery.of(context).size.width / 2.5,
                child: Wrap(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Text(
                      "Cliente",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Text(
                        "Lorem Ipsum is simply dummy text of the printing.",
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  _buildCardPrestador() {
    return GestureDetector(
      onTap: () {
        setState(() {
          isClient = 2;
        });
      },
      child: Container(
        margin: isClient != 2
            ? EdgeInsets.only(bottom: 7)
            : EdgeInsets.only(bottom: 12),
        width: MediaQuery.of(context).size.width / 1,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white)),
        child: Wrap(
          children: <Widget>[
            Container(
              height: 140,
              width: MediaQuery.of(context).size.width / 3,
              child: IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.car,
                  color: isClient == 2 ? Colors.deepPurple : Colors.black45,
                ),
                onPressed: null,
                iconSize: 50,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: 140,
              width: MediaQuery.of(context).size.width / 2.5,
              child: Wrap(
                direction: Axis.vertical,
                children: <Widget>[
                  Text(
                    "Prestador",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Text(
                      "Lorem Ipsum is simply dummy text of the printing.",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildFinishRegister() async {
    http.Response response;

    if (isClient != 0) {
      setState(() {
        pr.show();
      });
      response = await http.get(
          "http://andreeez.ddns.net:9090/picos/finaliza/cadastro/${isClient}");

      setState(() {
        pr.hide();
      });

      usuario = await carregaInfoUsuario.carregaInfoUsuario(usuarioLogin);

      if (isClient == 1) {
        Usuario usuario = new Usuario();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePageCliente(usuario)));
      } else if (isClient == 2) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePagePrestador()));
      }
    } else {
      Flushbar(
        title: "Aviso",
        icon: Icon(Icons.warning),
        backgroundColor: Colors.purpleAccent,
        message: "Selecione o seu perfil por favor",
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }
}
