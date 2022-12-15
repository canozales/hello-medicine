import 'package:flutter/material.dart';
import 'package:medhealth/rolecustomer/pages/splash_screen.dart';
import 'package:medhealth/theme.dart';

import 'dismisskeyboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "HelloMedicine+",
        theme: ThemeData(primaryColor: redColor),
        home: SplashScreen(),
      ),
    );
  }
}
