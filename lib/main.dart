import 'package:flutter/material.dart';
import 'package:safe_pass_app/screen/main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Safe Password application',
      home: MainScreen(),
    );
  }
}
