import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kTempTextStyle = GoogleFonts.asap(
  fontSize: 100.0,
);

final kButtonTextStyle = GoogleFonts.asap(
  fontSize: 30.0,
);

final kConditionTextStyle = GoogleFonts.asap(
  fontSize: 100.0,
);

final kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: const Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: GoogleFonts.asap(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);
