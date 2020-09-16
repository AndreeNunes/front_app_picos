import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class IsEmpty extends StatelessWidget {

  String titulo;
  String descricao;
  BuildContext context;

  IsEmpty(String titulo, String descricao, BuildContext context){
    this.titulo = titulo;
    this.descricao = descricao;
    this.context = context;
  }

  @override
  Widget build(context) {
    return Flushbar(
      title: titulo,
      icon: Icon(Icons.warning),
      backgroundColor: Colors.purpleAccent,
      message: descricao,
      duration: Duration(seconds: 3),
    )..show(context);
  }
}