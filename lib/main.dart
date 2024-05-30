import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicapp/Views/Homepage/homepage.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      title: 'BeeeZ',
      theme: ThemeData(
        fontFamily: '',
        appBarTheme:
            AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
      ),
    );
  }
}
