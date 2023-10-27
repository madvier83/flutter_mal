import 'package:flutter/material.dart';

class Heading2 extends StatelessWidget {
  final String text;
  const Heading2(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 22),
    );
  }
}
