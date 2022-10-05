//import packages

import 'package:flutter/material.dart';
import 'package:flutter_appwrite_quizeee/built_with_appwrite_wrapper.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appwrite Quizeee',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const BuiltWithAppwriteWrapper(child: HomePage()),
    );
  }
}
