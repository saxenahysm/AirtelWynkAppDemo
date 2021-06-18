import 'package:airtel_wynk_template/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'utils/custom_colors.dart';

void main() {
  runApp(MaterialApp(
    title: "Airtel Wynk Template",
    home: HomeScreen(),
    // theme: ThemeData(primaryColor: Colors.deepOrangeAccent),
    theme: CustomColor.defaultTheme,
  ));
}
