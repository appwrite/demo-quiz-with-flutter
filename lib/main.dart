import 'package:flutter/material.dart';
import 'package:flutter_appwrite_quizeee/built_with_appwrite_wrapper.dart';

import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appwrite Quizeee',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: BuiltWithAppwriteWrapper(child: HomePage()),
    );
  }
  /* Programs must be written for people to read, and only incidentally for machines to execute. */
}
