import 'package:artes_decoracoes/components/drawer_header_default.dart';
import 'package:artes_decoracoes/model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageCliente extends StatefulWidget {
  Usuario usuario = new Usuario();
  HomePageCliente(Usuario usuario) {
    this.usuario = usuario;
  }

  @override
  _HomePageClienteState createState() => _HomePageClienteState(usuario);
}

class _HomePageClienteState extends State<HomePageCliente> {
  ProgressDialog pr;
  Usuario usuario = new Usuario();

  _HomePageClienteState(Usuario usuario) {
    this.usuario = usuario;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Center(child: Text('My Page!')),
      drawer: _buildDrawer(),
    );
  }

  @protected
  void initState() {
    super.initState();
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
    );
  }

  _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeaderDefault(
            usuario.getNomeUsuario(),
            usuario.getEmailUsuario(),
            usuario.getIdFotoPerfil()
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.addressCard),
            title: Text('Perfil'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.history),
            title: Text('Historico'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.cogs),
            title: Text('Configurações'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.envelopeOpenText),
            title: Text('Entre em contato'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.reply),
            title: Text('Sair'),
            onTap: () {},
          ),
          Container(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Column(
                children: <Widget>[
                  Divider(),
                  ListTile(
                      leading: Icon(FontAwesomeIcons.facebook),
                      title: Text('Facebook')),
                  ListTile(
                      leading: Icon(FontAwesomeIcons.instagram),
                      title: Text('Instagram'))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
