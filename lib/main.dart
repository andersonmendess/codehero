import 'package:code_hero/pages/home/home_controller.dart';
import 'package:code_hero/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD42026)),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => HomeController(),
          ),
        ],
        child: const HomePage(),
      ),
    );
  }
}
