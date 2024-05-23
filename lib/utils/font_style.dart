import 'package:flutter/material.dart';
import 'package:tracker/utils/app_colour.dart';

class FTextStyle {
  static const appTitleStyle = TextStyle(
    fontFamily: 'Poppins-Regular',
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );
  static const heading = TextStyle(
    fontFamily: 'Poppins-Regular',
    fontSize: 14,
    color: Colors.black,
    fontWeight: FontWeight.w600,
  );


  static const subtitle = TextStyle(
    fontFamily: 'Poppins-Regular',
    fontSize: 14,
    color: Colors.grey,
    fontWeight: FontWeight.w400,
  );


  static const whiteTitle = TextStyle(
    fontFamily: 'Poppins-Regular',
    fontSize: 15,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  static const pinkTitle = TextStyle(
    fontFamily: 'Poppins-Regular',
    fontSize: 12,
    color: Colors.pinkAccent,
    fontWeight: FontWeight.w600,
  );

  static const error = TextStyle(
    fontFamily: 'Poppins-Regular',
    fontSize: 12,
    color: Colors.red,
    fontWeight: FontWeight.w600,
  );

  static const hintStyle = TextStyle(
      fontFamily: 'Poppins-Regular',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.hintColour);

}