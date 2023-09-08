// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyButtoN extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButtoN({
    super.key,
    required this.text,
    required this.onPressed,
  });
  

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      child: Text(text),
    );
  }
}
