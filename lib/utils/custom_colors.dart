import 'package:flutter/material.dart';

const PrimaryColor = const Color(0xFFBD520A);
const PrimaryColorLight = const Color(0xFFCD6019);
const PrimaryColorDark = const Color(0xFF973E04);

const SecondaryColor = const Color(0xFFb2dfdb);
const SecondaryColorLight = const Color(0xFFe5ffff);
const SecondaryColorDark = const Color(0xFF82ada9);

const Background = const Color(0xFFfffdf7);
const TextColor = const Color(0xff3d3a3a);

class CustomColor {
  static final ThemeData defaultTheme = _buildMyTheme();

  static ThemeData _buildMyTheme() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      accentColor: SecondaryColor,
      accentColorBrightness: Brightness.dark,
      primaryColor: PrimaryColor,
      primaryColorDark: PrimaryColorDark,
      primaryColorLight: PrimaryColorLight,
      primaryColorBrightness: Brightness.dark,
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: SecondaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
      scaffoldBackgroundColor: Background,
      cardColor: Background,
      textSelectionColor: PrimaryColorLight,
      backgroundColor: Background,
      textTheme: base.textTheme.copyWith(
          title: base.textTheme.title!.copyWith(color: TextColor),
          body1: base.textTheme.body1!.copyWith(color: TextColor),
          body2: base.textTheme.body2!.copyWith(color: TextColor)),
    );
  }
}
