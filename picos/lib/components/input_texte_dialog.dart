import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputTextDialog extends StatelessWidget {

  String label;
  IconButton icon;
  Function(String) onSaved;

  InputTextDialog(String label, IconButton icon, Function(String) onSaved){
    this.label = label;
    this.icon = icon;
    this.onSaved = onSaved;
  } 

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top: 30),
      width: MediaQuery.of(context).size.width / 1,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20,
            )
        ]),
        child: TextFormField(
          decoration: InputDecoration(
            icon: IconButton(icon: icon, onPressed: () {}),
            border: InputBorder.none,
            hintText: label,
          ),
          onChanged: onSaved,
        ),
      ),
    );
  }
}