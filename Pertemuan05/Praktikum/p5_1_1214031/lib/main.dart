import 'package:flutter/material.dart';
import 'package:praktikum_p4/main_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tempat Wisata Bandung',
      theme: ThemeData(),
      home: const MainScreen(),
    );
  }
}
