import 'dart:convert';

import 'package:artes_decoracoes/components/button_primary.dart';
import 'package:artes_decoracoes/components/input_text.dart';
import 'package:artes_decoracoes/components/input_texte_dialog.dart';
import 'package:artes_decoracoes/pages/cadastra_usuario_tipo.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

class CadastraUsuarioCep extends StatefulWidget {
  @override
  _CadastraUsuarioCepState createState() => _CadastraUsuarioCepState();
}

class _CadastraUsuarioCepState extends State<CadastraUsuarioCep> {
  String cep;
  String numero;
  String complemento;
  ProgressDialog pr;
  final focus = FocusNode();
  Map<String, dynamic> cepEncontradoGlobal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _buidBody(),
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

  _buidBody() {
    return Container(
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
              'Insira o seu endereço',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Divider(),
          ),
          Container(
            alignment: Alignment.center,
            height: 250,
            width: MediaQuery.of(context).size.width / 1,
            child: IconButton(
              icon: FaIcon(FontAwesomeIcons.solidAddressCard),
              onPressed: null,
              iconSize: 150,
            ),
          ),
          InputText(
            'Cep',
            IconButton(
                icon: FaIcon(FontAwesomeIcons.addressBook), onPressed: () {}),
            (value) {
              cep = value;
            },
            focus: focus,
          ),
          Container(
            height: 50,
          ),
          ButtonPrimary(
            () {
              _searchCep();
            },
            "Procurar endereço",
          ),
          Container(
            height: 20,
          ),
          ButtonPrimary(
            () {
              _buidProsseguir();
            },
            "Prosseguir",
          ),
        ],
      ),
    );
  }

  _searchCep() async {
    FocusScope.of(context).requestFocus(new FocusNode());

    setState(() {
      pr.show();
    });

    try {
      http.Response response;

      response = await http.get("https://viacep.com.br/ws/${cep}/json/");

      Map<String, dynamic> cepEncontrado = jsonDecode(response.body);

      setState(() {
        pr.hide();
      });

      _buildDialogConfirmCep(cepEncontrado);
    } catch (e) {
      setState(() {
        pr.hide();
      });

      return Flushbar(
        title: "Aviso",
        icon: Icon(Icons.warning),
        backgroundColor: Colors.purpleAccent,
        message:
            "Ocorreu algum erro, por favor verifique a conexão com a internet",
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }

  _buildDialogConfirmCep(Map<String, dynamic> cepEncontrado) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Confirma o cep encontrado?"),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: Wrap(
            children: <Widget>[
              new Text(
                  "${cepEncontrado['logradouro']}\nBairro ${cepEncontrado['bairro']}\nCidade ${cepEncontrado['localidade']}\nEstado ${cepEncontrado['uf']}"),
              InputTextDialog(
                  'Numero',
                  IconButton(
                      icon: FaIcon(FontAwesomeIcons.addressCard),
                      onPressed: null), (value) {
                numero = value;
              }),
              InputTextDialog(
                  'Complemento',
                  IconButton(
                      icon: FaIcon(FontAwesomeIcons.building),
                      onPressed: null), (value) {
                complemento = value;
              })
            ],
          ),
          actions: <Widget>[
            FlatButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            FlatButton(
                child: Text('Confirmar'),
                onPressed: () {
                  if (numero == null && complemento == null) {
                    print('flush bar');
                  } else {
                    cepEncontradoGlobal = cepEncontrado;
                    Navigator.of(context).pop();
                  }
                })
          ],
        );
      },
    );
  }

  _buidProsseguir() async{
    http.Response response;

    print('aqui');
    String rua = cepEncontradoGlobal['logradouro'];
    String bairro = cepEncontradoGlobal['bairro'];
    String cidade = cepEncontradoGlobal['localidade'];
    String uf = cepEncontradoGlobal['uf'];

    response = await http.get("http://andreeez.ddns.net:8080/picos/valida/endereco/${cep}/${rua}/${bairro}/${cidade}/${uf}/${numero}/${complemento}");
    
    Navigator.push(context,
              MaterialPageRoute(builder: (context) => CadastraUsuarioTipo()));
  }
}
