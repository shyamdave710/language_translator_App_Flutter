import 'package:flutter/material.dart';
import 'package:language_translator/language_translator_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Language Translation Application',
      debugShowCheckedModeBanner: false,
      home: LanguageTranslationPage(),
    );
  }
}