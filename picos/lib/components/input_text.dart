import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputText extends StatelessWidget {

  String label;
  IconButton icon;
  Function(String) onSaved;
  var focus = FocusNode();
  TextInputType textInputType;
  bool obscureText;

  InputText(String label, IconButton icon, Function(String) onSaved, {
      FocusNode focus,
      TextInputType textInputType,
      bool obscureText,
  }){
    this.label = label;
    this.icon = icon;
    this.onSaved = onSaved;
    this.focus = focus ?? null;
    this.textInputType = textInputType ?? null;
    this.obscureText = obscureText ?? false;
  } 

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.only(left: 40, right: 40),
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
          autofocus: false,
          focusNode: focus,
          obscureText: obscureText,
          keyboardType: textInputType != null ? textInputType : TextInputType.text,
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