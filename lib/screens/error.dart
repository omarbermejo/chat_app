

import 'package:flutter/material.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Image.network(Image.network('https://static.vecteezy.com/system/resources/previews/014/168/168/non_2x/error-icon-cartoon-style-vector.jpg') as String),
                Text('!Ups... Lo sentimos estamos trabajando para mejorar el chat.'),
            ],
          ),
        ),
      ),
    );
  }
}