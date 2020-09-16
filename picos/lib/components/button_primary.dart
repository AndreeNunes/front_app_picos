import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonPrimary extends StatelessWidget {

  Function onTap;
  String label;

  ButtonPrimary(Function onTap, String label){
    this.onTap = onTap;
    this.label = label;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1,
      padding: EdgeInsets.only(left: 40, right: 40),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 10, right: 10),
          width: 340,
          height: 45,
          decoration: BoxDecoration(
              color: Color(0xcc4B0082),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                )
              ]),
          child: Text(
            label,
            style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.headline1,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}