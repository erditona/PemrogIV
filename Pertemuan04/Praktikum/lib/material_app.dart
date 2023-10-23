import 'package:flutter/material.dart';
import 'package:praktikum_p4/material_page.dart';

class AppMaterial extends StatelessWidget {
  const AppMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      title: 'Tempat Wisata Bandung',
      home: const DetailScreen(),
    );
  }
}
