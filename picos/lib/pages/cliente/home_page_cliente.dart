import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageCliente extends StatefulWidget {
  @override
  _HomePageClienteState createState() => _HomePageClienteState();
}

class _HomePageClienteState extends State<HomePageCliente> {
  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Center(child: Text('My Page!')),
      drawer: _buildDrawer(),
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
    );
  }

  _buildDrawer() {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
