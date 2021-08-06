import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class smallfont extends StatelessWidget {
  final String value;

  const smallfont({Key key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 14;
    return Container(
      child: Text(
        value,
        style: GoogleFonts.lato(
          fontSize: size,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class bigfont extends StatelessWidget {
  final String value;
  const bigfont({Key key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        value,
        style: GoogleFonts.lato(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
