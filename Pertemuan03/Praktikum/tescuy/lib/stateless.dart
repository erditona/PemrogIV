import 'package:flutter/material.dart';

class MyStateless extends StatelessWidget {
  const MyStateless({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: const SafeArea(
            child:
                Text('selamat datang di flutter. ini adalah statefull widget')),
      ),
    );
  }
}
