import 'package:flutter/material.dart';

class PrimaryTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Login",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600
      ),
    );
  }
}