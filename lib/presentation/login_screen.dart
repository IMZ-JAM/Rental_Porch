import 'package:flutter/material.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rental-Porch'),
      ),
      body: const Center(
        child: Text('Welcome to Rental-Porch'),
      ),
    );
  }
}