import 'package:flutter/material.dart';

class Theme {
  static ThemeData themeData = ThemeData(
    colorSchemeSeed: Color(0xFF37A0EA),
    extensions: [
      AppTheme(
          white: Colors.white,
          blue: Color(0XFF37A0EA),
          naveBlue: Color(0xFF76DEFC),
          darkBlue: Color(0xFF2A8FD7),
          lightBlue: Color(0xFF60BBFB),
          greyBlue: Color(0xFF99D4FF),
          black500: Color(0xFF272727),
          blackText: Color(0xFF2E2E2E),
          black: Colors.black,
          grey: Color(0xFFF3F6F9))
    ],
  );
}

class AppTheme extends ThemeExtension<AppTheme> {
  final Color white;
  final Color blue;
  final Color naveBlue;
  final Color darkBlue;
  final Color lightBlue;
  final Color greyBlue;
  final Color black500;
  final Color blackText;
  final Color black;
  final Color grey;

  const AppTheme({
    required this.white,
    required this.blue,
    required this.naveBlue,
    required this.darkBlue,
    required this.lightBlue,
    required this.greyBlue,
    required this.black500,
    required this.blackText,
    required this.black,
    required this.grey,
  });

  @override
  AppTheme copyWith({
    Color? white,
    Color? blue,
    Color? naveBlue,
    Color? darkBlue,
    Color? lightBlue,
    Color? greyBlue,
    Color? black500,
    Color? blackText,
    Color? black,
    Color? grey,
  }) {
    return AppTheme(
      white: white ?? this.white,
      blue: blue ?? this.blue,
      naveBlue: naveBlue ?? this.naveBlue,
      darkBlue: darkBlue ?? this.darkBlue,
      lightBlue: lightBlue ?? this.lightBlue,
      greyBlue: greyBlue ?? this.greyBlue,
      black500: black500 ?? this.black500,
      blackText: blackText ?? this.blackText,
      black: black ?? this.black,
      grey: grey ?? this.grey,
    );
  }

  @override
  AppTheme lerp(covariant AppTheme? other, double t) {
    return AppTheme(
      white: Color.lerp(white, other!.white, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      naveBlue: Color.lerp(naveBlue, other.naveBlue, t)!,
      darkBlue: Color.lerp(darkBlue, other.darkBlue, t)!,
      lightBlue: Color.lerp(lightBlue, other.lightBlue, t)!,
      greyBlue: Color.lerp(greyBlue, other.greyBlue, t)!,
      black500: Color.lerp(black500, other.black500, t)!,
      blackText: Color.lerp(blackText, other.blackText, t)!,
      black: Color.lerp(black, other.black, t)!,
      grey: Color.lerp(grey, other.grey, t)!,
    );
  }
}
