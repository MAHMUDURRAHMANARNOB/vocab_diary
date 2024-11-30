import 'package:flutter/material.dart';
import 'package:vocabulary_app/HomePage.dart';

void main() {
  runApp(const VocabNotes());
}

class VocabNotes extends StatelessWidget {
  const VocabNotes({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: HomePage(),
    );
  }
}
