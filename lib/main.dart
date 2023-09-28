import 'package:flutter/material.dart';
import 'package:rental_porch_app/presentation/splash_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',      
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}