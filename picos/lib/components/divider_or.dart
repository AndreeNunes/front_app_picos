import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DividerOr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50.0, right: 50.0),
      child: Container(
        child: Row(children: <Widget>[
          Expanded(
            child: Divider(
              color: Colors.black45,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13, right: 13),
            child: Text(
              "OU",
              style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.headline1,
                  fontSize: 13,
                  fontWeight: FontWeight.w300),
            ),
          ),
          Expanded(
              child: Divider(
            color: Colors.black45,
          )),
        ]),
      ),
    );
  }
}