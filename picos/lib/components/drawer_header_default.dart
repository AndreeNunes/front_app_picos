import 'package:flutter/material.dart';

class DrawerHeaderDefault extends StatelessWidget {
  String usuario;
  String email;
  String idFoto;

  DrawerHeaderDefault(String usuario, email, idFoto) {
    this.usuario = usuario;
    this.email = email;
    this.idFoto = idFoto;
  }

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Wrap(
      direction: Axis.vertical,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage('https://ucarecdn.com/ad23db85-e7f3-4b2c-9e65-2ff606cf53a6/-/resize/380x/'),
          maxRadius: 35,
        ),
        Container(
          margin: EdgeInsets.only(top: 7),
          child: Text(
            usuario,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          child: Text(email),
        ),
      ],
    ));
  }
}
