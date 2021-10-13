import 'package:flutter/material.dart';
import 'package:safe_pass_app/screen/detail.dart';
import 'package:safe_pass_app/screen/form.dart';
import 'package:safe_pass_app/screen/main.dart';

void main() {
  //
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Safe Password application',
      initialRoute: '/main',
      routes: {
        '/main': (context) => const MainScreen(),
        '/detail': (context) => const DetailScreen(),
        '/form': (context) => const FormScreen(),
      },
      home: Container(),
    );
  }
}
